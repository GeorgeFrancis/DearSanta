//
//  AddFavouriteNameViewController.h
//  BabyDiary
//
//  Created by George Francis on 19/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "BoysNamesViewController.h"
#import "AppDelegate.h"
#import "BabyName.h"

@interface AddFavouriteNameViewController : ViewController

@property (strong,nonatomic) NSString *currentName;

@property (strong, nonatomic) IBOutlet UILabel *babyNameLabel;

- (IBAction)saveData:(id)sender;

//-(void)addPersonViewControllerDidSave;

@end
