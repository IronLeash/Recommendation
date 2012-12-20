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
#import "ActionGeneric.h"

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

-(NSDictionary*)getUserPreferenceWeightDicitonary:(User*)aUser{

    NSArray *userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    
    //Entropies
    NSDictionary *entrophyDicitonary = [[PreferencesManager sharedInstance] getEntrophyDictionary];
  
    double priceEntropy  = [[entrophyDicitonary objectForKey:kPrice] doubleValue];
    double gardenEntropy = [[entrophyDicitonary objectForKey:kGarden] doubleValue];
    double liveMusicEntrophy= [[entrophyDicitonary objectForKey:kLiveMusic] doubleValue];
    double childEntropy= [[entrophyDicitonary objectForKey:kChildfriendly] doubleValue];
    double vegEntrophy= [[entrophyDicitonary objectForKey:kVegaterian] doubleValue];
    double categoryEntrophy= [[entrophyDicitonary objectForKey:kCategory] doubleValue];
    double cuisineEntrophy= [[entrophyDicitonary objectForKey:kCuisine] doubleValue];
    double locationEntrophy= [[entrophyDicitonary objectForKey:kLocation] doubleValue];
    double smokingEntrophy= [[entrophyDicitonary objectForKey:kSmoking] doubleValue];
    
    double total = priceEntropy +gardenEntropy+liveMusicEntrophy+childEntropy+vegEntrophy+categoryEntrophy+cuisineEntrophy+locationEntrophy+smokingEntrophy;

    //Normalize
    priceEntropy        /= total;
    gardenEntropy       /= total;
    liveMusicEntrophy   /= total;
    childEntropy        /= total;
    vegEntrophy         /= total;
    categoryEntrophy    /= total;
    cuisineEntrophy     /= total;
    locationEntrophy    /= total;
    smokingEntrophy     /= total;
    
    //Correlations
    NSMutableArray *weightedAverageArray = [ActionGeneric weightedAveraRatingsArrayForRatings:userRatings];
    
    NSDictionary *restaurantVauesDicitonary = [ActionGeneric restaurantAttributevaluesForRatings:userRatings];

    double priceRangeCorrelation    =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kPrice] andArray2:weightedAverageArray];
    double gardenCorrelation        =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kGarden] andArray2:weightedAverageArray];
    double liveMusicCorelation      =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kLiveMusic] andArray2:weightedAverageArray];
    double childFiendlyCorrelation  =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kChildfriendly] andArray2:weightedAverageArray];
    double vegateriancorrelation    =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kVegaterian] andArray2:weightedAverageArray];

    //Cramers V for nominal attributes
    
    double categoryyCramer = [StatisticsLibrary cramersVforAttribute:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:@"Category" OfUser:aUser]];
    double cuisineCramer = [StatisticsLibrary cramersVforAttribute:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:@"Cuisine" OfUser:aUser]];
    double locationCramer = [StatisticsLibrary cramersVforAttribute:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:@"Location" OfUser:aUser]];
    double smokingCramer = [StatisticsLibrary cramersVforAttribute:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:@"Smoking" OfUser:aUser]];


    return nil;
}


-(NSDictionary*)getPreferencesDictionaryForUser:(User*)aUser{
    
    NSArray *positiveRatingsArray = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    
    float vegetarian = 0;
    float childFriendly = 0;
    float liveMusic = 0;
    float garden = 0;
    float priceRange = 0;

    
    for (RestaurantRating *currentRating in positiveRatingsArray)
    {
#warning you can add a weighting factor according to rating value
        vegetarian     += [currentRating.restaurant.vegaterian floatValue];
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
    
    NSArray *favoriteCategories = [[RatingsManager sharedInstance] getFavoriteCategoriesForUser:aUser];
    NSArray *favoriteCuisines = [[RatingsManager sharedInstance] getFavoriteCuisinesForUser:aUser];
    NSArray *favoriteSmoking = [[RatingsManager sharedInstance] getFavoriteSmokingForUser:aUser];
    NSArray *favoriteLocation = [[RatingsManager sharedInstance] getFavoriteLocationForUser:aUser];
    

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
                                                                      forKeys:[NSArray arrayWithObjects:kVegaterian,kChildfriendly,kLiveMusic,kGarden,kPrice,kCategory,kCuisine,kSmoking,kLocation,nil]];
    
    return preferencesDictionary;
}

