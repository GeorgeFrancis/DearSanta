//
//  ForumViewController.h
//  BabyDiary
//
//  Created by George Francis on 31/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *wallObjectsArray;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UITableView *forumTableView;

@end
