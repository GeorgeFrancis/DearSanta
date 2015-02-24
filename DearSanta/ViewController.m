//
//  ViewController.m
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "Date.h"
#import "Item.h"
#import <Parse/Parse.h>

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface ViewController ()

@property (nonatomic, assign) AppDelegate *app;
@property (nonatomic, strong) NSNumber *totalCost;
@property (assign, nonatomic) BOOL loggedIn;
@property UIImage *currentImage;

@end

@implementation ViewController

- (void)viewDidLoad
{
     [super viewDidLoad];
    
    [self showCommunity];
    [self setUpDueDateLabel];
    [self buttonsColours];
    
    self.loggedIn = NO;
    self.showInfo = NO;
  
    self.app = [[UIApplication sharedApplication] delegate];
    
    [NSFetchedResultsController deleteCacheWithName:@"homeDates"];
    
    [self.fetchResultsController performFetch:nil];
    
    [self loadProfileImage];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self buttonsColours];
    [self setUpDueDateLabel];
    [self showCommunity];
    NSLog(@"viewWillAppear is %@",self.totalCost);
}

-(void)buttonsColours
{
    for (NSString* family in [UIFont familyNames])
    {
        //  NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            //    NSLog(@"  %@", name);
        }
    }
    
    [self.forumButton setFont:[UIFont fontWithName:@"Neon80s" size:self.forumButton.font.pointSize]];
  //  [self.dueDateLabel setFont:[UIFont fontWithName:@"Neon80s" size:self.dueDateLabel.font.pointSize]];
    
    if(SYSTEM_VERSION_LESS_THAN(@"8.0"))
    {
        UIFont *customFont = [UIFont fontWithName:@"Neon" size:32];
        [self.forumButton setFont:[UIFont fontWithName:customFont size:self.forumButton.font.pointSize]];
    }
    
    self.profileButton.layer.cornerRadius = self.profileButton.frame.size.width / 2;
    self.profileButton.clipsToBounds = YES;
    [[self.profileButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.profileButton layer] setBorderWidth:4.3f];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Neon80s" size:21],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    
   // [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:21],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName ,nil]];
    
    
    
    NSData *colourData = [[NSUserDefaults standardUserDefaults]objectForKey:@"ColorTheme"];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colourData];
    
    self.profileButton.backgroundColor = color;
    self.dueDateLabel.backgroundColor = color;
    [[UIButton appearance]setTintColor:color];
    
    [self.settingButton setTintColor:color];
    [self.infoButton setTintColor:color];
    [self.photoDiaryButton setTintColor:color];
    [self.forumButton setTintColor:color];
    
    UIImage *forumImage = [[UIImage imageNamed:@"community"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.forumButton setImage:forumImage forState:UIControlStateNormal];
    self.forumButton.tintColor = color;
    
    UIImage *infoImage = [[UIImage imageNamed:@"help"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.infoButton setImage:infoImage forState:UIControlStateNormal];
    self.forumButton.tintColor = color;
    
    UIImage *productImage = [[UIImage imageNamed:@"shoppingList"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.essentialItemsButton setImage:productImage forState:UIControlStateNormal];
    self.essentialItemsButton.tintColor = color;
    
    UIImage *datesImage = [[UIImage imageNamed:@"calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.specialDatesButton setImage:datesImage forState:UIControlStateNormal];
    self.specialDatesButton.tintColor = color;
    
    UIImage *favouritesImage = [[UIImage imageNamed:@"favourites"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.favouritesButton setImage:favouritesImage forState:UIControlStateNormal];
    self.favouritesButton.tintColor = color;
    
    UIImage *namesImage = [[UIImage imageNamed:@"babyNames"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.babyNamesButton setImage:namesImage forState:UIControlStateNormal];
    self.babyNamesButton.tintColor = color;
    
    UIImage *photoImage = [[UIImage imageNamed:@"photoDiary"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.photoDiaryButton setImage:photoImage forState:UIControlStateNormal];
    self.photoDiaryButton.tintColor = color;
    
    [self.infoButton setTitleColor:color forState:UIControlStateNormal];
    [self.photoDiaryButton setTitleColor:color forState:UIControlStateNormal];
    [self.essentialItemsButton setTitleColor:color forState:UIControlStateNormal];
    [self.babyNamesButton setTitleColor:color forState:UIControlStateNormal];
    [self.specialDatesButton setTitleColor:color forState:UIControlStateNormal];
    [self.forumButton setTitleColor:color forState:UIControlStateNormal];
    [self.infoButton setTitleColor:color forState:UIControlStateNormal];
    [self.favouritesButton setTitleColor:color forState:UIControlStateNormal];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.backGroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor grayColor]CGColor], nil];
    [self.backGroundView.layer insertSublayer:gradient atIndex:0];
    self.gradientView.backgroundColor = [color colorWithAlphaComponent:0.5];
}

-(void)getWallImages
{
 
    PFQuery *query = [PFQuery queryWithClassName:@"QuestionTitles"];
    //2
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //3
        if (!error) {
            //Everything was correct, put the new objects and load the wall
            self.wallObjectsArray = nil;
            self.wallObjectsArray = [[NSArray alloc] initWithArray:objects];
            
            [self displayLatestQuestion];
            
        } else {
    }
    }];
}

-(void)showCommunity
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSObject * object = [prefs objectForKey:@"loggedIn"];
    if(object != nil){
        
        self.loggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"];
        
        if (self.loggedIn == YES) {
            [self getWallImages];
        }
        
        else {
            self.latestQuestionLabel.text = @"login to view community";
        }
    }
    else
        self.latestQuestionLabel.text = @"login to view community";
}

-(void)displayLatestQuestion
{
    PFObject *wallObject = [self.wallObjectsArray objectAtIndex:0];
    
    NSString *questionTitle = [wallObject objectForKey:@"fullTitles"];
    NSString *userName = [wallObject objectForKey:@"user"];
   
    NSDate *updated = [wallObject createdAt];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, MMM d, h:mm a"];
    NSString *dateTimeString = [dateFormat stringFromDate:updated];

    self.latestQuestionLabel.text = [NSString stringWithFormat:@"question asked by: %@ - %@, question asked at %@",userName,questionTitle,dateTimeString];
}

-(void)setUpDueDateLabel
{
    NSDate *dueDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"DueDate"];
    
  //  NSDate * selected = [DatePicker date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components: NSDayCalendarUnit
                                           fromDate: [NSDate date]
                                             toDate: dueDate
                                            options: 0];
    int days = [comps day] + 1;
    
    NSLog(@"days till birth %i", days);
    
    self.dueDateLabel.text = [NSString stringWithFormat:@"due %i days", days];
}

