//
//  StartViewController.m
//  BabyDiary
//
//  Created by George Francis on 06/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    
    self.showInfo = NO;
    
    //  [self.navigationController setToolbarHidden:YES];
    
    [[self.photoDiaryButton layer] setMasksToBounds:YES];
    [[self.photoDiaryButton layer] setBorderWidth:2.0f];
    [[self.photoDiaryButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.photoDiaryButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    [[self.essentialItemsButton layer] setMasksToBounds:YES];
    [[self.essentialItemsButton layer] setBorderWidth:2.0f];
    [[self.essentialItemsButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.essentialItemsButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    [[self.specialDatesButton layer] setMasksToBounds:YES];
    [[self.specialDatesButton layer] setBorderWidth:2.0f];
    [[self.specialDatesButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.specialDatesButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    [[self.babyNamesButton layer] setMasksToBounds:YES];
    [[self.babyNamesButton layer] setBorderWidth:2.0f];
    [[self.babyNamesButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.babyNamesButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    [[self.forumButton layer] setMasksToBounds:YES];
    [[self.forumButton layer] setBorderWidth:4.0f];
    [[self.forumButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.forumButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    [[self.infoButton layer] setBorderWidth:2.0f];
    [[self.infoButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.infoButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    showInfo = self.showInfo;
}

- (IBAction)infoButtonPressed:(id)sender
{
    self.showInfo = !self.showInfo;
}

@end
