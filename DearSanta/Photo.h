//
//  Photo.h
//  BabyDiary
//
//  Created by George Francis on 25/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Baby;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSData * photoData;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Baby *inBaby;

@end
