//
//  PhotoCollectionViewController.m
//  BabyDiary
//
//  Created by George Francis on 02/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "Photo.h"

@interface PhotoCollectionViewController ()

@end

@implementation PhotoCollectionViewController

UICollectionViewCell *cellToDelete;

@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photoDiaryCollectionView.delegate = self;
    self.photoDiaryCollectionView.dataSource = self;
    
    [NSFetchedResultsController deleteCacheWithName:@"Photos"];
    
    [self.fetchResultsController performFetch:nil];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.photoDiaryCollectionView reloadData];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .3;
    lpgr.delegate = self;
    [self.photoDiaryCollectionView addGestureRecognizer:lpgr];
    lpgr.delaysTouchesBegan = YES;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.photoDiaryCollectionView];
    
    NSIndexPath *indexPath = [self.photoDiaryCollectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        
        UICollectionViewCell* cell = [self.photoDiaryCollectionView cellForItemAtIndexPath:indexPath];
        cellToDelete = cell;
        
        [self presentAlertMessage:nil];
    }
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
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        NSLog(@"delete pressed");
        
                NSIndexPath *indexPath = [self.photoDiaryCollectionView indexPathForCell:cellToDelete];
                NSManagedObjectContext *context = [self.appDelegate managedObjectContext];
                Photo *photoToDelete = [self.fetchResultsController objectAtIndexPath:indexPath];
                [context deleteObject:photoToDelete];
        
        
                [self.photoDiaryCollectionView reloadData];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error! %@",error);
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.photoDiaryCollectionView reloadData];
}

- (NSFetchedResultsController*)fetchResultsController

{
    if (_fetchResultsController == nil)
        
    {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchRequest.sortDescriptors = @[sort];
        
        _fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil
                                                                                cacheName:@"Photos"];
        _fetchResultsController.delegate = self;
    }
    
    return _fetchResultsController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fetchResultsController.fetchedObjects.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    Photo *photo = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    UIImage *image = [UIImage imageWithData:photo.photoData];
    if (image)
    {
        [cell loadCell:image];
    }
    
    return cell;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowImages"]) {
        
        UICollectionViewCell *cell = (UICollectionViewCell*)sender;
        NSIndexPath *indexPath = [self.photoDiaryCollectionView indexPathForCell:cell];
        
        Photo *photos = [self.fetchResultsController objectAtIndexPath:indexPath];
        [[segue destinationViewController] setEditPhoto:photos];
    }
}

- (IBAction)homeButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
