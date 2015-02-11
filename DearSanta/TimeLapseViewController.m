//
//  TimeLapseViewController.m
//  BabyDiary
//
//  Created by George Francis on 21/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "TimeLapseViewController.h"
#import "Photo.h"


@interface TimeLapseViewController ()

//@property (nonatomic, assign) AppDelegate *app;

@end

@implementation TimeLapseViewController

@synthesize fetchResultsController = _fetchResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  //  self.app = [[UIApplication sharedApplication] delegate];
    
    [NSFetchedResultsController deleteCacheWithName:@"PhotoData"];
    
    [self.fetchResultsController performFetch:nil];
    
    NSLog(@"viewdidload called");
    
    
    Photo *photo = [self.fetchResultsController.fetchedObjects objectAtIndex:0];
    
    UIImage *image = [UIImage imageWithData:photo.photoData];

    
 //   UIImage *img = [self.fetchResultController.fetchedObjects objectAtIndex:0];
    self.timeLapseImageView.image = image;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    Photo *date = [self.fetchResultsController.fetchedObjects objectAtIndex:1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    NSString *dateTimeString = [dateFormatter stringFromDate:date.date];
    
    NSLog(@"view will appear this is date%@",dateTimeString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//-(void)playAnimation
//{
//    self.timeLapseImageView.animationImages=self.allPhotoArray;
//    self.timeLapseImageView.animationDuration= self.allPhotoArray.count/2;
//    self.timeLapseImageView.animationRepeatCount=0;
//    [self.timeLapseImageView startAnimating];
//}

- (IBAction)playTimeLapsePressed:(id)sender
{    
    
    if (self.fetchResultsController.fetchedObjects.count > 0 ) {
        
        NSLog(@"working");
    }
    
    else
        NSLog(@"Not working");

    

    
 //   [self playAnimation];
}

- (IBAction)stopTimeLapsePressed:(id)sender {
    
 //   [self.timeLapseImageView stopAnimating];
    
  }

- (void)dealloc
{
    self.fetchResultsController.delegate = nil;
}

- (NSFetchedResultsController*)fetchResultsController

{
    if (self.fetchResultsController == nil)
        
    {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchRequest.sortDescriptors = @[sort];
        
        
        self.fetchResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil
                                                                                cacheName:@"PhotoData"];
        
        self.fetchResultsController.delegate = self;
    }
    
    return self.fetchResultsController;
}

- (AppDelegate*)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}


@end
