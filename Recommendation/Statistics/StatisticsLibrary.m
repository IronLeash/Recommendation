//
//  StatisticsLibrary.m
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "StatisticsLibrary.h"
#import "RatingWeight.h"
#import "Restaurant.h"
#import "Constants.h"

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


+ (NSDictionary*)preferencesDictionary:(NSArray*)positiveRatingArray{

    float vegetarian = 0;
    float childFriendly = 0;
    float liveMusic = 0;
    float garden = 0;


    for (RestaurantRating *currentRating in positiveRatingArray)
    {
#warning you can add a weighting factor according to rating value
         vegetarian     += [currentRating.restaurant.vegeterian floatValue];
         childFriendly  += [currentRating.restaurant.childFriendly floatValue];
         liveMusic      += [currentRating.restaurant.liveMusic floatValue];
         garden         += [currentRating.restaurant.garden floatValue];
    }
    
    vegetarian     = vegetarian/[positiveRatingArray count];
    childFriendly  = childFriendly/ [positiveRatingArray count];
    liveMusic      = liveMusic / [positiveRatingArray count];
    garden         = garden / [positiveRatingArray count];

    NSDictionary *preferencesDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                               [NSNumber numberWithFloat:vegetarian],
                                                                               [NSNumber numberWithFloat:childFriendly],
                                                                               [NSNumber numberWithFloat:liveMusic],
                                                                               [NSNumber numberWithFloat:garden],
                                                                               nil]
                                                                      forKeys:[NSArray arrayWithObjects:kVegetarian,kChildfriendly,kLiveMusic,kGarden,nil]];
    
    return preferencesDictionary;
}

+ (float)scoreofCategory:(FavoriteCategory*)aCategory amongRatingNumber:(int)totalRating withAverage:(float)average{

    float score  = ALPHA*(aCategory.totalOccurances/(float)totalRating) + BETA*(average/(aCategory.ratingtotal/aCategory.totalOccurances));
    return score;
}




@end
