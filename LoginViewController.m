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

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [[self.loginButton layer] setMasksToBounds:YES];
    [[self.loginButton layer] setBorderWidth:2.0f];
    [[self.loginButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.loginButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    [[self.registerButton layer] setMasksToBounds:YES];
    [[self.registerButton layer] setBorderWidth:2.0f];
    [[self.registerButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.registerButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];


    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)loginButtonPressed:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordEnterTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            //Open the wall
            [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}
@end
