//
//  ImportantDateTableViewController.m
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ImportantDateTableViewController.h"
#import "Date.h"

@interface ImportantDateTableViewController ()

@end

@implementation ImportantDateTableViewController

@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSFetchedResultsController deleteCacheWithName:@"ImportantDates"];
    
    [self.fetchResultsController performFetch:nil];
    
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
    
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    NSString *dateTimeString = [dateFormatter stringFromDate:date.date];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dateTimeString];
    NSDate *today = [NSDate date];
    
    if (date.date == today) {
        
         [self scheduleLocalNotificationWithDate:today];
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

-(void)scheduleLocalNotificationWithDate:(NSDate *)fireDate{
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.fireDate = fireDate;
    
    notification.alertBody = @"Your Notification";
    notification.alertAction = @"Doctors tomorrow";
  //  notification.soundName = @"newAlarm.mp3";
    
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
}

-(void)checkForNotification {
    
    

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
