//
//  ImportantDateTableViewController.m
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ImportantDateTableViewController.h"
#import "Date.h"
#import "EditImportantDateViewController.h"

@interface ImportantDateTableViewController ()

@end

@implementation ImportantDateTableViewController

@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSFetchedResultsController deleteCacheWithName:@"ImportantDates"];
    
    [self.fetchResultsController performFetch:nil];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView reloadData];
}

- (NSFetchedResultsController*)fetchResultsController

{
    if (_fetchResultsController == nil)
        
    {
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Date"];
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchRequest.sortDescriptors = @[sort];
        
        
        _fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil
                                                cacheName:@"ImportantDates"];
        
        _fetchResultsController.delegate = self;
    }
    
    return _fetchResultsController;
}

- (void)configureTableViewCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath

{
    Date *date = [self.fetchResultsController objectAtIndexPath:indexPath];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    NSString *dateTimeString = [dateFormatter stringFromDate:date.date];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dateTimeString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",date.name];
    NSDate *today = [NSDate date];
    
    NSDate *dateToNotify = date.date;
    
    
  //  NSDate *now = [NSDate date];
    int daysToAdd = -1;
    NSDate *newDate1 = [dateToNotify dateByAddingTimeInterval:60*60*24*daysToAdd];

    [self scheduleLocalNotificationWithDate:newDate1:dateTimeString];
    if (today == newDate1) {
        
        NSLog(@"alarm today");

    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.appDelegate managedObjectContext];
        Date *dateToDelete = [self.fetchResultsController objectAtIndexPath:indexPath];
        [context deleteObject:dateToDelete];
        
               NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error! %@",error);
        }
    }
}

-(void)scheduleLocalNotificationWithDate:(NSDate *)fireDate :(NSString*)dateString
{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.fireDate = fireDate;
    
    notification.alertBody = [NSString stringWithFormat:@"%@",dateString];
    notification.alertAction = @"Doctors tomorrow";
  //  notification.soundName = @"newAlarm.mp3";
    
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
}

-(void)checkForNotification
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditDates"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Date *dates = [self.fetchResultsController objectAtIndexPath:indexPath];
        [[segue destinationViewController] setCurrentDate:dates];
    }
}



@end
