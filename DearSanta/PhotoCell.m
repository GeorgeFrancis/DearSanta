//
//  PhotoCell.m
//  BabyDiary
//
//  Created by George Francis on 20/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property(nonatomic, strong) IBOutlet UIImageView *photoImageView;

@end

@implementation PhotoCell

- (void) setAsset:(ALAsset *)asset
{
    _asset = asset;
    self.photoImageView.image = [UIImage imageWithCGImage:(__bridge CGImageRef)(_asset)];
}


-(void)loadCell:(UIImage *)Image
{
    _image = Image;
    self.photoImageView.image = self.image;
}

@end