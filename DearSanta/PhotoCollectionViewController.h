//
//  PhotoCollectionViewController.h
//  BabyDiary
//
//  Created by George Francis on 02/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "FetchResultViewController.h"
#import "PhotoCell.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "PhotoViewerViewController.h"


@interface PhotoCollectionViewController : FetchResultViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *photoDiaryCollectionView;

@property (strong, nonatomic) NSMutableArray *photoArray;

@end

