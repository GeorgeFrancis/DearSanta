//
//  AddDateViewController.h
//  BabyDiary
//
//  Created by George Francis on 06/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImportantDate.h"

@protocol AddDateViewControllerDelegate;

@interface AddDateViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) id<AddDateViewControllerDelegate> delegate;

@property (weak, nonatomic) ImportantDate *currentImportantDate;


- (IBAction)saveDate:(id)sender;




@end

@protocol AddPersonViewControllerDelegate

@end
