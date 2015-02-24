//
//  SettingsViewController.h
//  myBump
//
//  Created by George Francis on 20/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ViewController.h"


@interface SettingsViewController : ViewController

//@property (nonatomic,strong) ViewController *viewControl;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)colourButtonPressed:(id)sender;
- (IBAction)saveDueDatePressed:(id)sender;

@end
