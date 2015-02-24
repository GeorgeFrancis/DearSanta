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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getWallImages];
    [self.tableView reloadData];
    
    NSData *colourData = [[NSUserDefaults standardUserDefaults]objectForKey:@"ColorTheme"];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colourData];


    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = color;
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(getWallImages) forControlEvents:UIControlEventValueChanged];
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
    if ([[segue identifier] isEqualToString:@"ViewComments"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        
        UITableViewCell *cell = (UITableViewCell *)[(UITableView *)self.view cellForRowAtIndexPath:indexPath];
        
  
        self.titleToPass = cell.textLabel.text;
        self.titleToPass = [self.titleToPass stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray *characters = @[@"<", @"!", @"@", @"#", @"$", @"%", @"^", @"&", @"*", @"(", @")", @",", @"_", @"+", @"|", @">"];
        
        for (NSString *str in characters) {
            self.titleToPass = [self.titleToPass stringByReplacingOccurrencesOfString:str withString:@""];
        }
        [segue.destinationViewController setTitleNameString:self.titleToPass];
    }
}

- (IBAction)logoutButtonPressed:(id)sender
{
    BOOL loggedIn = NO;
    
    [[NSUserDefaults standardUserDefaults] setBool:loggedIn forKey:@"loggedIn"];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
