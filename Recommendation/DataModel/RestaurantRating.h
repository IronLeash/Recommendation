//
//  RestaurantRating.h
//  Recommendation
//
//  Created by ilker on 15.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
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
