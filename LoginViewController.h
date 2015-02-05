//
//  LoginViewController.h
//  BabyDiary
//
//  Created by George Francis on 31/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordEnterTextField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;


- (IBAction)loginButtonPressed:(id)sender;

@end
