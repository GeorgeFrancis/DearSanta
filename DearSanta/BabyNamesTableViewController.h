//
//  BabyNamesTableViewController.h
//  BabyDiary
//
//  Created by George Francis on 06/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyName.h"

@protocol BabyNamesTableViewControllerDelegate;

@interface BabyNamesTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *content;

@property (weak, nonatomic) id<BabyNamesTableViewControllerDelegate> delegate;


@property (weak, nonatomic) BabyName *currentBabyName;



@end


@protocol BabyNamesTableViewControllerDelegate

-(void)addPersonViewControllerDidSave;
-(void)addPersonViewControllerDidCancel:(BabyName *)personToDelete;

@end