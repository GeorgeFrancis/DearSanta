//
//  PhotoDiaryViewController.m
//  BabyDiary
//
//  Created by George Francis on 20/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "PhotoDiaryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoCell.h"
#import "PhotoViewerViewController.h"
#import "TimeLapseViewController.h"

@interface PhotoDiaryViewController ()

@property (nonatomic,strong) NSMutableArray *assets;
@property (nonatomic,strong) UIImage *currentImage;

@end

@implementation PhotoDiaryViewController

//@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad
{
        [super viewDidLoad];
    
 //   [NSFetchedResultsController deleteCacheWithName:@"photos"];
    
 //   [self.fetchResultsController performFetch:nil];
    
//    [self.tableView reloadData];

    
    
    
    
    
    
    
    
    
    
    
    
//    self.assets = [[NSMutableArray alloc]init];
//    
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveImages"];
//    NSMutableArray *tempImages = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    
//    
//    
//    
//    
//    
//    if (tempImages > 0) {
//        self.assets = tempImages;
//    }
}


//- (NSFetchedResultsController*)fetchResultsController
//
//{
//    
//    if (_fetchResultsController == nil)
//        
//    {
//        
//        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
//        
//        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"photoData" ascending:YES];
//        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
//        fetchRequest.sortDescriptors = @[sort];
//        
//        
//        _fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil
//                                                                                cacheName:@"photos"];
//        
//        _fetchResultsController.delegate = self;
//    }
//    
//    return _fetchResultsController;
//    
//}




-(void)viewWillAppear:(BOOL)animated
{
    
}

//-(void)viewDidAppear:(BOOL)animated
//{
//
//    NSLog(@"View will appear called");
//    
//       if (self.assets.count < 2) {
//        self.timeLapseButton.enabled = NO;
//    }
//    else
//        self.timeLapseButton.enabled = YES;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

+(ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc]init];
    });
    
    return library;
}

#pragma mark - collection view data source

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    UIImage *img = self.assets[indexPath.row];
    [cell loadCell:img];
    
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
    self.currentImage = self.assets[indexPath.row];
  //  ALAsset *asset = self.assets[indexPath.row];
//    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
 //   UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];

    // Do something with the image
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    //take image from info
//    
//    
//      // [newManagedObject setValue:imageData forKey:@"image"];
//    
//    
//    self.selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    
//    
//    [self.photoDiaryCollectionView reloadData];
//    
//    [picker dismissViewControllerAnimated:YES completion:Nil];
//    
//    [self saveImage];
//    
//}
//
//-(void)saveImage
//{
//    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    _managedObjectContext = [delegate managedObjectContext];
//    
//    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Photo"
//                                                         inManagedObjectContext:self.managedObjectContext];
//    
//    Photo *photos  = (Photo*)[[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
//    
//    
//    NSData *imageData = UIImagePNGRepresentation(self.selectedImage);
//
//    photos.photoData = imageData;
//    
//    //    [photos setPhotoData:imageData];
//    
//    [delegate saveContext];
//
//    
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"ShowImages"]) {
//        
//        UICollectionViewCell *cell = (UICollectionViewCell*)sender;
//        NSIndexPath *indexPath = [self.photoDiaryCollectionView indexPathForCell:cell];
//        UIImage *nextImage = [self.assets objectAtIndex:indexPath.row];
//        PhotoViewerViewController  *photo = [segue destinationViewController];
//     //   photo.thisImage = nextImage;
//           }
//    
//    if ([[segue identifier] isEqualToString:@"TimeLapse"]) {
//    
//        NSArray *lapseArray = self.assets;
//        TimeLapseViewController  *photoTimeLapse = [segue destinationViewController];
//   //     photoTimeLapse.photoArray = lapseArray;
//    }
//}

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

- (IBAction)pickPhotoButtonPressed:(id)sender
{
  //  [self clearDeleteValue];
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO))
        return;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    [self presentViewController:mediaUI animated:YES completion:nil];
}

//-(void)savePhoto
//{
//
//AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//_managedObjectContext = [delegate managedObjectContext];
//
//NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Photo"
//                                                     inManagedObjectContext:self.managedObjectContext];
//
//    Photo *photos  = (Photo*)[[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
//    
//    
////Date *dates = (Date*)[[NSManagedObject alloc]initWithEntity:entityDescription
// //                            insertIntoManagedObjectContext:self.managedObjectContext];
//
////NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
////dateFormat.timeZone = [NSTimeZone defaultTimeZone];
////dateFormat.timeStyle = NSDateFormatterShortStyle;
////dateFormat.dateStyle = NSDateFormatterShortStyle;
////[dateFormat setDateFormat:@"yyyy-MM-dd"];
////NSDate *newDate = self.datePicker.date;
////
////dates.date = newDate;
//
//// [dates setDate:newDate];
//
//[delegate saveContext];
//
//}

- (IBAction)goHomePressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)viewTimeLapsePressed:(id)sender {
}

@end
