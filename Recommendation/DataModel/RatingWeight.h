//
//  RatingWeight.h
//  Recommendation
//
//  Created by ilker on 15.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface RatingWeight : NSManagedObject

@property (nonatomic, retain) NSNumber * accessibility;
@property (nonatomic, retain) NSNumber * coreService;
@property (nonatomic, retain) NSNumber * personal;
@property (nonatomic, retain) NSNumber * service;
@property (nonatomic, retain) NSNumber * tangibles;
@property (nonatomic, retain) User *user;

@end
