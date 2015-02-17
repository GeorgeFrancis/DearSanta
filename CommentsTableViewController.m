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
#import "BasicCell.h"

static NSString *const BasicCellIdentifier = @"BasicCell";


@interface CommentsTableViewController ()

@property (nonatomic) NSString *titleString;

@end

@implementation CommentsTableViewController

- (void)viewDidLoad {
    [self getWallImages];
    [self.tableView reloadData];
    
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getWallImages
{
    //Prepare the query to get all the images in descending order
    //1
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"%@",self.titleNameString]];
    //2
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //3
        if (!error) {
            //Everything was correct, put the new objects and load the wall
            self.commentsArray = nil;
            self.commentsArray = [[NSArray alloc] initWithArray:objects];
            
            [self.tableView reloadData];
            
        } else {
            
            //4
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return self.commentsArray.count;
//}
//

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    PFObject *commentObject = [self.commentsArray objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text = [commentObject objectForKey:@"comment"];
//    cell.detailTextLabel.text = [commentObject objectForKey:@"user"];
//    
////    self.userName = [wallObject objectForKey:@"user"];
//    
//    
//    // PFFile *image = (PFFile *)[wallObject objectForKey:@"image"];
//    //  UIImage *img = [UIImage imageWithData:image.getData];
//    //  UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
//    // cell.imageView.image = [UIImage imageWithData:image.getData];
//    return cell;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    return self.titleNameString;
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AddNewComment"]) {
    
        [segue.destinationViewController setQuestionTitle:self.titleNameString];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.commentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath];
}

- (BasicCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    BasicCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BasicCellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(BasicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
   
    PFObject *commentObject = [self.commentsArray objectAtIndex:indexPath.row];
    
   self.titleString = [commentObject objectForKey:@"comment"];
    
//    RSSItem *item = self.feedItems[indexPath.row];
//    [self setTitleForCell:cell item:item];
//    [self setSubtitleForCell:cell item:item];
}

- (void)setTitleForCell:(BasicCell *)cell {
    
    
    [cell.titleLabel setText:self.titleString];
}

//- (void)setSubtitleForCell:(BasicCell *)cell {
//    NSString *subtitle = item.mediaText ?: item.mediaDescription;
//    
//    // Some subtitles can be really long, so only display the
//    // first 200 characters
//    if (subtitle.length > 200) {
//        subtitle = [NSString stringWithFormat:@"%@...", [subtitle substringToIndex:200]];
//    }
//    
//    [cell.subtitleLabel setText:subtitle];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static BasicCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:BasicCellIdentifier];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}





@end
