//
//  ItemTableViewController.m
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ItemTableViewController.h"
#import "Item.h"
#import "EditItemViewController.h"

@interface ItemTableViewController ()

@end

@implementation ItemTableViewController

@synthesize fetchResultsController = _fetchResultsController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSFetchedResultsController deleteCacheWithName:@"Items"];
    
    [self.fetchResultsController performFetch:nil];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView reloadData];

}

- (NSFetchedResultsController*)fetchResultsController

{
    
    if (_fetchResultsController == nil)
        
    {
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchRequest.sortDescriptors = @[sort];
        
        
        _fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil
                                                                                cacheName:@"Items"];
        
        _fetchResultsController.delegate = self;
    }
    
    return _fetchResultsController;
    
}

- (void)configureTableViewCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath

{
    
    Item *items = [self.fetchResultsController objectAtIndexPath:indexPath];

    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",items.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"quantity: %@",items.quantity];
    
    cell.backgroundColor = (items.isPurchased.boolValue) ? [UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0]:[UIColor clearColor];
   // [cell.contentView setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.appDelegate managedObjectContext];
        Item *itemToDelete = [self.fetchResultsController objectAtIndexPath:indexPath];
        [context deleteObject:itemToDelete];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error! %@",error);
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditItem"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Item *items = [self.fetchResultsController objectAtIndexPath:indexPath];
        [[segue destinationViewController] setEditItems:items];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
