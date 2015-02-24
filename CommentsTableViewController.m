//
//  CommentsTableViewController.m
//  BabyDiary
//
//  Created by George Francis on 15/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "CommentsTableViewController.h"
#import <Parse/Parse.h>
#import "AddCommentViewController.h"
#import "CustomTableViewCell.h"

@interface CommentsTableViewController ()

@property (strong, nonatomic) CustomTableViewCell *customCell;

@end



@implementation CommentsTableViewController

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    [self getWallImages];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor orangeColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getWallImages)
                  forControlEvents:UIControlEventValueChanged];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getWallImages];
    [self.tableView reloadData];
}

-(void) viewWillAppear: (BOOL) animated
{
    [self getWallImages];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    
    PFObject *commentObject = [self.commentsArray objectAtIndex:indexPath.row];
    
    cell.userLabel.text = [NSString stringWithFormat:@"comment by %@",[commentObject objectForKey:@"user"]];
    cell.commentLabel.text = [commentObject objectForKey:@"comment"];
    
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return self.titleNameString;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.customCell) {
            self.customCell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
            }
    
    self.customCell = (CustomTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    long chars = self.customCell.commentLabel.text.length;
    long lines = chars/10;
    CGFloat height = 100 +5*lines;

    return height;
}

-(void)getWallImages

{
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"%@",self.titleNameString]];
    
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        //3
        
        if (!error) {
            
            //Everything was correct, put the new objects and load the wall
            
            self.commentsArray = nil;
            
            self.commentsArray = [[NSArray alloc] initWithArray:objects];
            
            [self reloadData];
            
        } else {
            //4
            
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [errorAlertView show];
            [self.refreshControl endRefreshing];
        }
    }];
}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self performSelector:@selector(endRefresh) withObject:self afterDelay:1];
        
        
    }
}

-(void)endRefresh
{
    [self.refreshControl endRefreshing];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AddNewComment"]) {
        
        [segue.destinationViewController setQuestionTitle:self.titleNameString];
    }
}

@end
