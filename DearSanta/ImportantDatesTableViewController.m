//
//  ImportantDatesViewController.m
//  BabyDiary
//
//  Created by George Francis on 25/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ImportantDatesTableViewController.h"
#import "Date.h"
//#import "FetchResultViewController.h"

@interface ImportantDatesTableViewController ()

@end

@implementation ImportantDatesViewController

@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"inBaby != nil"];
    
    [self.fetchResultsController.fetchRequest setPredicate:predicate];
    [NSFetchedResultsController deleteCacheWithName:@"ImportantDates"];
    [self.fetchResultsController performFetch:nil];
    
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}

- (NSFetchedResultsController*)fetchResultsController
{
    if (_fetchResultsController == nil)
    {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Date"];
        
       
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                                  initWithKey:@"date" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchRequest.sortDescriptors = @[sort];
        
        
        _fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                     managedObjectContext:self.appDelegate.managedObjectContext
                                                                       sectionNameKeyPath:nil
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
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
}

@end
