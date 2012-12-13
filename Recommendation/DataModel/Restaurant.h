//
//  Restaurant.h
//  Recommendation
//
//  Created by ilker on 13.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Cuisine, RestaurantRating;

@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSNumber * carPark;
@property (nonatomic, retain) NSNumber * childFriendly;
@property (nonatomic, retain) NSNumber * garden;
@property (nonatomic, retain) NSNumber * liveMusic;
@property (nonatomic, retain) NSNumber * location;
@property (nonatomic, retain) NSNumber * priceRange;
@property (nonatomic, retain) NSString * uniqueName;
@property (nonatomic, retain) NSNumber * smoking;
@property (nonatomic, retain) NSNumber * vegeterian;
@property (nonatomic, retain) Category *categories;
@property (nonatomic, retain) Cuisine *cuisine;
@property (nonatomic, retain) NSSet *ratings;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addRatingsObject:(RestaurantRating *)value;
- (void)removeRatingsObject:(RestaurantRating *)value;
- (void)addRatings:(NSSet *)values;
- (void)removeRatings:(NSSet *)values;

@end
