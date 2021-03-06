//
//  RestaurantRating.h
//  Recommendation
//
//  Created by ilker on 28.01.13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant, User;

@interface RestaurantRating : NSManagedObject

@property (nonatomic, retain) NSNumber * accessibilityRating;
@property (nonatomic, retain) NSNumber * coreServiceRating;
@property (nonatomic, retain) NSNumber * personalRating;
@property (nonatomic, retain) NSNumber * serviceRating;
@property (nonatomic, retain) NSNumber * tangiblesRating;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) User *user;

@end
