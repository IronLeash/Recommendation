//
//  StatisticsLibrary.h
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//




#import <Foundation/Foundation.h>
#include <gsl/gsl_statistics.h>
#include <gsl/gsl_randist.h>

#import "User.h"
#import "RestaurantRating.h"

#import "FavoriteCategory.h"
#import "FavoriteCuisine.h"
#import "FavoriteSmoking.h"
#import "FavoriteLocation.h"

@interface StatisticsLibrary : NSObject


//Calculates weighted sum of user ratings
+ (float)weightedSumForRating:(RestaurantRating*)aRating;

//Score of unordered nominal value among posite rated items
+ (float)scoreofCategory:(FavoriteCategory*)aCategory amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage;
+ (float)scoreofCuisine:(FavoriteCuisine*)aCuisine amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage;
+ (float)scoreoSmoking:(FavoriteSmoking*)aCuisine amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage;
+ (float)scoreoLocation:(FavoriteLocation*)aLocation amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverag;

+ (float)weightedpositveRatingsMean:(NSArray*)positiveRatings;

//Pearson Correlation
+ (double)pearsonCorreleationBetweenArray1:(NSArray*)array1 andArray2:(NSArray*)array2;

+ (double)cramersVforAttribute;

//Entrophy of Attributes calculated based on Restaurant items
+ (NSDictionary*)entopyOfVariable;

@end
