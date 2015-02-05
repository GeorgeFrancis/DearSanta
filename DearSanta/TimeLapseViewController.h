//
//  TimeLapseViewController.h
//  BabyDiary
//
//  Created by George Francis on 21/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"

@interface TimeLapseViewController : ViewController

@property (nonatomic, strong) NSArray *allPhotoArray;
@property (strong, nonatomic) IBOutlet UIImageView *timeLapseImageView;

- (IBAction)playTimeLapsePressed:(id)sender;
- (IBAction)stopTimeLapsePressed:(id)sender;

@end