- (void)dealloc
{
    self.fetchResultsController.delegate = nil;
}

- (NSFetchedResultsController*)fetchResultsController
{
    if (_fetchResultsController == nil)
    {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchRequest.sortDescriptors = @[sort];
        
        _fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.app.managedObjectContext sectionNameKeyPath:nil
                                                                                cacheName:@"homeDates"];
        
        _fetchResultsController.delegate = self;
    }
    
    return _fetchResultsController;
}

- (AppDelegate*)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"ViewDidAppear is %@",self.totalCost);
    [self displayDataInLabel];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}

-(void)displayDataInLabel
{
    NSString *name = @"";
    
    if (self.fetchResultsController.fetchedObjects.count > 0 ) {
        
        Item *thisItem = [_fetchResultsController.fetchedObjects objectAtIndex:0];
        
        name = thisItem.name;
    }
    
    NSLog(@"the item name is %@", name);
    
}

- (NSNumber*)totalCost
{
    float total = 0;
    for (Item *aItem in self.fetchResultsController.fetchedObjects)
    {
        total = total + aItem.quantity.floatValue;
    }
    
    return @(total);

//    //    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
//    //    fetchRequest.propertiesToFetch = @[@"personPresentPrice"];
//    //
//    //    NSError *error;
//    //    NSArray *persons = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    float total = 0;
//    for (Person *aPerson in self.fetchedResultsController.fetchedObjects)
//    {
//        total = total + aPerson.personPresentPrice.floatValue;
//    }
//    
//    return @(total);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpButtons
{
    [[self.photoDiaryButton layer] setMasksToBounds:YES];
    
    [[self.essentialItemsButton layer] setMasksToBounds:YES];
    [[self.specialDatesButton layer] setMasksToBounds:YES];
    [[self.babyNamesButton layer] setMasksToBounds:YES];
    [[self.forumButton layer] setMasksToBounds:YES];
//   [[self.infoButton layer] setBorderWidth:0.2f];
//  [[self.infoButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
//  [[self.infoButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];
//   [[self.favouritesButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:1].CGColor];
}

- (void)setShowInfo:(BOOL)showInfo
{
    [self.view layoutIfNeeded];
    
    if (showInfo)
    {
        self.buttonRightConstraint.constant = 20;
        self.labelLeftConstraint.constant = 0;
    }
    else
    {
        self.buttonRightConstraint.constant = 0;
        self.labelLeftConstraint.constant = self.view.frame.size.width;
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
    
    _showInfo = showInfo;
}

- (IBAction)infoButtonPressed:(id)sender
{
    self.showInfo = !self.showInfo;
}

- (IBAction)forumButtonPressed:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSObject * object = [prefs objectForKey:@"loggedIn"];
    if(object != nil){
        
        self.loggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"];
        
        if (self.loggedIn == YES) {
            [self performSegueWithIdentifier:@"LoggedIn" sender:self];
        }
        
        else {
            
            [self performSegueWithIdentifier:@"NotLoggedIn" sender:self];
        }
    }
    else
        
    [self performSegueWithIdentifier:@"NotLoggedIn" sender:self];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.currentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:Nil];
    
    [self.profileButton setBackgroundImage:self.currentImage forState:UIControlStateNormal];
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.currentImage) forKey:@"profileImage"];
    
}

-(void)loadProfileImage
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSObject * object = [prefs objectForKey:@"profileImage"];
    if(object != nil){
        
        NSData *imageData = [[NSUserDefaults standardUserDefaults]objectForKey:@"profileImage"];
        UIImage *image = [UIImage imageWithData:imageData];
        
        [self.profileButton setBackgroundImage:image forState:UIControlStateNormal];
    }
        else {
            
            UIImage *emptyProfile = [UIImage imageNamed:@"emptyProfileImage.png"];
            [self.profileButton setBackgroundImage:emptyProfile forState:UIControlStateNormal];
        }
    }


- (IBAction)profileButtonPressed:(id)sender
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO))
        return;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    [self presentViewController:mediaUI animated:YES completion:nil];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}

- (IBAction)settingsButtonPressed:(id)sender
{
  //  [self performSegueWithIdentifier:@"settings" sender:self];
}

- (IBAction)communityButtonPressed:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSObject * object = [prefs objectForKey:@"loggedIn"];
    if(object != nil){
        
        self.loggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"];
        
        if (self.loggedIn == YES) {
            [self performSegueWithIdentifier:@"LoggedIn" sender:self];
        }
        
        else {
            
            [self performSegueWithIdentifier:@"NotLoggedIn" sender:self];
        }
    }
    else
        
        [self performSegueWithIdentifier:@"NotLoggedIn" sender:self];

}




@end
