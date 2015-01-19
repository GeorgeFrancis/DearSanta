//
//  BabyNamesTableViewController.m
//  BabyDiary
//
//  Created by George Francis on 06/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "BabyNamesTableViewController.h"
#import "AppDelegate.h"

@interface BabyNamesTableViewController ()

@end

@implementation BabyNamesTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    
  
  //  [self content];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)content
{
    //if (!_content) {
        _content = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"BabyNamesData" ofType:@"plist"]];
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
    
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.content objectAtIndex:indexPath.row] objectForKey:@"NameOrigin"];
    cell.detailTextLabel.text = [[self.content objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  //  NSString *testString = cell.textLabel.text;
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
        BabyName *newBabyName = (BabyName *) [NSEntityDescription insertNewObjectForEntityForName:@"BabyName"
                                                                     inManagedObjectContext:[delegate managedObjectContext]];
        
        self.currentBabyName = newBabyName;
        
        
        [self.currentBabyName setName:cell.textLabel.text];
    
        [delegate saveContext];
    
    
    }
    

    
    






















/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
