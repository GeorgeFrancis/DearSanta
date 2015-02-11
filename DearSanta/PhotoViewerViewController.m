//
//  PhotoViewerViewController.m
//  BabyDiary
//
//  Created by George Francis on 20/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "PhotoViewerViewController.h"
#import "PhotoCollectionViewController.h"


@interface PhotoViewerViewController ()



@end

@implementation PhotoViewerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageWithData:self.editPhoto.photoData];
    self.photoImageView.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)homeButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
