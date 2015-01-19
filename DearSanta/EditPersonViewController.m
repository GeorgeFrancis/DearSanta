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
    
    NSNumber *presentPrice = [self.currentPerson personPresentPrice];
    self.presentPriceField.text = [NSString stringWithFormat:@"%@",presentPrice];

    if ([[self.currentPerson personPresentBrought] boolValue] == YES) {
        self.presentBroughtSwitch.on = YES;
    }
    
    else{
        self.presentBroughtSwitch.on = NO;
    }
    
    
  //  bool *presentBrought = [[self.currentPerson personPresentBrought] boolValue];
 //   self.presentBroughtSwitch.state = presentBrought;
//
//    BOOL isGPSOn = [[entity useGPS] boolValue];
    
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
    
    
     AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
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
    
    
    NSNumber *presentPrice = @([self.presentPriceField.text floatValue]);
    
    _currentPerson.personPresentPrice = presentPrice;
    
    
    
  //  _currentPerson.personPresentBrought = [self.presentBroughtSwitch.state boolValue];


    
    if (self.presentBroughtSwitch.on) {
        
        
        _currentPerson.personPresentBrought = [NSNumber numberWithBool:YES];
    }
    
    else{
        _currentPerson.personPresentBrought = [NSNumber numberWithBool:NO];
    }

     [delegate saveContext];
    
    
//    AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication] delegate];
//    [myApp saveContext];

}

@end
