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

@synthesize entrophyWeight;
@synthesize recalculateWeights;

static PreferencesManager* preferencesManager = nil;

+(PreferencesManager*)sharedInstance;
{
	@synchronized([PreferencesManager class])
	{

		if (!preferencesManager)
        {
            preferencesManager = [[self alloc] init];
        }
            return preferencesManager;
    }
    
	return nil;
}

#pragma mark - Setters
-(void)setCurrentUser:(User*)aUser{

//
}

-(void)setEntrophyDictionary{
    
    //Restaurants generated save entropies in NSUserDefauls
    NSDictionary *restaurantAttributesEntropyDictionary = [StatisticsLibrary entopyOfVariable];
    [[NSUserDefaults standardUserDefaults] setObject:restaurantAttributesEntropyDictionary forKey:kRestaurantAttributesEntropyDistionary];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//Getters
#pragma mark - Getters
-(NSDictionary*)getEntrophyDictionary{

    NSDictionary *returnDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kRestaurantAttributesEntropyDistionary];
    
    if (returnDictionary) {
        [[PreferencesManager sharedInstance] setEntrophyDictionary];
        returnDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kRestaurantAttributesEntropyDistionary];
    }
    return returnDictionary;

}

-(NSDictionary*)getUserPreferenceWeightDicitonary:(User*)aUser{

    NSDictionary *userWeightDictionary;

    if ([aUser.userid isEqualToString:userId] && recalculateWeights) {

        return currentUserPreferenceWeight;
    }else{
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
//    double locationEntrophy= [[entrophyDicitonary objectForKey:kLocation] doubleValue];
    double smokingEntrophy= [[entrophyDicitonary objectForKey:kSmoking] doubleValue];
    double carPArkEntrophy= [[entrophyDicitonary objectForKey:kCarPark] doubleValue];
    

    double total = priceEntropy +gardenEntropy+liveMusicEntrophy+childEntropy+vegEntrophy+categoryEntrophy+cuisineEntrophy+carPArkEntrophy+smokingEntrophy;

    //Normalize
    priceEntropy        /= total;
    gardenEntropy       /= total;
    liveMusicEntrophy   /= total;
    childEntropy        /= total;
    vegEntrophy         /= total;
    categoryEntrophy    /= total;
    cuisineEntrophy     /= total;
    smokingEntrophy     /= total;
    carPArkEntrophy     /= total;

    //Correlations
    NSMutableArray *weightedAverageArray = [ActionGeneric weightedAveraRatingsArrayForRatings:userRatings];
    
    NSDictionary *restaurantVauesDicitonary = [ActionGeneric restaurantAttributevaluesForRatings:userRatings];

    double priceRangeCorrelation    =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [ActionGeneric normalizePriceRangeForRatings:[restaurantVauesDicitonary objectForKey:kPrice]] andArray2:weightedAverageArray];
    double gardenCorrelation        =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kGarden] andArray2:weightedAverageArray];
    double liveMusicCorelation      =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kLiveMusic] andArray2:weightedAverageArray];
    double childFiendlyCorrelation  =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kChildfriendly] andArray2:weightedAverageArray];
    double vegateriancorrelation    =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                         [restaurantVauesDicitonary objectForKey:kVegaterian] andArray2:weightedAverageArray];
    
    double carParkCorrelation       =   [StatisticsLibrary pearsonCorreleationBetweenArray1:
                                             [restaurantVauesDicitonary objectForKey:kCarPark] andArray2:weightedAverageArray];
        
        
    //Take Absolute Values
    priceRangeCorrelation   = ABS(priceRangeCorrelation);
    gardenCorrelation       = ABS(gardenCorrelation);
    liveMusicCorelation     = ABS(liveMusicCorelation);
    childFiendlyCorrelation = ABS(childFiendlyCorrelation);
    vegateriancorrelation   = ABS(vegateriancorrelation);
    carParkCorrelation      = ABS(carParkCorrelation);

        
    //Cramers V for nominal attributes
    
    double categoryyCramer = [StatisticsLibrary cramersVforAttribute:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:@"Category" OfUser:aUser]];
    double cuisineCramer = [StatisticsLibrary cramersVforAttribute:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:@"Cuisine" OfUser:aUser]];
