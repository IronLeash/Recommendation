//
//  ActionGeneric.m
//  Recommendation
//
//  Created by ilker on 16.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "ActionGeneric.h"

#import "DataFetcher.h"

#import "StatisticsLibrary.h"

#import "Restaurant.h"
#import "RestaurantRating.h"

#import "Constants.h"

@implementation ActionGeneric

+(int)cuisinePosiitonInContigencyMatrix:(NSString*)attributeValue{

    NSArray *cuisinesArray = [[DataFetcher sharedInstance] getRestaurantCuisines];
    
    int position = (int)[cuisinesArray indexOfObject:attributeValue] ;
    
    if (position != NSNotFound) {
        position = -1;
    }

    return position;

}

+(int)categoryPosiitonInContigencyMatrix:(NSString*)attributeValue{

    NSArray *cuisinesArray = [[DataFetcher sharedInstance] getRestaurantCategories];

    int position = (int)[cuisinesArray indexOfObject:attributeValue];
    
    if (position != NSNotFound) {
        position = -1;
    }
    
    return position;

}

+(NSMutableArray*)weightedAveraRatingsArrayForRatings:(NSArray*)ratingsArray{

    NSMutableArray *weightedAverageArray = [[NSMutableArray alloc] initWithCapacity:[ratingsArray count]];
    
    for (RestaurantRating *currentRating in ratingsArray)
    {
        [weightedAverageArray addObject:[NSNumber numberWithInt:([StatisticsLibrary weightedSumForRating:currentRating]+0.5)]];
    }
    
    return weightedAverageArray;
}


+(NSDictionary*)restaurantAttributevaluesForRatings:(NSArray*)ratingsArray{
    
    NSMutableArray *priceArray          = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *carParkArray        = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *childFriendlyArray  = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *gardenArray         = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *liveMusicArray      = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *vegaterianArray     = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *smokingArray        = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (RestaurantRating *currentRating in ratingsArray)
    {
        Restaurant *currentRestaurant = currentRating.restaurant;
        
        [priceArray addObject:currentRestaurant.priceRange];
        [carParkArray addObject:currentRestaurant.carPark];
        [gardenArray addObject:currentRestaurant.garden];
        [liveMusicArray addObject:currentRestaurant.liveMusic];
        [smokingArray addObject:currentRestaurant.smoking];
        [childFriendlyArray addObject:currentRestaurant.childFriendly];
        [vegaterianArray addObject:currentRestaurant.vegaterian];
    }
    
    NSDictionary *restaurantsAttributesDicitonary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:priceArray,carParkArray,gardenArray,liveMusicArray,childFriendlyArray,vegaterianArray,smokingArray, nil]
                                                                                forKeys:[NSArray arrayWithObjects:kPrice,kCarPark,kGarden,kLiveMusic,kChildfriendly,kVegaterian,kSmoking, nil]];

    return restaurantsAttributesDicitonary;
}





@end
