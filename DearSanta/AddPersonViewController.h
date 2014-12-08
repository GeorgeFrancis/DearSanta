//
//  AddPersonViewController.h
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@protocol AddPersonViewControllerDelegate;

@interface AddPersonViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *personNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *presentTextField;
@property (strong, nonatomic) IBOutlet UITextField *presentPriceTextField;

@property (weak, nonatomic) id<AddPersonViewControllerDelegate> delegate;

@property (weak, nonatomic) Person *currentPerson;


- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end

@protocol AddPersonViewControllerDelegate

-(void)addPersonViewControllerDidSave;
-(void)addPersonViewControllerDidCancel:(Person *)personToDelete;

@end