//    double locationCramer = [StatisticsLibrary cramersVforAttribute:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:@"Location" OfUser:aUser]];
    double smokingCramer = [StatisticsLibrary cramersVforAttribute:[[PreferencesManager sharedInstance] contingencyMatrixForAttribute:@"Smoking" OfUser:aUser]];

    
    //Unnormalized Weights
    
    double priceWeight          = (priceRangeCorrelation*(1-entrophyWeight))+(priceEntropy*entrophyWeight);
    double gardenWeight         = (gardenCorrelation*(1-entrophyWeight)) + (gardenEntropy*entrophyWeight);
    double liveMusicWeight      = (liveMusicCorelation*(1-entrophyWeight))+(liveMusicEntrophy*entrophyWeight);
    double childFriendlyWeight  = (childFiendlyCorrelation*(1-entrophyWeight))+(childEntropy*entrophyWeight);
//    double vegaterianWeight     = (vegateriancorrelation*(1-entrophyWeight))+(vegEntrophy*entrophyWeight);
    double categoryWeight       = (categoryyCramer*(1-entrophyWeight))+(categoryEntrophy*entrophyWeight);
    double cuisineWeight        = (cuisineCramer*(1-entrophyWeight))+cuisineEntrophy*(entrophyWeight);
//    double locationWeight       = (locationCramer*(1-entrophyWeight))+(locationEntrophy*entrophyWeight);
    double smokingWeight        = (smokingCramer*(1-entrophyWeight))+(smokingEntrophy*entrophyWeight);
    double carPArkWeigt        = (carParkCorrelation*(1-entrophyWeight))+(carPArkEntrophy*entrophyWeight);

        
        
    double weighttotal = priceWeight+gardenWeight+liveMusicWeight+childFriendlyWeight+categoryWeight+cuisineWeight+smokingWeight;
        
    priceWeight          /= weighttotal;
    gardenWeight         /= weighttotal;
    liveMusicWeight      /= weighttotal;
    childFriendlyWeight  /= weighttotal;
//    vegaterianWeight     /= weighttotal;
    categoryWeight       /= weighttotal;
    cuisineWeight        /= weighttotal;
//    locationWeight       /= weighttotal;
    smokingWeight        /= weighttotal;
    carPArkWeigt        /= weighttotal;
        
        userWeightDictionary = [NSDictionary dictionaryWithObjects:
                                      [NSArray arrayWithObjects:
                                       [NSNumber numberWithDouble:priceWeight],
                                       [NSNumber numberWithDouble:gardenWeight],
                                       [NSNumber numberWithDouble:liveMusicWeight],
                                       [NSNumber numberWithDouble:childFriendlyWeight],
                                       [NSNumber numberWithDouble:categoryWeight],
                                       [NSNumber numberWithDouble:cuisineWeight],
                                       [NSNumber numberWithDouble:carPArkWeigt],
                                       [NSNumber numberWithDouble:smokingWeight],nil]
                                      
                                                                 forKeys:[NSArray arrayWithObjects:
                                                                          kPrice,
                                                                          kGarden,
                                                                          kLiveMusic,
                                                                          kChildfriendly,
                                                                          kCategory,
                                                                          kCuisine,
                                                                          kCarPark,
                                                                          kSmoking,nil]];
        
        currentUserPreferenceWeight = [NSDictionary dictionaryWithDictionary:userWeightDictionary];
    }
    return currentUserPreferenceWeight;
}


