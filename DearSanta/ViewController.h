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



@interface ViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;

@property (nonatomic) BOOL showInfo;
@property (nonatomic, retain) NSArray *wallObjectsArray;

@property (strong, nonatomic) IBOutlet UIButton *photoDiaryButton;
@property (strong, nonatomic) IBOutlet UIButton *essentialItemsButton;
@property (strong, nonatomic) IBOutlet UIButton *babyNamesButton;
@property (strong, nonatomic) IBOutlet UIButton *specialDatesButton;
@property (strong, nonatomic) IBOutlet UIButton *forumButton;
@property (strong, nonatomic) IBOutlet UIButton *favouritesButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;

@property (strong, nonatomic) IBOutlet UIButton *profileButton;
@property (strong, nonatomic) IBOutlet UIView *gradientView;
@property (strong, nonatomic) IBOutlet UIView *backGroundView;
@property (strong, nonatomic) IBOutlet UIImageView *lowerBackground;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *latestQuestionLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelLeftConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonRightConstraint;

- (IBAction)forumButtonPressed:(id)sender;
- (IBAction)profileButtonPressed:(id)sender;
- (IBAction)settingsButtonPressed:(id)sender;
- (IBAction)communityButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingButton;

-(void)updateGradient;

@end

