//
//  AddCommentViewController.m
//  BabyDiary
//
//  Created by George Francis on 15/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "AddCommentViewController.h"
#import <Parse/Parse.h>

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uploadQuestion
{
    
    [self.addCommentTextField resignFirstResponder];
    
    //Disable the send button until we are ready
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    //Place the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.view addSubview:loadingSpinner];
    
    self.nextCommentString = self.addCommentTextField.text;
    
 //   NSString *newString = [self.titleString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    //TODO: Upload a new picture
    //    NSData *pictureData = UIImagePNGRepresentation(self.imageToUpload.image);
    //
    //    PFFile *file = [PFFile fileWithName:@"img" data:pictureData];
    //    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
    //    if (succeeded){
    //2
    //Add the image to the object, and add the comment and the user
    
    
    PFObject *commentObject = [PFObject objectWithClassName:[NSString stringWithFormat:@"%@",self.questionTitle]];
 //   PFObject *titleObject = [PFObject objectWithClassName:@"QuestionTitles"];
    
  //  [commentObject setObject:[PFUser currentUser].username forKey:@"user"];
//    [titleObject setObject:self.titleString forKey:@"fullTitles"];
 //   [titleObject setObject:newString forKey:@"searchTitles"];
    
    
    //      [imageObject setObject:file forKey:@"image"];
    [commentObject setObject:[PFUser currentUser].username forKey:@"user"];
    [commentObject setObject:self.addCommentTextField.text forKey:@"comment"];

    //3
    

    [commentObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     //  [titleObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         //4
         if (succeeded){
             
             [self.navigationController popViewControllerAnimated:YES];
         }
         else{
             NSString *errorString = [[error userInfo] objectForKey:@"error"];
             UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [errorAlertView show];
         }
     }];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveCommentButtonPressed:(id)sender
{
    [self uploadQuestion];
    
}
@end
