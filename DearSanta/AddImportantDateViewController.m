//
//  AddImportantDateViewController.m
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "AddImportantDateViewController.h"


@interface AddImportantDateViewController ()

@end

@implementation AddImportantDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDate *now = [NSDate date];
    self.datePicker.date = now;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNewDate
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = [delegate managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Date"
                                                         inManagedObjectContext:self.managedObjectContext];
    
    
    Date *dates = (Date*)[[NSManagedObject alloc]initWithEntity:entityDescription
                                 insertIntoManagedObjectContext:self.managedObjectContext];
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//    dateFormat.timeZone = [NSTimeZone defaultTimeZone];
//    dateFormat.timeStyle = NSDateFormatterShortStyle;
//    dateFormat.dateStyle = NSDateFormatterShortStyle;
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate = self.datePicker.date;
    
    dates.date = newDate;
    dates.name = self.dateNameTextField.text;
    
    [delegate saveContext];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.dateNameTextField resignFirstResponder];
}

- (IBAction)addDateButtonPressed:(id)sender
{
    [self createNewDate];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
