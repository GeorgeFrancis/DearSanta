//
//  AddImportantDateViewController.h
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "Date.h"
#import "AppDelegate.h"

@interface AddImportantDateViewController : ViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *dateNameTextField;


- (IBAction)addDateButtonPressed:(id)sender;


@end
