//
//  Baby.h
//  BabyDiary
//
//  Created by George Francis on 25/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BabyName;

@interface Baby : NSManagedObject

@property (nonatomic, retain) NSSet *photos;
@property (nonatomic, retain) NSSet *names;
@property (nonatomic, retain) NSSet *dates;
@property (nonatomic, retain) NSSet *items;
@end

@interface Baby (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(NSManagedObject *)value;
- (void)removePhotosObject:(NSManagedObject *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

- (void)addNamesObject:(BabyName *)value;
- (void)removeNamesObject:(BabyName *)value;
- (void)addNames:(NSSet *)values;
- (void)removeNames:(NSSet *)values;

- (void)addDatesObject:(NSManagedObject *)value;
- (void)removeDatesObject:(NSManagedObject *)value;
- (void)addDates:(NSSet *)values;
- (void)removeDates:(NSSet *)values;

- (void)addItemsObject:(NSManagedObject *)value;
- (void)removeItemsObject:(NSManagedObject *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
