//
//  AddItemViewController.m
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@property NSInteger quantityCount;
@property BOOL isBrought;
@property (strong,nonatomic) NSString *selectedTitle;

@end

@implementation AddItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.pickerData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18"];
    self.quantityPicker.dataSource = self;
    self.quantityPicker.delegate = self;
    self.selectedTitle = @"1";
}

-(void)createNewItem
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = [delegate managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Item"
                                                         inManagedObjectContext:self.managedObjectContext];
    
    Item *items = (Item*)[[NSManagedObject alloc]initWithEntity:entityDescription
                                 insertIntoManagedObjectContext:self.managedObjectContext];
    
    items.name = self.itemNameTextField.text;
    items.quantity = @([self.selectedTitle floatValue]);
    
    if (self.purchasedSwitch.on) {
        
        items.isPurchased = [NSNumber numberWithBool:YES];
    }
    
    else{
        items.isPurchased = [NSNumber numberWithBool:NO];
    }
    
    [delegate saveContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedTitle = [self.pickerData objectAtIndex:[self.quantityPicker selectedRowInComponent:0]];
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (IBAction)saveItemPressed:(id)sender
{
    [self createNewItem];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)purchaseSwitchPressed:(id)sender
{
    if (self.purchasedSwitch.on) {
        
      self.purchasedLabel.text = @"brought";
    }
    
    else{
        
        self.purchasedLabel.text = @"still to buy";
    }
}

@end
