//
//  EditItemViewController.h
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

//#import "ViewController.h"
#import "ItemTableViewController.h"
#import "AppDelegate.h"
#import "Item.h"

@interface EditItemViewController : ViewController <UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong,nonatomic) Item *editItems;
@property (strong, nonatomic) NSArray *pickerData;

@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UITextField *itemNameTextField;

@property (strong, nonatomic) IBOutlet UIPickerView *quantityPicker;
@property (strong, nonatomic) IBOutlet UISwitch *purchaseSwitch;

- (IBAction)editButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

- (IBAction)purchaseSwitchPressed:(id)sender;

@end
