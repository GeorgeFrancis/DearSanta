//
//  ForumTableViewController.m
//  BabyDiary
//
//  Created by George Francis on 02/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ForumTableViewController.h"
#import <Parse/Parse.h>
#import "CommentsTableViewController.h"

@interface ForumTableViewController ()

@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *titleToPass;

@end

@implementation ForumTableViewController

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.wallObjectsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *wallObject = [self.wallObjectsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [wallObject objectForKey:@"fullTitles"];
    cell.detailTextLabel.text = [wallObject objectForKey:@"user"];
    
    self.userName = [wallObject objectForKey:@"user"];
    
    
   // PFFile *image = (PFFile *)[wallObject objectForKey:@"image"];
  //  UIImage *img = [UIImage imageWithData:image.getData];
  //  UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
   // cell.imageView.image = [UIImage imageWithData:image.getData];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return self.userName;
}

-(void)getWallImages
{
    //Prepare the query to get all the images in descending order
    //1
    
  
    
    PFQuery *query = [PFQuery queryWithClassName:@"QuestionTitles"];
    //2
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //3
        if (!error) {
            //Everything was correct, put the new objects and load the wall
            self.wallObjectsArray = nil;
            self.wallObjectsArray = [[NSArray alloc] initWithArray:objects];
            
            [self.tableView reloadData];
            
        } else {
            
            //4
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ViewComments"]) {
        
 
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        
        UITableViewCell *cell = (UITableViewCell *)[(UITableView *)self.view cellForRowAtIndexPath:indexPath];
        
    //    UITableViewCell *cell = cellForRowAtIndexPath:indexPath;
        self.titleToPass = cell.textLabel.text;
        self.titleToPass = [self.titleToPass stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
    
        [segue.destinationViewController setTitleNameString:self.titleToPass];
    }
}




@end
