//
//  RegisterViewController.h
//  BabyDiary
//
//  Created by George Francis on 31/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)signUpButtonPressed:(id)sender;

@end
