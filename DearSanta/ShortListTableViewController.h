//
//  ShortListTableViewController.h
//  BabyDiary
//
//  Created by George Francis on 06/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BabyNamesTableViewController.h"

@interface ShortListTableViewController : UITableViewController <BabyNamesTableViewControllerDelegate, NSFetchedResultsControllerDelegate>


@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) BabyName *currentBabyName;


@end
