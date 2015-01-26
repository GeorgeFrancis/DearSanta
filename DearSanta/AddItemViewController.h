//
//  AddItemViewController.h
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import "Item.h"
#import "AppDelegate.h"

@interface AddItemViewController : ViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSArray *pickerData;


@property (strong, nonatomic) IBOutlet UITextField *itemNameTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *quantityPicker;


- (IBAction)saveItemPressed:(id)sender;


@end
