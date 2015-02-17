//
//  UploadImageViewController.h
//  BabyDiary
//
//  Created by George Francis on 31/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadImageViewController : UIViewController <UIPickerViewDelegate>

@property (strong, nonatomic) NSString *titleString;

@property (strong, nonatomic) IBOutlet UITextField *addCommentTextField;
@property (strong, nonatomic) IBOutlet UITextField *addTitleTextField;

@property (strong, nonatomic) IBOutlet UIImageView *imageToUpload;

@property (nonatomic, strong) NSString *username;

- (IBAction)PickfromLibraryButtonPressed:(id)sender;
- (IBAction)uploadButtonPressed:(id)sender;

@end
