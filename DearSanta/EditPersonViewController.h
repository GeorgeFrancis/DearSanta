//
//  EditPersonViewController.h
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface EditPersonViewController : UIViewController

@property (nonatomic, strong) Person *currentPerson;
@property (strong, nonatomic) IBOutlet UITextField *personNameField;
@property (strong, nonatomic) IBOutlet UITextField *presentNameField;
@property (strong, nonatomic) IBOutlet UITextField *presentPriceField;
@property (strong, nonatomic) IBOutlet UISwitch *presentBroughtSwitch;

@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;


- (IBAction)startEditing:(id)sender;
- (IBAction)doneEditing:(id)sender;



@end
