//
//  EditPersonViewController.m
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "EditPersonViewController.h"
#import "AppDelegate.h"

@interface EditPersonViewController ()

@end

@implementation EditPersonViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.personNameField.text = [self.currentPerson personName];
    self.presentNameField.text = [self.currentPerson personPresent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startEditing:(id)sender {
    
    self.personNameField.enabled = YES;
    self.presentNameField.enabled = YES;
    self.presentPriceField.enabled = YES;
    
    self.personNameField.borderStyle = UITextBorderStyleRoundedRect;
    self.presentNameField.borderStyle = UITextBorderStyleRoundedRect;
    self.presentPriceField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.editButton.hidden = YES;
    self.doneButton.hidden = NO;

}

- (IBAction)doneEditing:(id)sender {
    
    self.personNameField.enabled = NO;
    self.presentNameField.enabled = NO;
    self.presentPriceField.enabled = NO;
    
    self.personNameField.borderStyle = UITextBorderStyleNone;
    self.presentNameField.borderStyle = UITextBorderStyleNone;
    self.presentPriceField.borderStyle = UITextBorderStyleNone;
    
    self.editButton.hidden = NO;
    self.doneButton.hidden = YES;
    
    _currentPerson.personName = self.personNameField.text;
    _currentPerson.personPresent = self.presentNameField.text;
    
    AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [myApp saveContext];

}

@end
