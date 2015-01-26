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

@property (strong,nonatomic) BabyName *babyName;

@property (strong, nonatomic) IBOutlet UILabel *babyNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *saveToFavouritesButton;

- (IBAction)saveData:(id)sender;

//-(void)addPersonViewControllerDidSave;

@end
