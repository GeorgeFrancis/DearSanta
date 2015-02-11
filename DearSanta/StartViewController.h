//
//  StartViewController.h
//  BabyDiary
//
//  Created by George Francis on 06/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "FetchResultViewController.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface StartViewController : FetchResultViewController

@property (nonatomic) BOOL showInfo;

@property (strong, nonatomic) IBOutlet UIButton *photoDiaryButton;
@property (strong, nonatomic) IBOutlet UIButton *essentialItemsButton;
@property (strong, nonatomic) IBOutlet UIButton *babyNamesButton;
@property (strong, nonatomic) IBOutlet UIButton *specialDatesButton;
@property (strong, nonatomic) IBOutlet UIButton *forumButton;

@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelLeftConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonRightConstraint;

- (IBAction)infoButtonPressed:(id)sender;



@end
