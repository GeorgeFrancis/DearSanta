//
//  EditImportantDateViewController.m
//  BabyDiary
//
//  Created by George Francis on 11/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "EditImportantDateViewController.h"

@interface EditImportantDateViewController ()

@end

@implementation EditImportantDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.datePicker.date = self.currentDate.date;
    
    self.textField.text = [NSString stringWithFormat:@"%@",self.currentDate.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButtonPressed:(id)sender
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.currentDate.name = self.textField.text;
    
    self.currentDate.date = self.datePicker.date;
    
    [delegate saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
