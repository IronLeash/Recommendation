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

#import "FavoriteCategory.h"
#import "FavoriteCuisine.h"
#import "FavoriteSmoking.h"

@implementation ActionGeneric

+(int)cuisinePosiitonInContigencyMatrix:(NSString*)attributeValue{

    NSArray *cuisinesArray = [[DataFetcher sharedInstance] getRestaurantCuisines];
    
    int position = (int)[cuisinesArray indexOfObject:attributeValue] ;
    
    if (position == NSNotFound) {
        position = -1;
    }

    return position;

}

+(int)categoryPosiitonInContigencyMatrix:(NSString*)attributeValue{

    NSArray *categoriesArray = [[DataFetcher sharedInstance] getRestaurantCategories];

    int position = (int)[categoriesArray indexOfObject:attributeValue];
    
    if (position == NSNotFound) {
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
//        [vegaterianArray addObject:currentRestaurant.vegaterian];
    }
    
    NSDictionary *restaurantsAttributesDicitonary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:priceArray,carParkArray,gardenArray,liveMusicArray,childFriendlyArray,vegaterianArray,smokingArray, nil]
                                                                                forKeys:[NSArray arrayWithObjects:kPrice,kCarPark,kGarden,kLiveMusic,kChildfriendly,kVegaterian,kSmoking, nil]];

    return restaurantsAttributesDicitonary;
}

+(NSArray*)normalizePriceRangeForRatings:(NSArray*)anArray{

    NSMutableArray *normalizedArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    for (NSNumber *currentNumber in anArray) {
        
        
        if ([currentNumber intValue] ==0) {
            [normalizedArray addObject:[NSNumber numberWithDouble:2.5]];
        } else {
            [normalizedArray addObject:[NSNumber numberWithDouble:(2.5*[currentNumber intValue])]];
        }
    }

    return normalizedArray;
}

+(void)printContigencyMatrix:(NSArray*)anArray
{
    NSUInteger rowNumber = [(NSArray*)[anArray objectAtIndex:0] count];
    NSUInteger colomnNumbr = [anArray count];

//    NSLog(@"---------------Contigency Matrix---------------");

    for (int i =0;i < rowNumber; i++)
    {
        NSMutableString *currentRowString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"A %d:",i]];
        
        for (int j = 0; j < colomnNumbr; j++) {
            [currentRowString appendString:[NSString stringWithFormat:@" %@",[(NSArray*)[anArray objectAtIndex:j] objectAtIndex:i]]];
        }
//        NSLog(@"%@",currentRowString);
    }

}

+(int)positionInArray:(NSArray*)anArray :(id)term{

    int position = 0;

    
    for (id element in anArray) {
    
        if ([element isKindOfClass:[FavoriteCategory class]]) {
    
            if ([[(FavoriteCategory*)element name] isEqualToString:(NSString*)term]) {
                break;
            }else{
                position++;
            }
        }else if ([element isKindOfClass:[FavoriteCuisine class]]){
            if ([[(FavoriteCuisine*)element name] isEqualToString:(NSString*)term]) {
                break;
            }else{
                position++;
            }
        
        }else{
        
            if ([(FavoriteSmoking*)element value] == (NSNumber*)term) {
                break;
            }else{
                position++;
            }
        }
    
    }
    
    return position;
}



+(NSArray*)sortRecommendationObjects:(NSArray*)anArray{

    NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithCapacity:[anArray count]];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self.rating" ascending:NO];

    [sortedArray addObjectsFromArray:[anArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]];
    
    return sortedArray;
}



@end
