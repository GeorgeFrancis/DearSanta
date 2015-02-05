//
//  BabyName.h
//  BabyDiary
//
//  Created by George Francis on 04/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Baby;

@interface BabyName : NSManagedObject

@property (nonatomic, retain) NSNumber * isBoy;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * nameOrigin;
@property (nonatomic, retain) Baby *inBaby;

@end