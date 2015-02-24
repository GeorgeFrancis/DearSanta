//
//  SettingsViewController.m
//  myBump
//
//  Created by George Francis on 20/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController ()

@property UIColor *cantaloupe;
@property UIColor *honeyDraw;
@property UIColor *lavender;
@property UIColor *carnation;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self setUpColors];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpColors
{
    self.cantaloupe = [UIColor colorWithRed:1 green:0.8 blue:0.4 alpha:1]; /*Cantaloupe #ffcc66*/
    self.honeyDraw = [UIColor colorWithRed:0.8 green:1 blue:0.4 alpha:1]; /*Honey Draw #ccff66*/
    self.lavender = [UIColor colorWithRed:0.8 green:0.4 blue:1 alpha:1]; /*Lavender #cc66ff*/
    self.carnation = [UIColor colorWithRed:1 green:0.435 blue:0.812 alpha:1]; /*Carnation #ff6fcf*/
}

-(void)saveDueDate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *babyDueDate = [self.datePicker date];
    [defaults setObject:babyDueDate forKey:@"DueDate"];
}


- (IBAction)colourButtonPressed:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    NSData *colourData;
    
    if (btn.tag == 0)
    {
        colourData = [NSKeyedArchiver archivedDataWithRootObject:self.cantaloupe];
    }
    if (btn.tag == 1)
    {
        colourData = [NSKeyedArchiver archivedDataWithRootObject:self.honeyDraw];
    }
    if (btn.tag == 2)
    {
        colourData = [NSKeyedArchiver archivedDataWithRootObject:self.lavender];
    }
    if (btn.tag == 3)
    {
        colourData = [NSKeyedArchiver archivedDataWithRootObject:self.carnation];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:colourData forKey:@"ColorTheme"];
    
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate setAppearance];
    
    self.navigationController.navigationBar.barTintColor = [UINavigationBar appearance].barTintColor;
}

- (IBAction)saveDueDatePressed:(id)sender
{
    [self saveDueDate];
}

@end
