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
@property (strong,nonatomic) NSString *selectedTitle;

@end

@implementation AddItemViewController

- (void)viewDidLoad
{
    self.pickerData = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    
    
   


 //   [self.pickerData insertObject:[NSNumber numberWithInteger:2];
    
    self.quantityPicker.dataSource = self;
    self.quantityPicker.delegate = self;
    
    _quantityCount = 1;
    
    [super viewDidLoad];

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
    items.isPurchased = [NSNumber numberWithBool:NO];
    items.quantity = @([self.selectedTitle floatValue]);

    [delegate saveContext];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
 //   _quantityCount = [self.quantityPicker selectedRowInComponent:row];
    
    self.selectedTitle = [self.pickerData objectAtIndex:[self.quantityPicker selectedRowInComponent:0]];
    
    self.quantityCount = [self.selectedTitle floatValue];
    
    NSLog(@"%ld", (long)self.quantityCount);

}


- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (IBAction)saveItemPressed:(id)sender {
    
    [self createNewItem];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
