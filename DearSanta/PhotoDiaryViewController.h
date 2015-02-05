//
//  PhotoDiaryViewController.h
//  BabyDiary
//
//  Created by George Francis on 20/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "PhotoViewerViewController.h"
#import "Photo.h"
#import "AppDelegate.h"
#import "FetchResultViewController.h"

@class PhotoViewerViewController;

@interface PhotoDiaryViewController : ViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *photoDiaryCollectionView;


- (IBAction)goHomePressed:(id)sender;
- (IBAction)viewTimeLapsePressed:(id)sender;


@end

