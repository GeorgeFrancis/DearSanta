//
//  AddFavouriteNameViewController.m
//  BabyDiary
//
//  Created by George Francis on 19/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "AddFavouriteNameViewController.h"

@interface AddFavouriteNameViewController ()

@end

@implementation AddFavouriteNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.babyNameLabel setText:[NSString stringWithFormat:@"%@",self.currentName]];
    
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

- (IBAction)saveData:(id)sender {
    
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    
//    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    NSManagedObject *newName;
//    
//    newName = [NSEntityDescription
//                  insertNewObjectForEntityForName:@"BabyName"
//                  inManagedObjectContext:context];
//    [newName setValue: self.currentName forKey:@"name"];
//    
//    NSError *error;
//    [context save:&error];
//    NSLog(@"%@",error);
//    
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
        BabyName *newName = (BabyName *) [NSEntityDescription insertNewObjectForEntityForName:@"BabyName"
                                                                     inManagedObjectContext:[delegate managedObjectContext]];
        [newName setValue: self.currentName forKey:@"name"];

    [delegate saveContext];
    
    
    
}
@end
