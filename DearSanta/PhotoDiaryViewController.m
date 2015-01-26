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

- (void)viewDidLoad
{
    
    
    
    
    self.assets = [[NSMutableArray alloc]init];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveImages"];
    NSMutableArray *tempImages = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (tempImages > 0) {
        self.assets = tempImages;
    }
    
    
    
    
    self.numberToDelete =  [NSNumber numberWithInt:-1];
    
    NSLog(@"View Did load called");
    
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.numberToDelete = [defaults objectForKey:@"deleteNumberStored"];
    NSLog(@"View will appear called");
    
    if (self.numberToDelete != [NSNumber numberWithInt:-1]) {
        
    NSLog(@"Delte Row method called");
    int j = [self.numberToDelete intValue];
    NSLog(@"Value to delete is %d",j);
    
  //  [self.assets removeObjectAtIndex:j];
        
        
    [self.photoDiaryCollectionView reloadData];
        
    }
    
}

- (void)deleteRow:(NSNumber*)deleteValue
{
    NSLog(@"Delte Row method called");
    int j = [self.numberToDelete intValue];
    NSLog(@"Value to delete is %d",j);
    
    [self.assets removeObjectAtIndex:j];
    [self.photoDiaryCollectionView reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated
{



    
    NSLog(@"View will appear called");
    
       if (self.assets.count < 2) {
        self.timeLapseButton.enabled = NO;
    }
    else
        self.timeLapseButton.enabled = YES;
}

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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //take image from info
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.assets addObject:image];
    
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:self.assets];
    [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"saveImages"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.photoDiaryCollectionView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:Nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowImages"]) {
        
        UICollectionViewCell *cell = (UICollectionViewCell*)sender;
        NSIndexPath *indexPath = [self.photoDiaryCollectionView indexPathForCell:cell];
        UIImage *nextImage = [self.assets objectAtIndex:indexPath.row];
        NSNumber *selRow = [[NSNumber alloc] initWithInteger:indexPath.row];
        
        PhotoViewerViewController  *photo = [segue destinationViewController];
        
        photo.thisImage = nextImage;
        photo.imageToDeleteRef = selRow;
    }
    
    if ([[segue identifier] isEqualToString:@"TimeLapse"]) {
    
        NSArray *lapseArray = self.assets;
        TimeLapseViewController  *photoTimeLapse = [segue destinationViewController];
        photoTimeLapse.photoArray = lapseArray;
    }
}

-(void)clearDeleteValue
{
    NSNumber *temp =  [NSNumber numberWithInt:-1];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:temp forKey:@"deleteNumberStored"];
}

- (IBAction)takePhotoButtonPressed:(id)sender
{
  //  [self clearDeleteValue];
    
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

- (IBAction)goHomePressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)viewTimeLapsePressed:(id)sender {
}

@end
