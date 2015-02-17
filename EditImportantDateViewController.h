//
//  EditImportantDateViewController.h
//  BabyDiary
//
//  Created by George Francis on 11/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "ImportantDateTableViewController.h"
#import "AppDelegate.h"
#import "Date.h"


@interface EditImportantDateViewController : ViewController

@property (strong,nonatomic) Date *currentDate;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *textField;

- (IBAction)saveButtonPressed:(id)sender;
@end
