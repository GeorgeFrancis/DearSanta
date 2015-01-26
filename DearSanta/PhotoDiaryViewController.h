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

@class PhotoViewerViewController;

@interface PhotoDiaryViewController : ViewController  <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) NSNumber *deleteObject;

@property (strong, nonatomic) IBOutlet UICollectionView *photoDiaryCollectionView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *timeLapseButton;


@property  (strong, nonatomic) NSNumber *numberToDelete;

- (IBAction)takePhotoButtonPressed:(id)sender;

- (IBAction)pickPhotoButtonPressed:(id)sender;
- (IBAction)goHomePressed:(id)sender;
- (IBAction)viewTimeLapsePressed:(id)sender;


-(void)deleteRow:(NSNumber*)deleteValue;


@end

