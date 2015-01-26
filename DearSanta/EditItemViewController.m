//
//  EditItemViewController.m
//  BabyDiary
//
//  Created by George Francis on 26/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "EditItemViewController.h"

@interface EditItemViewController ()

@end

@implementation EditItemViewController

- (void)viewDidLoad {
    
    self.itemNameTextField.enabled = NO;
    self.itemNameTextField.text = [NSString stringWithFormat:@"%@",self.editItems.name];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)editButtonPressed:(id)sender
{
    self.itemNameTextField.enabled = YES;
    
    self.itemNameTextField.borderStyle = UITextBorderStyleRoundedRect;
   
    
//    self.editButton.hidden = YES;
//    self.doneButton.hidden = NO;
    
    
}

- (IBAction)saveButtonPressed:(id)sender
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.editItems.name = self.itemNameTextField.text;

    
    [delegate saveContext];

    
    
}
@end
