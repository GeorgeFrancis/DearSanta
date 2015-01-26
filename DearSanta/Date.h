//
//  Date.h
//  BabyDiary
//
//  Created by George Francis on 25/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Baby;

@interface Date : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Baby *inBaby;

@end
