//
//  PhotoCell.h
//  BabyDiary
//
//  Created by George Francis on 20/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>



@interface PhotoCell : UICollectionViewCell

@property (nonatomic,strong) ALAsset *asset;
@property (nonatomic,strong) UIImage *image;

-(void)loadCell:(UIImage *)Image;

@end
