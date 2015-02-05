//
//  AddPhotoViewController.h
//  BabyDiary
//
//  Created by George Francis on 02/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "AppDelegate.h"

@interface AddPhotoViewController : ViewController

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveButtonPressed:(id)sender;

- (IBAction)takePhotoButtonPressed:(id)sender;
- (IBAction)pickFromLibraryButtonPressed:(id)sender;

@end
