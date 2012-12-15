//
//  Restaurant.h
//  Recommendation
//
//  Created by ilker on 15.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RestaurantRating;

@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSNumber * carPark;
@property (nonatomic, retain) NSNumber * childFriendly;
@property (nonatomic, retain) NSNumber * garden;
@property (nonatomic, retain) NSNumber * liveMusic;
@property (nonatomic, retain) NSNumber * location;
@property (nonatomic, retain) NSNumber * priceRange;
@property (nonatomic, retain) NSNumber * smoking;
@property (nonatomic, retain) NSString * uniqueName;
@property (nonatomic, retain) NSNumber * vegeterian;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * cuisine;
@property (nonatomic, retain) NSSet *ratings;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addRatingsObject:(RestaurantRating *)value;
- (void)removeRatingsObject:(RestaurantRating *)value;
- (void)addRatings:(NSSet *)values;
- (void)removeRatings:(NSSet *)values;

@end
