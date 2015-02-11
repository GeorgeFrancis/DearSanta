//
//  SequenceViewController.h
//  BabyDiary
//
//  Created by George Francis on 10/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "FetchResultViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"


@interface SequenceViewController : FetchResultViewController

@property (strong, nonatomic) IBOutlet UIImageView *sequenceImageView;

- (IBAction)playButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;

@end
