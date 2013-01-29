//
//  RatingWeight.h
//  Recommendation
//
//  Created by ilker on 28.01.13.
//  Copyright (c) 2013 ilker. All rights reserved.
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
