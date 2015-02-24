//
//  FavouritesTableViewController.m
//  BabyDiary
//
//  Created by George Francis on 19/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "FavouritesTableViewController.h"
#import "BabyName.h"

@interface FavouritesTableViewController ()

@end

@implementation FavouritesTableViewController

@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"inBaby != nil"];
    
    [self.fetchResultsController.fetchRequest setPredicate:predicate];
    [NSFetchedResultsController deleteCacheWithName:@"FavouriteBabyNames"];
    [self.fetchResultsController performFetch:nil];
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (NSFetchedResultsController*)fetchResultsController
{
    if (_fetchResultsController == nil)
    {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"BabyName"];
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                                  initWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchRequest.sortDescriptors = @[sort];
        
        
        _fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                     managedObjectContext:self.appDelegate.managedObjectContext
                                                                       sectionNameKeyPath:nil
                                                                                cacheName:@"FavouriteBabyNames"];
        _fetchResultsController.delegate = self;
    }
    
    return _fetchResultsController;
}

- (void)configureTableViewCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    BabyName *babyName = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = babyName.name;
    cell.detailTextLabel.text = babyName.nameOrigin;
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.appDelegate managedObjectContext];
        BabyName *babyToDelete = [self.fetchResultsController objectAtIndexPath:indexPath];
        babyToDelete.inBaby = nil;

        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error! %@",error);
        }
        
    }
}


@end
