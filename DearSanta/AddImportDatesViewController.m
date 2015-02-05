//
//  AddImportDatesViewController.m
//  BabyDiary
//
//  Created by George Francis on 25/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "AddImportDatesViewController.h"
#import "AppDelegate.h"

@interface AddImportDatesViewController ()

@end

@implementation AddImportDatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     NSDate *now = [NSDate date];
    
    self.datePicker.date = now;
    // Do any additional setup after loading the view.
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

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.timeZone = [NSTimeZone defaultTimeZone];
    dateFormat.timeStyle = NSDateFormatterShortStyle;
    dateFormat.dateStyle = NSDateFormatterShortStyle;
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate = self.datePicker.date;

    dates.date = newDate;
    
   // [dates setDate:newDate];
    
    [delegate saveContext];
    
   
}


- (IBAction)addDateButtonPressed:(id)sender {
    
    [self createNewDate];
}
@end
