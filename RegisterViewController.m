//
//  RegisterViewController.m
//  BabyDiary
//
//  Created by George Francis on 31/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}


- (IBAction)signUpButtonPressed:(id)sender
{
    if ([self.userTextField.text length] > 0 && [self.passwordTextField.text length]>0 && [self.emailTextField.text length]>0)
    {
        [self registerUser];
    }
    else {
        UIAlertView *registerAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter details" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [registerAlertView show];
    }
}

-(void)registerUser
{
    PFUser *user = [PFUser user];
    //2
    user.username = self.userTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    //3
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was successful, go to the wall
            [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
            
        } else {
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

@end
