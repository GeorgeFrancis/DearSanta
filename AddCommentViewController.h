//
//  AddCommentViewController.h
//  BabyDiary
//
//  Created by George Francis on 15/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentViewController : UIViewController

@property (strong, nonatomic) NSString *questionTitle;
@property (strong, nonatomic) NSString *nextCommentString;

@property (strong, nonatomic) IBOutlet UITextField *addCommentTextField;

- (IBAction)saveCommentButtonPressed:(id)sender;

@end
