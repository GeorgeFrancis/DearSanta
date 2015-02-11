//
//  SequenceViewController.m
//  BabyDiary
//
//  Created by George Francis on 10/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "SequenceViewController.h"
#import "Photo.h"

@interface SequenceViewController ()

@property int count;
@property (nonatomic) NSMutableArray *photoArray;

@end

@implementation SequenceViewController

@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoArray =[[NSMutableArray alloc]init];
    
    [NSFetchedResultsController deleteCacheWithName:@"Photos"];
    
    [self.fetchResultsController performFetch:nil];
    
    
    if (self.fetchResultsController.fetchedObjects.count > 0 ) {

        Photo *photo = [_fetchResultsController.fetchedObjects objectAtIndex:0];
        UIImage *image = [UIImage imageWithData:photo.photoData];
        self.sequenceImageView.image = image;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.photoArray removeAllObjects];
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

-(void)playTimeLapse
{
        self.sequenceImageView.animationImages=self.photoArray;
        self.sequenceImageView.animationDuration= self.photoArray.count/2;
        self.sequenceImageView.animationRepeatCount=0;
        [self.sequenceImageView startAnimating];
}

-(void)getAllPhotos
{
    for (Photo *aPhoto in self.fetchResultsController.fetchedObjects)
        
    {
        UIImage *image = [UIImage imageWithData:aPhoto.photoData];
        
        [self.photoArray  addObject:image];
    }
}

- (IBAction)playButtonPressed:(id)sender
{
    if (self.fetchResultsController.fetchedObjects.count > 0 ) {
        
        [self getAllPhotos];
        [self playTimeLapse];
        NSLog(@"working");
    }
    
    else
        
        [self presentAlertMessage:nil];
        NSLog(@"Not working");
    
}

- (IBAction)stopButtonPressed:(id)sender
{
    [self.sequenceImageView stopAnimating];
    [self.photoArray removeAllObjects];
}

-(void)presentAlertMessage:(NSString *)message
{
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setDelegate:self];
    
    alert = [[UIAlertView alloc]initWithTitle:@"photo diary is empty" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];

        [self.navigationController popViewControllerAnimated:YES];
        
    }
}


@end