-(NSDictionary*)getPreferencesDictionaryForUser:(User*)aUser{
    
    NSDictionary *preferencesDictionary;
    
    if (![aUser.userid isEqualToString:userId]){
        
    NSArray *positiveRatingsArray = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    
    float vegetarian = 0;
    float childFriendly = 0;
    float liveMusic = 0;
    float garden = 0;
    float priceRange = 0;
    float carPark = 0;
    
    for (RestaurantRating *currentRating in positiveRatingsArray)
    {
#warning you can add a weighting factor according to rating value
//        vegetarian     += [currentRating.restaurant.vegaterian floatValue];
        childFriendly  += [currentRating.restaurant.childFriendly floatValue];
        liveMusic      += [currentRating.restaurant.liveMusic floatValue];
        garden         += [currentRating.restaurant.garden floatValue];
        priceRange     += [currentRating.restaurant.priceRange floatValue];
        carPark        += [currentRating.restaurant.carPark floatValue];
    }
    
    vegetarian     = vegetarian/[positiveRatingsArray count];
    childFriendly  = childFriendly/ [positiveRatingsArray count];
    liveMusic      = liveMusic / [positiveRatingsArray count];
    garden         = garden / [positiveRatingsArray count];
    priceRange     = priceRange / [positiveRatingsArray count];
    carPark        = carPark / [positiveRatingsArray count];

        
    NSArray *favoriteCategories = [[RatingsManager sharedInstance] getFavoriteCategoriesForUser:aUser];
    NSArray *favoriteCuisines = [[RatingsManager sharedInstance] getFavoriteCuisinesForUser:aUser];
    NSArray *favoriteSmoking = [[RatingsManager sharedInstance] getFavoriteSmokingForUser:aUser];
    NSArray *favoriteLocation = [[RatingsManager sharedInstance] getFavoriteLocationForUser:aUser];
    

     preferencesDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                               [NSNumber numberWithFloat:vegetarian],
                                                                               [NSNumber numberWithFloat:childFriendly],
                                                                               [NSNumber numberWithFloat:liveMusic],
                                                                               [NSNumber numberWithFloat:garden],
                                                                               [NSNumber numberWithFloat:priceRange],
                                                                                [NSNumber numberWithFloat:carPark],
                                                                               favoriteCategories,
                                                                               favoriteCuisines,
                                                                               favoriteSmoking,
                                                                               favoriteLocation,
                                                                               nil]
                                                                      forKeys:[NSArray arrayWithObjects:kVegaterian,kChildfriendly,kLiveMusic,kGarden,kPrice,kCarPark,kCategory,kCuisine,kSmoking,kLocation,nil]];
    
    currentPreferencesDictionary = [NSDictionary dictionaryWithDictionary:preferencesDictionary];
    currentUserPreferenceWeight = [[PreferencesManager sharedInstance] getUserPreferenceWeightDicitonary:aUser];
    userId = [[NSString alloc] initWithString:aUser.userid];
    }else{
        preferencesDictionary = currentPreferencesDictionary;
    }
    
    return preferencesDictionary;
}

-(User*)getCurrentUser
{
    return currentUser;
}

