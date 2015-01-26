//
//  PhotoViewerViewController.h
//  BabyDiary
//
//  Created by George Francis on 20/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "PhotoDiaryViewController.h"

@class PhotoDiaryViewController;

@interface PhotoViewerViewController : ViewController <UIAlertViewDelegate>

//@property (nonatomic,strong) PhotoDiaryViewController *photoDiaryViewController;

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;

@property (strong,nonatomic) UIImage *thisImage;
@property (strong,nonatomic) NSNumber *imageToDeleteRef;
@property (strong,nonatomic) NSNumber *rowToDelete;

- (IBAction)deletePhotoButtonPressed:(id)sender;
- (IBAction)goHomePressed:(id)sender;



@end
