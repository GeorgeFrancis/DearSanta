//
//  BoysNamesViewController.m
//  BabyDiary
//
//  Created by George Francis on 19/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "BoysNamesViewController.h"
#import "AddFavouriteNameViewController.h"

@interface BoysNamesViewController ()

@end

@implementation BoysNamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)content
{
    //if (!_content) {
    _content = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"BoysNames" ofType:@"plist"]];
    // }
    return _content;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.content count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [_boysNamesTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.content objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cell.detailTextLabel.text = [[self.content objectAtIndex:indexPath.row] valueForKey:@"NameOrigin"];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        
//    }
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"AddName"]) {
        NSIndexPath *indexPath = [self.boysNamesTableView indexPathForSelectedRow];
        NSString *string = [self.content [indexPath.row]objectForKey:@"Name"];
        [[segue destinationViewController] setCurrentName:string];
    
    
    }
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
