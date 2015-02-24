//
//  LoginViewController.m
//  BabyDiary
//
//  Created by George Francis on 31/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (assign, nonatomic) BOOL loggedIn;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loggedIn = NO;
    
    NSData *colourData = [[NSUserDefaults standardUserDefaults]objectForKey:@"ColorTheme"];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colourData];
    [[self.loginButton layer] setMasksToBounds:YES];
    self.loginButton.backgroundColor = color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordEnterTextField resignFirstResponder];
}

- (IBAction)loginButtonPressed:(id)sender
{
    NSString *loginUserName = self.userNameTextField.text;
    NSString *loginPassword = self.passwordEnterTextField.text;
    
    NSString *newUserString = [loginUserName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newPasswordString = [loginPassword stringByReplacingOccurrencesOfString:@" " withString:@""];


    
    [PFUser logInWithUsernameInBackground:newUserString password:newPasswordString block:^(PFUser *user, NSError *error) {
        if (user) {
            //Open the wall
            
            [self presentAlertMessage:nil];
            
            
                    } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

-(void)presentAlertMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setDelegate:self];
    
    alert = [[UIAlertView alloc]initWithTitle:@"stay logged in" message:message delegate:self cancelButtonTitle:@"yes" otherButtonTitles:@"no",nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        self.loggedIn = YES;
        [[NSUserDefaults standardUserDefaults] setBool:self.loggedIn forKey:@"loggedIn"];
        [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
    }
    else if (buttonIndex == 1)
    {
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        NSLog(@"no pressed");
    }
}

@end
