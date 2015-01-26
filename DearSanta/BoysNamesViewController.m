//
//  BoysNamesViewController.m
//  BabyDiary
//
//  Created by George Francis on 19/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "BoysNamesViewController.h"
#import "AddFavouriteNameViewController.h"

@interface BoysNamesViewController ()



@end

@implementation BoysNamesViewController

@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setBackgroundView:nil];
    
    [[self.boysButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.boysButton layer] setBorderWidth:1.3f];
    [[self.boysButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    [[self.girlsButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.girlsButton layer] setBorderWidth:1.3f];
    [[self.girlsButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
     for (UIButton *btn in self.allButtons) {
        
        [[btn layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
        [[btn layer] setBorderWidth:1.3f];
        [[btn layer] setCornerRadius:10.0f];
        [[btn layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    }
    
    [self.fetchResultsController.fetchRequest setPredicate:[self predicateForLetter:nil isBoy:NO fetchAll:YES]];
    [NSFetchedResultsController deleteCacheWithName:@"BabyNames"];
    [self.fetchResultsController performFetch:nil];
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
                                                                                cacheName:@"BabyNames"];
        _fetchResultsController.delegate = self;
    }
    
    return _fetchResultsController;
}

- (NSPredicate*)predicateForLetter:(NSString*)letter isBoy:(BOOL)isBoy fetchAll:(BOOL)fetchAll
{
    NSCompoundPredicate *predicate;
    
    NSMutableArray *predicates = [[NSMutableArray alloc]init];
    
    if (letter.length > 0)
    {
        [predicates addObject:[NSPredicate predicateWithFormat:@"name beginswith %@", self.searchLetter]];
    }
    if (fetchAll == NO)
    {
        [predicates addObject:[NSPredicate predicateWithFormat:@"isBoy == %@", @(isBoy)]];
    }
    
    if (predicates.count > 0)
    {
        predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    }
    
    return predicate;
}

#pragma mark - Table view data source

- (void)configureTableViewCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    BabyName *babyName = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = babyName.name;
    cell.detailTextLabel.text = babyName.nameOrigin;
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    
    cell.backgroundColor = (babyName.inBaby) ? [UIColor colorWithRed:1 green:0.553 blue:0.118 alpha:0.5] : [UIColor clearColor];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AddName"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BabyName *babyName = [self.fetchResultsController objectAtIndexPath:indexPath];
        [[segue destinationViewController] setBabyName:babyName];
    }
}

- (IBAction)filterLetterPressed:(id)sender
{
    self.searchLetter = [sender titleForState:UIControlStateNormal];
    
    [self.fetchResultsController.fetchRequest setPredicate:[self predicateForLetter:self.searchLetter isBoy:NO fetchAll:NO]];
    [NSFetchedResultsController deleteCacheWithName:@"BabyNames"];
    [self.fetchResultsController performFetch:nil];
    [self.tableView reloadData];
}

- (IBAction)boysButtonPressed:(id)sender
{
    [self.fetchResultsController.fetchRequest setPredicate:[self predicateForLetter:self.searchLetter isBoy:YES fetchAll:NO]];
    [NSFetchedResultsController deleteCacheWithName:@"BabyNames"];
    [self.fetchResultsController performFetch:nil];
    [self.tableView reloadData];
}

- (IBAction)girlsButtonPressed:(id)sender
{
    [self.fetchResultsController.fetchRequest setPredicate:[self predicateForLetter:self.searchLetter isBoy:NO fetchAll:NO]];
    [NSFetchedResultsController deleteCacheWithName:@"BabyNames"];
    [self.fetchResultsController performFetch:nil];
    [self.tableView reloadData];
}

- (IBAction)popToHomePushed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
