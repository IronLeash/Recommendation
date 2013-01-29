//
//  User.h
//  Recommendation
//
//  Created by ilker on 28.01.13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RatingWeight, RestaurantRating;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * location;
@property (nonatomic, retain) NSNumber * smoker;
@property (nonatomic, retain) NSString * stereotype;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSNumber * hasChild;
@property (nonatomic, retain) NSNumber * hasCar;
@property (nonatomic, retain) NSSet *ratings;
@property (nonatomic, retain) RatingWeight *ratingWeight;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addRatingsObject:(RestaurantRating *)value;
- (void)removeRatingsObject:(RestaurantRating *)value;
- (void)addRatings:(NSSet *)values;
- (void)removeRatings:(NSSet *)values;

@end
