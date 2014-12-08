//
//  Person.h
//  DearSanta
//
//  Created by George Francis on 07/11/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * personName;
@property (nonatomic, retain) NSString * personPresent;
@property (nonatomic, retain) NSNumber * personPresentPrice;
@property (nonatomic, retain) NSNumber * personPresentBrought;

@end
