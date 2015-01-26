//
//  ViewController.h
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "PersonTableTableViewController.h"


@interface ViewController : UIViewController

@property (nonatomic) BOOL showInfo;

@property (strong, nonatomic) IBOutlet UIButton *photoDiaryButton;
@property (strong, nonatomic) IBOutlet UIButton *essentialItemsButton;
@property (strong, nonatomic) IBOutlet UIButton *babyNamesButton;
@property (strong, nonatomic) IBOutlet UIButton *specialDatesButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelLeftConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonRightConstraint;

- (IBAction)infoButtonPressed:(id)sender;

@end

