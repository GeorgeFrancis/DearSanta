//
//  TimeLapseViewController.m
//  BabyDiary
//
//  Created by George Francis on 21/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "TimeLapseViewController.h"

@interface TimeLapseViewController ()

@end

@implementation TimeLapseViewController

- (void)viewDidLoad
{
    UIImage *img = [self.allPhotoArray objectAtIndex:0];
    self.timeLapseImageView.image = img;
    
//    NSNumber *temp =  [NSNumber numberWithInt:-1];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:temp forKey:@"deleteNumberStored"];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)playAnimation
{
    self.timeLapseImageView.animationImages=self.allPhotoArray;
    self.timeLapseImageView.animationDuration= self.allPhotoArray.count/2;
    self.timeLapseImageView.animationRepeatCount=0;
    [self.timeLapseImageView startAnimating];
}

- (IBAction)playTimeLapsePressed:(id)sender {
    
    [self playAnimation];
}

- (IBAction)stopTimeLapsePressed:(id)sender {
    
    [self.timeLapseImageView stopAnimating];
}

@end
