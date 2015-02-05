//
//  Baby.h
//  BabyDiary
//
//  Created by George Francis on 04/02/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BabyName, Date, Item, Photo;

@interface Baby : NSManagedObject

@property (nonatomic, retain) NSSet *dates;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) NSSet *names;
@property (nonatomic, retain) NSSet *photos;
@end

@interface Baby (CoreDataGeneratedAccessors)

- (void)addDatesObject:(Date *)value;
- (void)removeDatesObject:(Date *)value;
- (void)addDates:(NSSet *)values;
- (void)removeDates:(NSSet *)values;

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

- (void)addNamesObject:(BabyName *)value;
- (void)removeNamesObject:(BabyName *)value;
- (void)addNames:(NSSet *)values;
- (void)removeNames:(NSSet *)values;

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
