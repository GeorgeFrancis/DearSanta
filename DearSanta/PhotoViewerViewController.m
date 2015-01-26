//
//  PhotoViewerViewController.m
//  BabyDiary
//
//  Created by George Francis on 20/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "PhotoViewerViewController.h"
#import "PhotoDiaryViewController.h"


@interface PhotoViewerViewController ()



@end

@implementation PhotoViewerViewController

- (void)viewDidLoad {
    
    

   // photoDiaryViewController = [[PhotoDiaryViewController alloc] init];
    
    self.rowToDelete = [NSNumber numberWithInt:-1];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.rowToDelete forKey:@"deleteNumberStored"];
    
    self.photoImageView.image = self.thisImage;
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

- (IBAction)deletePhotoButtonPressed:(id)sender
{
    [self presentAlertMessage:nil];
}

- (IBAction)goHomePressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)presentAlertMessage:(NSString *)message
{
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setDelegate:self];
    
    alert = [[UIAlertView alloc]initWithTitle:@"Delete Image" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete",nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        
    }
    else if (buttonIndex == 1)
    {
        self.rowToDelete = self.imageToDeleteRef;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.rowToDelete forKey:@"deleteNumberStored"];
        
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        NSLog(@"delete pressed");
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
