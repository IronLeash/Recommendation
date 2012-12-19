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

@end
