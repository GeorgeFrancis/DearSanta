//
//  EditItemViewController.h
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "ItemTableViewController.h"
#import "AppDelegate.h"
#import "Item.h"

@interface EditItemViewController : ViewController

@property (strong,nonatomic) Item *editItems;

@property (strong, nonatomic) IBOutlet UITextField *itemNameTextField;

- (IBAction)editButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

@end
