//
//  BoysNamesViewController.h
//  BabyDiary
//
//  Created by George Francis on 19/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FetchResultViewController.h"


@interface BoysNamesViewController : FetchResultViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSString *boysOrGirls;
@property (strong, nonatomic) NSString *filterString;
@property (strong, nonatomic) NSString *searchLetter;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;

@property (strong, nonatomic) IBOutlet UIButton *boysButton;
@property (strong, nonatomic) IBOutlet UIButton *girlsButton;

- (IBAction)filterLetterPressed:(id)sender;
- (IBAction)boysButtonPressed:(id)sender;
- (IBAction)girlsButtonPressed:(id)sender;



@end