//Creates empty  contigency table according to to cardinality of attribute
-(NSMutableArray*)contingencyMatrixForAttribute:(NSString*)anAttribute{

    NSMutableArray *contingancyMatrix = [[NSMutableArray alloc] initWithCapacity:10];
    
    if ([anAttribute isEqualToString:kCategory])
    {
        for (int i = 0; i < 10 ; i++) {
            //19
            NSMutableArray *colomn = [[NSMutableArray alloc] initWithCapacity:0];
            for (int categories = 0; categories < 19; i++){
                [colomn addObject:[NSNumber numberWithInt:0]];
            }
            
            [contingancyMatrix addObject:colomn];
        }
        
    }else if ([anAttribute isEqualToString:kCuisine]){
        
        //16
        for (int i = 0; i < 10 ; i++) {
            //16
            NSMutableArray *colomn = [[NSMutableArray alloc] initWithCapacity:0];
            for (int categories = 0; categories < 16; i++){
                [colomn addObject:[NSNumber numberWithInt:0]];
            }
            
            [contingancyMatrix addObject:colomn];
        }
    
    }else if ([anAttribute isEqualToString:kSmoking]){
    
        for (int i = 0; i < 10 ; i++) {
            //3
            NSMutableArray *colomn = [[NSMutableArray alloc] initWithCapacity:0];
            for (int categories = 0; categories < 3; i++){
                [colomn addObject:[NSNumber numberWithInt:0]];
            }
            
            [contingancyMatrix addObject:colomn];
        }
        
    }else{
    
        for (int i = 0; i < 10 ; i++) {
            //16
            NSMutableArray *colomn = [[NSMutableArray alloc] initWithCapacity:0];
            for (int categories = 0; categories < 16; i++){
                [colomn addObject:[NSNumber numberWithInt:0]];
            }
            
            [contingancyMatrix addObject:colomn];
        }
    
    }
    
    return contingancyMatrix;

}

-(NSMutableArray*)contingencyMatrixForAttribute:(NSString*)anAttribute OfUser:(User*)aUser{
    
    NSArray *ratingsArray = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];

    NSMutableArray *weightedAverageArray = [ActionGeneric weightedAveraRatingsArrayForRatings:ratingsArray];

    //Empty Arrax of Arrays as Matrix
    NSMutableArray *contingancyMatrix;
    

    //Create empty Matrix For Attribute
    if([anAttribute isEqualToString:kSmoking]){
        contingancyMatrix = [NSMutableArray arrayWithArray:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:kSmoking]];
    }else if ([anAttribute isEqualToString:kLocation]){
        contingancyMatrix = [NSMutableArray arrayWithArray:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:kLocation]];
    }else if ([anAttribute isEqualToString:kCuisine]){
        contingancyMatrix = [NSMutableArray arrayWithArray:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:kCuisine]];
    }else if ([anAttribute isEqualToString:kCategory]){
        contingancyMatrix = [NSMutableArray arrayWithArray:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:kCategory]];
    }

    for (int i = 0; i <[ratingsArray count]; i++)
    {
        
        //Colomn corresponds to Ratings round to integer from 1-10
        int colommNumber = [[weightedAverageArray objectAtIndex:i] intValue];
        //Row is the position of a particular
        int rowNumber = 0;
        
        if([anAttribute isEqualToString:kSmoking]){
        
            rowNumber = [[[[ratingsArray objectAtIndex:i] restaurant ]smoking] intValue];
            
        }else if ([anAttribute isEqualToString:kLocation]){
            rowNumber = [[[[ratingsArray objectAtIndex:i] restaurant ]location] intValue];

        }else if ([anAttribute isEqualToString:kCuisine]){

            //Get current Cuisine String
            NSString *currentCuisine = [[[ratingsArray objectAtIndex:i] restaurant ]cuisine];
            //Find its location in the cuisine array, It corresponds to position in contigency array
            rowNumber = [ActionGeneric cuisinePosiitonInContigencyMatrix:currentCuisine];
            
        }else if ([anAttribute isEqualToString:kCategory]){
        
            //Get current Category String
            NSString *currentCategory = [[[ratingsArray objectAtIndex:i] restaurant ]category];
            //Find its location in the cuisine array, It corresponds to position in contigency array
            rowNumber = [ActionGeneric cuisinePosiitonInContigencyMatrix:currentCategory];

        }
        
        int currentValue = [[[contingancyMatrix objectAtIndex:colommNumber] objectAtIndex:rowNumber] intValue];
        currentValue++;
        
        [[contingancyMatrix objectAtIndex:colommNumber] replaceObjectAtIndex:rowNumber withObject:[NSNumber numberWithInt:currentValue]];
    }
    
    return contingancyMatrix;
    
}

@end
