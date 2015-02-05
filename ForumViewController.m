//
//  ForumViewController.m
//  BabyDiary
//
//  Created by George Francis on 31/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ForumViewController.h"
#import <Parse/Parse.h>

@interface ForumViewController ()

@end

@implementation ForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Clean the scroll view
//    for (id viewToRemove in [self.forumScrollView subviews]){
//        if ([viewToRemove isMemberOfClass:[UIView class]])
//            [viewToRemove removeFromSuperview];
//    }
    
    //Reload the wall
    [self getWallImages];
    [self.forumTableView reloadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.forumTableView = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getWallImages
{
    //Prepare the query to get all the images in descending order
    //1
    PFQuery *query = [PFQuery queryWithClassName:@"WallImageObject"];
    //2
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //3
        if (!error) {
            //Everything was correct, put the new objects and load the wall
            self.wallObjectsArray = nil;
            self.wallObjectsArray = [[NSArray alloc] initWithArray:objects];
            [self loadWallViews];
            
        } else {
            
            //4
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.wallObjectsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wallObjectsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.forumTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *wallObject = [self.wallObjectsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [wallObject objectForKey:@"comment"];

     return cell;
}


-(void)loadWallViews
{
    //Clean the scroll view
//    for (id viewToRemove in [self.forumScrollView subviews]){
//        
//        if ([viewToRemove isMemberOfClass:[UIView class]])
//            [viewToRemove removeFromSuperview];
//    }
    
    //For every wall element, put a view in the scroll
    int originY = 10;
    
    for (PFObject *wallObject in self.wallObjectsArray){
        
        //1
        //Build the view with the image and the comments
        UIView *wallImageView = [[UIView alloc] initWithFrame:CGRectMake(10, originY, self.view.frame.size.width - 20 , 300)];
        
        //2
        //Add the image
        PFFile *image = (PFFile *)[wallObject objectForKey:@"image"];
        
        UIImage *img = [UIImage imageWithData:image.getData];
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
        
        
        userImage.frame = CGRectMake(0, 0, wallImageView.frame.size.width, 200);
        [wallImageView addSubview:userImage];
        
        //3
        //Add the info label (User and creation date)
        NSDate *creationDate = wallObject.createdAt;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm dd/MM yyyy"];
        //4
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, wallImageView.frame.size.width,15)];
        infoLabel.text = [NSString stringWithFormat:@"Uploaded by: %@, %@", [wallObject objectForKey:@"user"], [df stringFromDate:creationDate]];
        infoLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:9];
        infoLabel.textColor = [UIColor redColor];
        infoLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:infoLabel];
        
        //5
        //Add the comment
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, wallImageView.frame.size.width, 30)];
        commentLabel.text = [wallObject objectForKey:@"comment"];
        commentLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
        commentLabel.textColor = [UIColor darkGrayColor];
        commentLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:commentLabel];
        
        //6
    //    [self.forumScrollView addSubview:wallImageView];
        
        
        originY = originY + wallImageView.frame.size.width + 20;
        
    }
    
    //7
    //Set the bounds of the scroll
 //   self.forumScrollView.contentSize = CGSizeMake(self.forumScrollView.frame.size.width, originY);
    
}


@end
