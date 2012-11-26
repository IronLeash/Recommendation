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
#import "FavoriteCuisine.h"

@interface StatisticsLibrary : NSObject


//Calculates weighted sum of user ratings
+ (float)weightedSumForRating:(RestaurantRating*)aRating;

//Score of unordered nominal value among posite rated items
+ (float)scoreofCategory:(FavoriteCategory*)aCategory amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage;
+ (float)scoreofCuisine:(FavoriteCuisine*)aCuisine amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage;


+ (float)weightedpositveRatingsMean:(NSArray*)positiveRatings;




@end
