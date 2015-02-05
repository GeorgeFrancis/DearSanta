//
//  UploadImageViewController.m
//  BabyDiary
//
//  Created by George Francis on 31/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "UploadImageViewController.h"
#import <Parse/Parse.h>

@interface UploadImageViewController ()

@end

@implementation UploadImageViewController

- (void)viewDidLoad {
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

- (IBAction)PickfromLibraryButtonPressed:(id)sender {
    
     if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO))
        return;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:Nil];
    
    self.imageToUpload.image = img;
    
    
}


- (IBAction)uploadButtonPressed:(id)sender {
    
    [self.addCommentTextField resignFirstResponder];
    
    //Disable the send button until we are ready
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    //Place the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.view addSubview:loadingSpinner];
    
    
    //TODO: Upload a new picture
//    NSData *pictureData = UIImagePNGRepresentation(self.imageToUpload.image);
//    
//    PFFile *file = [PFFile fileWithName:@"img" data:pictureData];
//    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
    //    if (succeeded){
            //2
            //Add the image to the object, and add the comment and the user
            PFObject *imageObject = [PFObject objectWithClassName:@"WallImageObject"];
      //      [imageObject setObject:file forKey:@"image"];
            [imageObject setObject:[PFUser currentUser].username forKey:@"user"];
            [imageObject setObject:self.addCommentTextField.text forKey:@"comment"];
            [imageObject setObject:self.addCommentTextField.text forKey:@"chat"];
            //3
            [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                //4
                if (succeeded){
                    //Go back to the wall
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [errorAlertView show];
                }
            }];
    
    
        }
//        else{
//            //5
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [errorAlertView show];
//        }
//    } progressBlock:^(int percentDone) {
//        NSLog(@"Uploaded: %d %%", percentDone);
//    }];
//}
@end
