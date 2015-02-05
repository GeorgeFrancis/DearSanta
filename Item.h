//
//  Item.h
//  BabyDiary
//
//  Created by George Francis on 04/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Baby;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * isPurchased;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) Baby *inBaby;

@end
