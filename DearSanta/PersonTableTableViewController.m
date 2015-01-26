//
//  PersonTableTableViewController.m
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "PersonTableTableViewController.h"
#import "Person.h"
#import "EditPersonViewController.h"
#import "AppDelegate.h"

@interface PersonTableTableViewController ()

@property (nonatomic, strong) NSNumber *totalCost;

@end

@implementation PersonTableTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;


- (NSManagedObjectContext *)managedObjectContext{
    
    if (_managedObjectContext == nil)
    {
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        _managedObjectContext = [delegate managedObjectContext];
    }

    return _managedObjectContext;
}

- (NSNumber*)totalCost
{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
//    fetchRequest.propertiesToFetch = @[@"personPresentPrice"];
//    
//    NSError *error;
//    NSArray *persons = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    float total = 0;
    for (Person *aPerson in self.fetchedResultsController.fetchedObjects)
    {
        total = total + aPerson.personPresentPrice.floatValue;
    }
    
    return @(total);
}

-(void)addPersonViewControllerDidSave{    
    NSError *error = nil;
    NSManagedObjectContext *context = self.managedObjectContext;
    if (![context save:&error]) {
        NSLog(@"Error! %@", error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addPersonViewControllerDidCancel:(Person *)personToDelete{
    
    NSManagedObjectContext *context = self.managedObjectContext;
    [context deleteObject:personToDelete];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    
    _managedObjectContext = self.managedObjectContext;
    
  //  [self savePresets];
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSError *error = nil;
    if (![[self fetchedResultsController]performFetch:&error]) {
        NSLog(@"Error! %@",error);
        abort();
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.navigationItem.prompt = [currencyFormatter stringFromNumber:self.totalCost];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
    
    return [secInfo numberOfObjects];
}


#pragma mark - Fetched Results Controller

-(NSFetchedResultsController *)fetchedResultsController{
    
    if (_fetchedResultsController !=nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"personName"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"personName" cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView beginUpdates];
    
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:newIndexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate: {
            Person *changePerson = [self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",changePerson.personPresent];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",changePerson.personPresentPrice];
            cell.backgroundColor = (changePerson.personPresentBrought.boolValue) ? [UIColor redColor] : [UIColor whiteColor];
            
        }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:newIndexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete   :
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            NSLog(@"A table item was moved");
            break;
        case NSFetchedResultsChangeUpdate:
            NSLog(@"A table item was updated");
            break;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    // Configure the cell...
    
//    if (indexPath.row < 10) {
//        cell.textLabel.text = @"this is test cells";
//    } else {
//        NSIndexPath *newPath = [NSIndexPath indexPathForRow:indexPath.row - 10 inSection:indexPath.section];
//        Person *person = [self.fetchedResultsController objectAtIndexPath:newPath];
//        cell.textLabel.text = person.personPresent;
//    }
//    
//    return cell;
//}
   
        NSString *pound = @"£";
    
    
    Person *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@""%@", pound,person.personPresentPrice];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",person.personPresent];
    
    cell.backgroundColor = (person.personPresentBrought.boolValue) ? [UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5]
    :[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0];
    
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];
        Person *personToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:personToDelete];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error! %@",error);
        }
        
      }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"addPerson"]) {
        AddPersonViewController *apvc = (AddPersonViewController *)[segue destinationViewController];
        apvc.delegate = self;
        
    }
    
    if ([[segue identifier]isEqualToString:@"showDetail"]) {
        EditPersonViewController *epvc = (EditPersonViewController*)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Person *selectedPerson = (Person*) [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        epvc.currentPerson = selectedPerson;
    }
    
}


@end
