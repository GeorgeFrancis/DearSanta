//
//  AddImportDatesViewController.h
//  BabyDiary
//
//  Created by George Francis on 25/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "Date.h"
#import "ImportantDatesTableViewController.h"
#import "FetchResultViewController.h"



@interface AddImportDatesViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)addDateButtonPressed:(id)sender;

@end
