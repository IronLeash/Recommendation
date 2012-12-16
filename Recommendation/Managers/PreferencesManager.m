//
//  PreferencesManager.m
//  Recommendation
//
//  Created by Ilker Baltaci on 12/14/12.
//  Copyright (c) 2012 ilker. All rights reserved.
//


#import "Restaurant.h"

#import "PreferencesManager.h"
#import "RatingsManager.h"
#import "StatisticsLibrary.h"
#import "RestaurantRating.h"
#import "DataFetcher.h"
#import "Constants.h"
#import "User.h"

@implementation PreferencesManager

static PreferencesManager* preferencesManager = nil;

+(PreferencesManager*)sharedInstance;
{
	@synchronized([PreferencesManager class])
	{

		if (!preferencesManager)
        {
            
            return [[self alloc] init];
        }else{
            return preferencesManager;
        }
    }
    
	return nil;
}


#pragma mark - Setters

-(void)setEntrophyDictionary{
    
    //Restaurants generated save entropies in NSUserDefauls
    NSDictionary *restaurantAttributesEntropyDictionary = [StatisticsLibrary entopyOfVariable];
    [[NSUserDefaults standardUserDefaults] setObject:restaurantAttributesEntropyDictionary forKey:kRestaurantAttributesEntropyDistionary];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setUserPreferenceWeightDicitonary:(User*)aUser{


}

//Getters

-(NSDictionary*)getEntrophyDictionary{

    NSDictionary *returnDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kRestaurantAttributesEntropyDistionary];
    
    if (returnDictionary) {
        [[PreferencesManager sharedInstance] setEntrophyDictionary];
        returnDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kRestaurantAttributesEntropyDistionary];
    }
    return returnDictionary;

}



-(NSDictionary*)getPreferencesDictionaryForUser:(User*)aUser{
    
    NSArray *positiveRatingsArray = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    
    float vegetarian = 0;
    float childFriendly = 0;
    float liveMusic = 0;
    float garden = 0;
    float priceRange = 0;
    
    NSArray *favoriteCategories = [[RatingsManager sharedInstance] getFavoriteCategoriesForUser:aUser];
    
    NSArray *favoriteCuisines = [[RatingsManager sharedInstance] getFavoriteCuisinesForUser:aUser];
    NSArray *favoriteSmoking = [[RatingsManager sharedInstance] getFavoriteSmokingForUser:aUser];
    NSArray *favoriteLocation = [[RatingsManager sharedInstance] getFavoriteLocationForUser:aUser];
    
    for (RestaurantRating *currentRating in positiveRatingsArray)
    {
#warning you can add a weighting factor according to rating value
        vegetarian     += [currentRating.restaurant.vegeterian floatValue];
        childFriendly  += [currentRating.restaurant.childFriendly floatValue];
        liveMusic      += [currentRating.restaurant.liveMusic floatValue];
        garden         += [currentRating.restaurant.garden floatValue];
        priceRange     += [currentRating.restaurant.priceRange floatValue];
    }
    
    vegetarian     = vegetarian/[positiveRatingsArray count];
    childFriendly  = childFriendly/ [positiveRatingsArray count];
    liveMusic      = liveMusic / [positiveRatingsArray count];
    garden         = garden / [positiveRatingsArray count];
    priceRange     = priceRange / [positiveRatingsArray count];
    
    NSDictionary *preferencesDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                               [NSNumber numberWithFloat:vegetarian],
                                                                               [NSNumber numberWithFloat:childFriendly],
                                                                               [NSNumber numberWithFloat:liveMusic],
                                                                               [NSNumber numberWithFloat:garden],
                                                                               [NSNumber numberWithFloat:priceRange],
                                                                               favoriteCategories,
                                                                               favoriteCuisines,
                                                                               favoriteSmoking,
                                                                               favoriteLocation,
                                                                               nil]
                                                                      forKeys:[NSArray arrayWithObjects:kVegetarian,kChildfriendly,kLiveMusic,kGarden,kPrice,kCategory,kCuisine,kSmoking,kLocation,nil]];
    
    return preferencesDictionary;
}


@end