//Creates empty  contigency table according to to cardinality of attribute
-(NSMutableArray*)contingencyMatrixForAttribute:(NSString*)anAttribute{

    NSMutableArray *contingancyMatrix = [[NSMutableArray alloc] initWithCapacity:10];
    
    if ([anAttribute isEqualToString:kCategory])
    {
        for (int i = 0; i < 10 ; i++) {
            //19
            NSMutableArray *colomn = [[NSMutableArray alloc] initWithCapacity:0];
            for (int categories = 0; categories < 19; categories++){
                [colomn addObject:[NSNumber numberWithInt:0]];
            }
            
            [contingancyMatrix addObject:colomn];
        }
        
    }else if ([anAttribute isEqualToString:kCuisine]){
        
        //16
        for (int i = 0; i < 10 ; i++) {
            //16
            NSMutableArray *colomn = [[NSMutableArray alloc] initWithCapacity:0];
            for (int cuisines = 0; cuisines < 16; cuisines++){
                [colomn addObject:[NSNumber numberWithInt:0]];
            }
            
            [contingancyMatrix addObject:colomn];
        }
    
    }else if ([anAttribute isEqualToString:kSmoking]){
    
        for (int i = 0; i < 10 ; i++) {
            //3
            NSMutableArray *colomn = [[NSMutableArray alloc] initWithCapacity:0];
            for (int smoking = 0; smoking < 3; smoking++){
                [colomn addObject:[NSNumber numberWithInt:0]];
            }
            
            [contingancyMatrix addObject:colomn];
        }
        
    }else{
    
        for (int i = 0; i < 10 ; i++) {
            //16
            NSMutableArray *colomn = [[NSMutableArray alloc] initWithCapacity:0];
            for (int location = 0; location < 16; location++){
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
        int colommNumber = [[weightedAverageArray objectAtIndex:i] intValue]-1;
        
        if (colommNumber == -1) {
            colommNumber =0;
        }
        if (colommNumber >9) {

            NSLog(@"Fuck!");
        }
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
            rowNumber = [ActionGeneric categoryPosiitonInContigencyMatrix:currentCategory];

        }
        
        int currentValue = [[[contingancyMatrix objectAtIndex:colommNumber] objectAtIndex:rowNumber] intValue];
        currentValue++;
        
        [[contingancyMatrix objectAtIndex:colommNumber] replaceObjectAtIndex:rowNumber withObject:[NSNumber numberWithInt:currentValue]];
    }
    
    return contingancyMatrix;
    
}

#pragma mark - Individual Values

-(double)getGardenOf:(User*)aUser{
    
    double garden;
    if ([aUser isEqualTo:currentUser] && currentPreferencesDictionary) {
        garden = [[currentPreferencesDictionary objectForKey:kGarden] doubleValue];
    }else{
    
        NSDictionary *localPreferencesDictionary = [[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:aUser];
        garden = [[localPreferencesDictionary objectForKey:kGarden] doubleValue];    
    }
    
    return garden;
}

-(double)getLiveMusic:(User*)aUser{

    double liveMusic;
    if ([aUser isEqualTo:currentUser] && currentPreferencesDictionary) {
        liveMusic = [[currentPreferencesDictionary objectForKey:kLiveMusic] doubleValue];
    }else{
        
        NSDictionary *localPreferencesDictionary = [[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:aUser];
        liveMusic = [[localPreferencesDictionary objectForKey:kLiveMusic] doubleValue];
    }
    
    return liveMusic;

}

-(double)getChildFriendly:(User*)aUser{

    double childFriendly;
    if ([aUser isEqualTo:currentUser] && currentPreferencesDictionary) {
        childFriendly = [[currentPreferencesDictionary objectForKey:kChildfriendly] doubleValue];
    }else{
        
        NSDictionary *localPreferencesDictionary = [[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:aUser];
        childFriendly = [[localPreferencesDictionary objectForKey:kChildfriendly] doubleValue];
    }
    
    return childFriendly;
}


-(double)getCarPark:(User*)aUser{
    
    double carPark;
    if ([aUser isEqualTo:currentUser] && currentPreferencesDictionary) {
        carPark = [[currentPreferencesDictionary objectForKey:kCarPark] doubleValue];
    }else{
        
        NSDictionary *localPreferencesDictionary = [[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:aUser];
        carPark = [[localPreferencesDictionary objectForKey:kCarPark] doubleValue];
    }
    
    return carPark;
}


-(double)getVegaterian:(User*)aUser{
    
    double carPark;
    if ([aUser isEqualTo:currentUser] && currentPreferencesDictionary) {
        carPark = [[currentPreferencesDictionary objectForKey:kVegaterian] doubleValue];
    }else{
        
        NSDictionary *localPreferencesDictionary = [[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:aUser];
        carPark = [[localPreferencesDictionary objectForKey:kVegaterian] doubleValue];
    }
    
    return carPark;
}


@end
