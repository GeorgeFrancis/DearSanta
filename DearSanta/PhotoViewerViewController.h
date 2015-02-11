//
//  PhotoViewerViewController.h
//  BabyDiary
//
//  Created by George Francis on 20/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "Photo.h"
#import "AppDelegate.h"
#import "PhotoCollectionViewController.h"

@class PhotoDiaryViewController;

@interface PhotoViewerViewController : ViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;

@property (strong,nonatomic) Photo *editPhoto;

- (IBAction)homeButtonPressed:(id)sender;


@end
