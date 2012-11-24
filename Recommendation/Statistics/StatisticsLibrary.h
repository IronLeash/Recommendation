//
//  StatisticsLibrary.h
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "RestaurantRating.h"
#import "FavoriteCategory.h"

@interface StatisticsLibrary : NSObject


//Calculates weighted sum of user ratings
+ (float)weightedSumForRating:(RestaurantRating*)aRating;

+ (NSDictionary*)preferencesDictionary:(NSArray*)positiveRatingArray;

+ (NSArray*)favoriteCuisines:(NSArray*)positiveRatingArray;

+ (NSArray*)favoriteCategories:(NSArray*)positiveRatingArray;

//Score of unordered nominal value among posite rated items
+ (float)scoreofCategory:(FavoriteCategory*)aCategory;


@end
