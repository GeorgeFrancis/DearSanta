//
//  AddDateViewController.m
//  BabyDiary
//
//  Created by George Francis on 06/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "AddDateViewController.h"
#import "AppDelegate.h"



@interface AddDateViewController ()



@end



@implementation AddDateViewController



- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //   self.personNameTextField.text = [self.currentPerson personName];
    //   self.presentTextField.text = [self.currentPerson personPresent];
    
    //   NSString *strDeliveryID = [NSString stringWithFormat:@"%@",[self.currentPerson personPresentPrice]];
    
    //   self.presentPriceTextField.text = strDeliveryID;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)saveDate:(id)sender {
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (self.locationTextField.text.length > 0)
    {
        ImportantDate *newDate = (ImportantDate *) [NSEntityDescription insertNewObjectForEntityForName:@"ImportantDate"
                                                                     inManagedObjectContext:[delegate managedObjectContext]];
        
        self.currentImportantDate = newDate;
        
        
        [self.currentImportantDate setImportantDateName:self.nameTextField.text];
        [self.currentImportantDate setImportantDateLocation:self.locationTextField.text];
        
        
        [delegate saveContext];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //    [self.delegate addPersonViewControllerDidSave];
}

   
@end
