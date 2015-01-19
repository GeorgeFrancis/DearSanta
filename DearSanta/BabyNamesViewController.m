//
//  BabyNamesViewController.m
//  BabyDiary
//
//  Created by George Francis on 03/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "BabyNamesViewController.h"

@interface BabyNamesViewController ()

@end

@implementation BabyNamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  self.scroller = [[UIScrollView alloc] init];
    
    [self.scroller setScrollEnabled:YES];
    [self.scroller setContentSize:CGSizeMake(2200, 35)];
    
    
    
   // self.scroller.frame = CGSizeMake (320,250);
  //  scroll.contentsize = CGSizeMake(930,250)
    
    
   // UIImageView *imageview = [[UIImageView alloc]init];
   // imageview.image = myimage;  //(UIImage)
    
    [self.view addSubview:_scroller];  // add subview as the bottom layer to the main view
   // [scroll addSubview imageview];
    
    
    

    // Do any additional setup after loading the view.
}

//- (void)viewDidLayoutSubviews {
//    [self.scroller setContentSize:CGSizeMake(968, 263)];
//}

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

@end
