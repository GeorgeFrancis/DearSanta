//
//  AddFavouriteNameViewController.m
//  BabyDiary
//
//  Created by George Francis on 19/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "AddFavouriteNameViewController.h"

@interface AddFavouriteNameViewController ()

@end

@implementation AddFavouriteNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self.babyNameLabel setText:[NSString stringWithFormat:@"%@",self.babyName.name]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateTitle];
}

-(void) updateTitle
{
    NSString *title;
    
    if (self.babyName.inBaby == nil)
    {
        title = @"Add to Favourites";
    }
    else
    {
        title = @"Remove from Favourites";
        
    }
    
    [self.saveToFavouritesButton setTitle:title forState:UIControlStateNormal];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveData:(id)sender
{
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
//    [self.babyName.managedObjectContext save:nil];
    
    if (self.babyName.inBaby)
    {
        self.babyName.inBaby = nil;
    }
    else
    {
        self.babyName.inBaby = delegate.baby;
    }
    
    [self updateTitle];

    [delegate saveContext];
    
    
    
}
@end
