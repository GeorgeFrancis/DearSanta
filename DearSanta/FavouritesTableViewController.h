//
//  FavouritesTableViewController.h
//  BabyDiary
//
//  Created by George Francis on 19/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AddFavouriteNameViewController.h"


@interface FavouritesTableViewController : ViewController <NSFetchedResultsControllerDelegate>


@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) BabyName *currentName;

@end
