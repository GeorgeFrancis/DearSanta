//
//  ImportantDate.h
//  BabyDiary
//
//  Created by George Francis on 06/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImportantDate : NSManagedObject

@property (nonatomic, retain) NSString * importantDateName;
@property (nonatomic, retain) NSString * importantDateLocation;
@property (nonatomic, retain) NSDate * date;

@end
