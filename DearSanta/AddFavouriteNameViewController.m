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

- (void)viewDidLoad
{
    [[self.saveToFavouritesButton layer] setMasksToBounds:YES];
    [[self.saveToFavouritesButton layer] setBorderWidth:2.0f];
    [[self.saveToFavouritesButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.saveToFavouritesButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];
    
    [self.babyNameLabel setText:[NSString stringWithFormat:@"%@",self.babyName.name]];
    
    [super viewDidLoad];
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
