//
//  AddPhotoViewController.m
//  BabyDiary
//
//  Created by George Francis on 02/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "AddPhotoViewController.h"

@interface AddPhotoViewController ()

@property (nonatomic,strong) UIImage *currentImage;

@end

@implementation AddPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"charlieBackground.JPG"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
  //  [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"charlieBackground.JPG"]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveImage
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Photo"
                                                         inManagedObjectContext:self.managedObjectContext];
    
    Photo *photo  = (Photo*)[[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    
//    NSData *imageData = UIImageJPEGRepresentation(self.currentImage, 0.1);
    
    photo.photoData = [NSData dataWithData:UIImagePNGRepresentation(self.currentImage)];
    [delegate saveContext];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
      self.currentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:Nil];
    
    self.photoImageView.image = self.currentImage;
    
}

- (IBAction)saveButtonPressed:(id)sender
{
    [self saveImage];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)takePhotoButtonPressed:(id)sender
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO))
        return;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    
    [self presentViewController:mediaUI animated:YES completion:nil];

}

- (IBAction)pickFromLibraryButtonPressed:(id)sender
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO))
        return;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    [self presentViewController:mediaUI animated:YES completion:nil];
}
@end
