//
//  ViewController.m
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "Date.h"
#import "Item.h"

@interface ViewController ()

@property (nonatomic, assign) AppDelegate *app;
@property (nonatomic, strong) NSNumber *totalCost;

@end

@implementation ViewController


- (void)viewDidLoad
{
     [super viewDidLoad];
    
    self.showInfo = NO;
    [self setUpButtons];

    self.app = [[UIApplication sharedApplication] delegate];
    
    [NSFetchedResultsController deleteCacheWithName:@"homeDates"];
    
    [self.fetchResultsController performFetch:nil];
}

- (void)dealloc
{
    self.fetchResultsController.delegate = nil;
}

- (NSFetchedResultsController*)fetchResultsController

{
    if (_fetchResultsController == nil)
        
    {
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchRequest.sortDescriptors = @[sort];
        
        
        _fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.app.managedObjectContext sectionNameKeyPath:nil
                                                                                cacheName:@"homeDates"];
        
        _fetchResultsController.delegate = self;
    }
    
    return _fetchResultsController;
}

- (AppDelegate*)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"ViewDidAppear is %@",self.totalCost);
    
    [self displayDataInLabel];
}

-(void)viewWillAppear:(BOOL)animated
{
      NSLog(@"viewWillAppear is %@",self.totalCost);
}

-(void)displayDataInLabel
{
    NSString *name = @"";
    
    if (self.fetchResultsController.fetchedObjects.count > 0 ) {
        
        Item *thisItem = [_fetchResultsController.fetchedObjects objectAtIndex:0];
        
        name = thisItem.name;
    }
    
    NSLog(@"the item name is %@", name);
    
}

   
        

    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
//    dateFormatter.timeStyle = NSDateFormatterShortStyle;
//    dateFormatter.dateStyle = NSDateFormatterLongStyle;
//    NSString *dateTimeString = [dateFormatter stringFromDate:date.date];
//    
//    NSLog(@"the date is %@",dateTimeString);
//    
//    [NSString stringWithFormat:@"%@",dateTimeString];



- (NSNumber*)totalCost
{
    float total = 0;
    for (Item *aItem in self.fetchResultsController.fetchedObjects)
    {
        total = total + aItem.quantity.floatValue;
    }
    
    return @(total);

    
    
    
//    //    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
//    //    fetchRequest.propertiesToFetch = @[@"personPresentPrice"];
//    //
//    //    NSError *error;
//    //    NSArray *persons = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    float total = 0;
//    for (Person *aPerson in self.fetchedResultsController.fetchedObjects)
//    {
//        total = total + aPerson.personPresentPrice.floatValue;
//    }
//    
//    return @(total);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpButtons
{
    [[self.photoDiaryButton layer] setMasksToBounds:YES];
  //  [[self.photoDiaryButton layer] setBorderWidth:2.0f];
  //  [[self.photoDiaryButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
 //   [[self.photoDiaryButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];
    
    [[self.essentialItemsButton layer] setMasksToBounds:YES];
 //   [[self.essentialItemsButton layer] setBorderWidth:2.0f];
 //   [[self.essentialItemsButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
  //  [[self.essentialItemsButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];
    
    [[self.specialDatesButton layer] setMasksToBounds:YES];
  //  [[self.specialDatesButton layer] setBorderWidth:2.0f];
  //  [[self.specialDatesButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
   // [[self.specialDatesButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];
    
    [[self.babyNamesButton layer] setMasksToBounds:YES];
  //  [[self.babyNamesButton layer] setBorderWidth:2.0f];
  //  [[self.babyNamesButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
  //  [[self.babyNamesButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];
    
    [[self.forumButton layer] setMasksToBounds:YES];
   // [[self.forumButton layer] setBorderWidth:2.0f];
   // [[self.forumButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
 //   [[self.forumButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];
    
  //  [[self.infoButton layer] setBorderWidth:2.0f];
  //  [[self.infoButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
  //  [[self.infoButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];
    
 //   [[self.favouritesButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];

}

- (void)setShowInfo:(BOOL)showInfo
{
    [self.view layoutIfNeeded];
    
    if (showInfo)
    {
        self.buttonRightConstraint.constant = 20;
        self.labelLeftConstraint.constant = 0;
    }
    else
    {
        self.buttonRightConstraint.constant = 0;
        self.labelLeftConstraint.constant = self.view.frame.size.width;
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
    
    _showInfo = showInfo;
}

- (IBAction)infoButtonPressed:(id)sender
{
    self.showInfo = !self.showInfo;
}

@end
