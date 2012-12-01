//
//  StatisticsLibrary.m
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerator.h"
#import "StatisticsLibrary.h"
#import "RatingWeight.h"
#import "Restaurant.h"
#import "Constants.h"
#import "FavoriteSmoking.h"


@implementation StatisticsLibrary


+ (float)weightedSumForRating:(RestaurantRating*)aRating{

    
    
    RatingWeight *currentRatingWeight = aRating.user.ratingWeight;
    
    float accessibility = ([aRating.accessibilityRating floatValue] * [currentRatingWeight.accessibility floatValue]);
    float coreService   = ([aRating.coreServiceRating floatValue] * [currentRatingWeight.coreService floatValue]);
    float tangibles     = ([aRating.tangiblesRating floatValue] * [currentRatingWeight.tangibles floatValue]);
    float service       = ([aRating.serviceRating floatValue] * [currentRatingWeight.service floatValue]);
    float personal      = ([aRating.personalRating floatValue] * [currentRatingWeight.personal floatValue]);
    
    return accessibility + coreService + tangibles + service + personal;
    
}




+ (float)scoreofCategory:(FavoriteCategory*)aCategory amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage{

    float score  = ALPHA*(aCategory.totalOccurances/(float)numberfPositeRatings) + BETA*((aCategory.ratingtotal/aCategory.totalOccurances)/positveRatingAverage);
    return score;
}

+ (float)scoreofCuisine:(FavoriteCuisine*)aCuisine amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage{
    
    float score  = ALPHA*(aCuisine.totalOccurances/(float)numberfPositeRatings) + BETA*((aCuisine.ratingtotal/aCuisine.totalOccurances)/positveRatingAverage);
    return score;
}

+ (float)scoreoSmoking:(FavoriteSmoking*)aSmoking amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage{
    
    float score  = ALPHA*(aSmoking.totalOccurances/(float)numberfPositeRatings) + BETA*((aSmoking.ratingtotal/aSmoking.totalOccurances)/positveRatingAverage);
    return score;
}

+ (float)scoreoLocation:(FavoriteLocation*)aLocation amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage{
    
    float score  = ALPHA*(aLocation.totalOccurances/(float)numberfPositeRatings) + BETA*((aLocation.ratingtotal/aLocation.totalOccurances)/positveRatingAverage);
    return score;
}

+ (float)weightedpositveRatingsMean:(NSArray*)positiveRatings{

    float average= 0;

    for (RestaurantRating *currentRating in  positiveRatings) {
        average+=[StatisticsLibrary weightedSumForRating:currentRating];
    }
    
    average = average/[positiveRatings count];

    return average;
}


+ (double)pearsonCorreleationBetweenArray1:(NSArray*)array1 andArray2:(NSArray*)array2{

    double returnValue;

    double CArray1[[array1 count]];
    double CArray2[[array2 count]];
    
//    double CArray3[]={1,3,5,7,8,9,0,-3,2};
//    double CArray4[]={12321,14.0,421,53,1,11,-12};
    
    
    int i = 0;
    for (NSNumber *currentNumber in array1) {
        CArray1[i] = (double)[currentNumber doubleValue];
        NSLog(@"Array1 %f",CArray1[i]);
        i++;
    }
    
    i = 0;
    for (NSNumber *currentNumber in array2) {
        CArray2[i] = (double)[currentNumber doubleValue];
        NSLog(@"Array2 %f",CArray2[i]);
        i++;
    }
    
    
    returnValue = gsl_stats_correlation(CArray1, 1, CArray2, 1, [array1 count]);
    
    return returnValue;
}




@end
