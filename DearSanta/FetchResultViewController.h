//
//  FetchResultViewController.h
//  BabyDiary
//
//  Created by George Francis on 25/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"

@interface FetchResultViewController : ViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) AppDelegate *appDelegate;

@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;

- (void)configureTableViewCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

@end
