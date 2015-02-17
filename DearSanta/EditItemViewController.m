//
//  EditItemViewController.m
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "EditItemViewController.h"

@interface EditItemViewController ()

@property NSInteger quantityCount;
@property (strong,nonatomic) NSString *selectedTitle;

@end

@implementation EditItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.itemNameTextField.enabled = NO;
    self.pickerData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18"];
    self.quantityPicker.dataSource = self;
    self.quantityPicker.delegate = self;
    [self setUpData];
}

-(void)setUpData
{
    [[self.editButton layer] setMasksToBounds:YES];
    [[self.editButton layer] setBorderWidth:2.0f];
    [[self.editButton layer] setBorderColor:[UIColor colorWithRed:0.988 green:0.737 blue:0.494 alpha:1.0].CGColor];
    [[self.editButton layer] setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.714 alpha:0.5].CGColor];

    
    
    self.itemNameTextField.text = [NSString stringWithFormat:@"%@",self.editItems.name];

    [self.quantityPicker selectRow:[self.editItems.quantity integerValue]-1 inComponent:0 animated:YES];
    
    
    self.quantityCount = [self.editItems.quantity floatValue];
    
    
    if ([[self.editItems isPurchased] boolValue] == YES) {
        
        self.purchaseSwitch.on = YES;
    }
    
    else{
        
        self.purchaseSwitch.on = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(id)sender
{
    self.itemNameTextField.enabled = YES;
    self.itemNameTextField.borderStyle = UITextBorderStyleRoundedRect;
}

- (IBAction)saveButtonPressed:(id)sender
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.editItems.name = self.itemNameTextField.text;
    
    NSNumber *numberObject = [NSNumber numberWithInteger:self.quantityCount];
    
    self.editItems.quantity = numberObject;

    
    if (self.purchaseSwitch.on) {
        
        self.editItems.isPurchased = [NSNumber numberWithBool:YES];
    }
    
    else{
        self.editItems.isPurchased = [NSNumber numberWithBool:NO];
    }
    
    [delegate saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)purchaseSwitchPressed:(id)sender {
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
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedTitle = [self.pickerData objectAtIndex:[self.quantityPicker selectedRowInComponent:0]];
    
    self.quantityCount = [self.selectedTitle floatValue];
    
    NSLog(@"%ld", (long)self.quantityCount);
}


@end
