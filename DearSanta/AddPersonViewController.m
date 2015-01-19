//
//  AddPersonViewController.m
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "AddPersonViewController.h"
#import "AppDelegate.h"



@interface AddPersonViewController ()



@end



@implementation AddPersonViewController



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

- (IBAction)cancel:(id)sender {
    
    [self.delegate addPersonViewControllerDidCancel:[self currentPerson]];
    
}

- (IBAction)save:(id)sender
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (self.personNameTextField.text.length > 0)
    {
        Person *newPerson = (Person *) [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                                     inManagedObjectContext:[delegate managedObjectContext]];
        
        self.currentPerson = newPerson;
        
        
        [self.currentPerson setPersonName:self.personNameTextField.text];
        [self.currentPerson setPersonPresent:self.presentTextField.text];
        
        NSNumber *presentPrice = @([self.presentPriceTextField.text floatValue]);
        [self.currentPerson setPersonPresentPrice:presentPrice];
        
        
        if (self.broughtProductSwitch.on) {
            [self.currentPerson setPersonPresentBrought:[NSNumber numberWithBool:YES]];
        }
        
        else{
            [self.currentPerson setPersonPresentBrought:[NSNumber numberWithBool:NO]];
        }
        
        [delegate saveContext];
    }

    [self.navigationController popViewControllerAnimated:YES];
    
//    [self.delegate addPersonViewControllerDidSave];
}

@end
