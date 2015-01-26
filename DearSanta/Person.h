//
//  Person.h
//  BabyDiary
//
//  Created by George Francis on 25/01/2015.
//  Copyright (c) 2015 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * personName;
@property (nonatomic, retain) NSString * personPresent;
@property (nonatomic, retain) NSNumber * personPresentBrought;
@property (nonatomic, retain) NSNumber * personPresentPrice;

@end
