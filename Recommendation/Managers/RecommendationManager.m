//
//  RecommendationManager.m
//  Recommendation
//
//  Created by ilker on 28.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "RecommendationManager.h"
#import "PreferencesManager.h"

#import "RatingsManager.h"

#import "DataFetcher.h"

#import "Constants.h"
#import "ActionGeneric.h"

#import "Recommendation.h"


#import "StatisticsLibrary.h"
#import "RestaurantRating.h"

NSString *recommendationArrayGeneratedNotification = @"RecommendationGeneratedNotification";

static RecommendationManager *recommendationManager;

@implementation RecommendationManager

@synthesize alphaWeight;

+(RecommendationManager*)sharedInstance{
    @synchronized(self)
    {
        if (recommendationManager==nil)
        {
            recommendationManager = [[self alloc] init];
        }
        return recommendationManager;
    }
}

-(id)init{

	self = [super init];
	if (self != nil) {

	}
    
	return self;
}

//This method returns array of reccomendation objects
-(NSArray*)getRecommendationForUser:(User*)anUser withPreferences:(NSDictionary*)preferences andWeight:(NSDictionary*)weights onlyPosiiveRatings:(BOOL)aBool{

    NSMutableArray *recommendationsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    /*
    double categoryWeight   = [[weights objectForKey:kCategory] doubleValue];
    double cuisineWeight    = [[weights objectForKey:kCuisine] doubleValue];
    double priceWeight      = [[weights objectForKey:kPrice] doubleValue];
    double smokingWeight    = [[weights objectForKey:kSmoking] doubleValue];
    
    double gardenWeight             = [[weights objectForKey:kGarden] doubleValue];
    double liveMusicWeight          = [[weights objectForKey:kLiveMusic] doubleValue];
    double childFriendlyWeight      = [[weights objectForKey:kChildfriendly] doubleValue];
//    double vegaterianWeight         = [[weights objectForKey:kVegaterian] doubleValue];

    
    NSArray *orderedCategoryArray   = [preferences objectForKey:kCategory];
    NSArray *orderedCuisineArray    = [preferences objectForKey:kCuisine];
    NSArray *orderedSmokingArray    = [preferences objectForKey:kSmoking];

    */
    NSArray *restaurantsArray       = [[DataFetcher sharedInstance] getRestaurants];

    NSArray *restaurantRatingsArray = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
    
    for (Restaurant *currentRestaurant in restaurantsArray) {

        NSPredicate *currentRatingPredicate         = [NSPredicate predicateWithFormat:@"restaurant.uniqueName == %@",currentRestaurant.uniqueName];
        RestaurantRating *currentRestaurantRating   = [[restaurantRatingsArray filteredArrayUsingPredicate:currentRatingPredicate] objectAtIndex:0];

//        [[RecommendationManager sharedInstance] overalRatingPredictionOfRestaurant:currentRestaurant ForUser:anUser onlyPosivite:aBool];
        
        Recommendation *currentRecommendation = [[Recommendation alloc] init];
        currentRecommendation.restaurant = currentRestaurant;
        currentRecommendation.rating = [[RecommendationManager sharedInstance] overalRatingPredictionOfRestaurant:currentRestaurant ForUser:anUser onlyPosivite:aBool];
        
        /*
        NSUInteger cuisinePosition     = [ActionGeneric positionInArray:orderedCuisineArray :currentRestaurant.cuisine];
        double categoryPosition    = ([ActionGeneric positionInArray:orderedCategoryArray :currentRestaurant.category])*19/16;
//        NSLog(@"Current Category %@ with Position %f",currentRestaurant.category,categoryPosition);
        
        double smokingPosition     = ([ActionGeneric positionInArray:orderedSmokingArray :currentRestaurant.smoking])*19/3;
        
        double pricePosition       = ([currentRestaurant.priceRange intValue] - [[preferences objectForKey:kPrice] intValue])*19/4;
        
         double gardenPosition      = ([currentRestaurant.garden doubleValue] - [[preferences objectForKey:kGarden] doubleValue])*19;
         double liveMusicPosition   = ([currentRestaurant.liveMusic doubleValue] - [[preferences objectForKey:kLiveMusic] doubleValue])*19;
         double childFriendly       = ([currentRestaurant.childFriendly doubleValue] - [[preferences objectForKey:kChildfriendly] doubleValue])*19;
//         double vegaterianFriendly  = ([currentRestaurant.vegaterian doubleValue] - [[preferences objectForKey:kVegaterian] doubleValue])*19;
        
        
        currentRecommendation.distance =    pow((double)(cuisinePosition), 2)*cuisineWeight +
        pow((double)(categoryPosition), 2)*categoryWeight +
        pow((double)(smokingPosition), 2)*smokingWeight +
        pow((double)(pricePosition), 2)*priceWeight +
        pow((double)(gardenPosition), 2)*gardenWeight +
        pow((double)(liveMusicPosition), 2)*liveMusicWeight +
        pow((double)(childFriendly), 2)*childFriendlyWeight;
//        pow((double)(vegaterianFriendly), 2)*vegaterianWeight;

         */
        
        
        currentRecommendation.realRating = [StatisticsLibrary weightedSumForRating:currentRestaurantRating];
        currentRecommendation.difference = currentRecommendation.realRating - currentRecommendation.rating;
        [recommendationsArray addObject:currentRecommendation];
    }
    
    //Post Notification
    
    NSArray *sortedRecommendationsArray =[ActionGeneric sortRecommendationObjects:recommendationsArray];
    NSNotification *recommendationNotification  = [NSNotification notificationWithName:recommendationArrayGeneratedNotification
                                                                                object:sortedRecommendationsArray];
    
    [[NSNotificationCenter defaultCenter] postNotification:recommendationNotification];
    
    return recommendationsArray;
}


#pragma mark - Rating Predictions

-(double)overalRatingPredictionOfRestaurant:(Restaurant*)aRestaurant ForUser:(User*)anUser onlyPosivite:(BOOL)aBool{
    
    //Count based Rating Prediction
    
    double garden           = [[RecommendationManager sharedInstance] countbasedGardenRatingofRestaurant:aRestaurant.garden ForUser:anUser]*10;
//    NSLog(@"Garden value %f",garden);
    double carPark          = [[RecommendationManager sharedInstance] countbasedCarParkRatingofRestaurant:aRestaurant.carPark ForUser:anUser]*10;
//        NSLog(@"Garden value %f",carPark);
    double liveMusic        = [[RecommendationManager sharedInstance] countbasedLiveMusicRatingofRestaurant:aRestaurant.liveMusic ForUser:anUser]*10;
//        NSLog(@"Garden value %f",liveMusic);
    double childFriendly    = [[RecommendationManager sharedInstance] countbasedChildFriendlyRatingofRestaurant:aRestaurant.childFriendly ForUser:anUser]*10;
//        NSLog(@"Garden value %f",childFriendly);
//    double vegaterian   = [[RecommendationManager sharedInstance] countbasedVegaterianRatingofRestaurant:aRestaurant ForUser:anUser]*10;
//        NSLog(@"vegaterian value %f",vegaterian);
    
    double category     = [[RecommendationManager sharedInstance] countBasedRatingForCategoryOfRestaurant:aRestaurant.category andUser:anUser onlyPositive:aBool];
    double cuisine      = [[RecommendationManager sharedInstance] countBasedRatingForCuisineOfRestaurant:aRestaurant.cuisine andUser:anUser onlyPositive:aBool];
//    double location     = [[RecommendationManager sharedInstance] countBasedRatingForLocationOfRestaurant:aRestaurant andUser:anUser onlyPositive:aBool];
    double smoking      = [[RecommendationManager sharedInstance] countBasedRatingForSmokingOfRestaurant:aRestaurant.smoking andUser:anUser onlyPositive:aBool];
    double pricerange   = [[RecommendationManager sharedInstance] countBasedRatingForPriceOfRestaurant:aRestaurant.priceRange andUser:anUser onlyPositive:aBool];

    //Rating Based Predictions
    double ratingBasedGarden        = [[RecommendationManager sharedInstance] pastRatingBasedGardenRatingofRestaurant:aRestaurant.garden ForUser:anUser onlyPositive:aBool];
    double ratingBaseCarPark        = [[RecommendationManager sharedInstance] pastRatingBasedCarParkRatingofRestaurant:aRestaurant.carPark ForUser:anUser onlyPositive:aBool];
    double ratingBaseLiveMusic      = [[RecommendationManager sharedInstance] pastRatingBasedLiveMusicRatingofRestaurant:aRestaurant.liveMusic ForUser:anUser onlyPositive:aBool];
    double ratingBasedChildFriendly = [[RecommendationManager sharedInstance] pastRatingBasedChildFriendlyRatingofRestaurant:aRestaurant.childFriendly ForUser:anUser onlyPositive:aBool];

    double ratingBasedCateogry      = [[RecommendationManager sharedInstance] pastRatingBasedCategoryRatingofRestaurant:aRestaurant.category ForUser:anUser onlyPositive:aBool];
//    NSLog(@"ratingBasedCateogry %f",ratingBasedCateogry);
    double ratingBasedCuisine       = [[RecommendationManager sharedInstance] pastRatingBasedCuisineRatingofRestaurant:aRestaurant.cuisine ForUser:anUser onlyPositive:aBool];
//    NSLog(@"ratingBasedCuisine %f",ratingBasedCuisine);
//    double ratingBasedLocation      = [[RecommendationManager sharedInstance] pastRatingBasedLocationRatingofRestaurant:aRestaurant ForUser:anUser onlyPositive:aBool];
//    NSLog(@"ratingBasedLocation %f",ratingBasedLocation);
    double ratingBasedSmoking       = [[RecommendationManager sharedInstance] pastRatingBasedSmokingRatingofRestaurant:aRestaurant.smoking ForUser:anUser onlyPositive:aBool];
//    NSLog(@"ratingBasedSmoking %f",ratingBasedSmoking);
    double ratingBasedPriceRange    = [[RecommendationManager sharedInstance] pastRatingBasedPriceRangeRatingofRestaurant:aRestaurant.priceRange ForUser:anUser onlyPositive:aBool];
//    NSLog(@"ratingBasedPriceRange %f",ratingBasedPriceRange);
//    double ratingBasedVegaterian    = [[RecommendationManager sharedInstance] pastRatingBasedVegaterianRatingofRestaurant:aRestaurant ForUser:anUser onlyPositive:aBool];
//    NSLog(@"ratingBasedVegaterian %f",ratingBasedVegaterian);
    

    
    double bothGarden           = (garden*(1-alphaWeight) +(ratingBasedGarden*alphaWeight));
    double bothCarPark          = (carPark*(1-alphaWeight) + ratingBaseCarPark*alphaWeight);
    double bothLiveMusic        = (liveMusic*(1-alphaWeight) + ratingBaseLiveMusic*alphaWeight);
    double bothChildFriendly    = (childFriendly*(1-alphaWeight) + ratingBasedChildFriendly*alphaWeight);
    double bothCategory         = (category*(1-alphaWeight) +ratingBasedCateogry*alphaWeight);
    double bothCuisine          = (cuisine*(1-alphaWeight)+ratingBasedCuisine*alphaWeight);
//    double bothLocation         = (location*(1-alphaWeight)+ratingBasedLocation*alphaWeight);
    double bothSmoking          = (smoking*(1-alphaWeight)+ratingBasedSmoking*alphaWeight);
    double bothPricerange       = (pricerange*(1-alphaWeight)+ratingBasedPriceRange*alphaWeight);
//    double bothVegaterian       = (vegaterian*(1-alphaWeight)+ratingBasedVegaterian*alphaWeight);

    
#warning handle nan values
    NSDictionary *preferencesWeightDictionary = [[PreferencesManager sharedInstance] getUserPreferenceWeightDicitonary:anUser];
    
    double categoryWeight       = [[preferencesWeightDictionary objectForKey:kCategory] doubleValue];
    double cuisineWeight        = [[preferencesWeightDictionary objectForKey:kCuisine] doubleValue];
//    double locationWeight       = [[preferencesWeightDictionary objectForKey:kLocation] doubleValue];
    double smokingWeight        = [[preferencesWeightDictionary objectForKey:kSmoking] doubleValue];
    double priceRangeWeigt      = [[preferencesWeightDictionary objectForKey:kPrice] doubleValue];
    
    double gardenWeight         = [[preferencesWeightDictionary objectForKey:kGarden] doubleValue];
    double carParkWeight        = [[preferencesWeightDictionary objectForKey:kCarPark] doubleValue];
    double liveMusickWeight     = [[preferencesWeightDictionary objectForKey:kLiveMusic] doubleValue];
    double childFriendlykWeight = [[preferencesWeightDictionary objectForKey:kChildfriendly] doubleValue];
//    double vegaterianWeight     = [[preferencesWeightDictionary objectForKey:kVegaterian] doubleValue];

    
    
    double total = ((bothGarden*gardenWeight)+
                    (bothCarPark*carParkWeight)+
                    (bothLiveMusic*liveMusickWeight)+
                    (bothChildFriendly*childFriendlykWeight)+
                    (bothCategory*categoryWeight)+
                    (bothCuisine*cuisineWeight)+
//                    (bothLocation*locationWeight)+
                    (bothSmoking*smokingWeight)+
                    (bothPricerange*priceRangeWeigt));
    
    
    
    


    return total;
}

#pragma mark - Count based rating prediction

 -(double)countBasedRatingForCategoryOfRestaurant:(NSString*)aRestaurantCategory andUser:(User*)anUser onlyPositive:(BOOL)aBool{
  
     int maxNumber = 0;
     int minNumber = 0;
     
     if (aBool) {
         maxNumber = [[RatingsManager sharedInstance] getmaxCategoryForUser:anUser onlyPositiveRatings:YES];
         minNumber = [[RatingsManager sharedInstance] getMinCategoryForUser:anUser onlyPositiveRatings:YES];
     }else{
         maxNumber = [[RatingsManager sharedInstance] getmaxCategoryForUser:anUser onlyPositiveRatings:NO];
         minNumber = [[RatingsManager sharedInstance] getMinCategoryForUser:anUser onlyPositiveRatings:NO];
     }
     
     double prediction;;
 
     int currentNumber  =  (int)[[[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser WithCategoryOfrestaurant:aRestaurantCategory onlyPositive:aBool] count];
     
     if ((maxNumber-minNumber)==0) {
         prediction =0;
     }else{
         prediction = ((double)abs((currentNumber-minNumber)) /(maxNumber-minNumber))*10;
     }
     
     if (prediction>10) {
         NSLog(@"prediction %f",prediction);
     }
 
     return prediction;
 }

-(double)countBasedRatingForCuisineOfRestaurant:(NSString*)aRestaurantCuisine andUser:(User*)anUser onlyPositive:(BOOL)aBool{
    
    int minNumber = 0;
    int maxNumber =0;
    
    if (aBool) {
        minNumber = [[RatingsManager sharedInstance] getminCuisineForUser:anUser onlyPositiveRatings:YES];
        maxNumber = [[RatingsManager sharedInstance] getmaxCuisineForUser:anUser onlyPositiveRatings:YES];
    } else {
        minNumber = [[RatingsManager sharedInstance] getminCuisineForUser:anUser onlyPositiveRatings:NO];
        maxNumber = [[RatingsManager sharedInstance] getmaxCuisineForUser:anUser onlyPositiveRatings:NO];
    }

    double prediction;
    
    int currentNumber  =  (int)[[[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser WithCuisineOfrestaurant:aRestaurantCuisine onlyPositive:aBool] count];
    
    if ((maxNumber-minNumber)==0) {
        prediction =0;
    }else{
    prediction = ((double)abs((currentNumber-minNumber)) /(maxNumber-minNumber))*10;
    }
    
    
    if (prediction>10) {
        NSLog(@"prediction %f",prediction);
    }
    return prediction;
}

-(double)countBasedRatingForLocationOfRestaurant:(Restaurant*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool{
        
    int minNumber = 0;
    int maxNumber =0;
    
    if (aBool) {
        minNumber = [[RatingsManager sharedInstance] getminLocationForUser:anUser onlyPositiveRatings:YES];
        maxNumber = [[RatingsManager sharedInstance] getmaxLocationForUser:anUser onlyPositiveRatings:YES];
    } else {
        minNumber = [[RatingsManager sharedInstance] getminLocationForUser:anUser onlyPositiveRatings:NO];
        maxNumber = [[RatingsManager sharedInstance] getmaxLocationForUser:anUser onlyPositiveRatings:NO];
    }

    double prediction;;
    
    int currentNumber  =  (int)[[[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser WithLocationOfrestaurant:aRestaurant onlyPositive:aBool] count];
    
    if ((maxNumber-minNumber)==0) {
        prediction =0;
    }else{
        prediction = ((double)abs((currentNumber-minNumber)) /(maxNumber-minNumber))*10;
    }
    
    if (prediction>10) {
        NSLog(@"prediction %f",prediction);
    }
    
    return prediction;
}

-(double)countBasedRatingForSmokingOfRestaurant:(NSNumber*)aRestaurantSmoking andUser:(User*)anUser onlyPositive:(BOOL)aBool{
    
    int minNumber = 0;
    int maxNumber =0;
    
    if (aBool) {
        minNumber = [[RatingsManager sharedInstance] getminSmokingForUser:anUser onlyPositiveRatings:YES];
        maxNumber = [[RatingsManager sharedInstance] getmaxSmokingForUser:anUser onlyPositiveRatings:YES];
    } else {
        minNumber = [[RatingsManager sharedInstance] getminSmokingForUser:anUser onlyPositiveRatings:NO];
        maxNumber = [[RatingsManager sharedInstance] getmaxSmokingForUser:anUser onlyPositiveRatings:NO];
    }
    
    double prediction;
    
    int currentNumber  =  (int)[[[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser WithSmokingOfrestaurant:aRestaurantSmoking onlyPositive:aBool] count];
    
    if ((maxNumber-minNumber)==0) {
        prediction =0;
    }else{
        prediction = ((double)abs((currentNumber-minNumber)) /(maxNumber-minNumber))*10;
    }
    if (prediction>10) {
        NSLog(@"prediction %f",prediction);
        
        
        int minNumber = [[RatingsManager sharedInstance] getminSmokingForUser:anUser onlyPositiveRatings:YES];
        int maxNumber = [[RatingsManager sharedInstance] getmaxSmokingForUser:anUser onlyPositiveRatings:YES];
        
        double prediction;
        
        int currentNumber  =  (int)[[[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser WithSmokingOfrestaurant:aRestaurantSmoking onlyPositive:YES] count];
        
    }
    return prediction;
}

-(double)countBasedRatingForPriceOfRestaurant:(NSNumber*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool{
    
/*
    int minNumber = 0;
    int maxNumber =0;
    
    if (aBool) {
        minNumber = [[RatingsManager sharedInstance] getminPriceRangeForUser:anUser onlyPositiveRatings:YES];
        maxNumber = [[RatingsManager sharedInstance] getmaxPriceRangeForUser:anUser onlyPositiveRatings:YES];
    } else {
        minNumber = [[RatingsManager sharedInstance] getminPriceRangeForUser:anUser onlyPositiveRatings:NO];
        maxNumber = [[RatingsManager sharedInstance] getmaxPriceRangeForUser:anUser onlyPositiveRatings:NO];
    }
    
    double prediction;
    
    int currentNumber  =  (int)[[[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser WithPriceRangeOfrestaurant:aRestaurant onlyPositive:aBool] count];
    
    if ((maxNumber-minNumber)==0) {
        prediction =0;
    }else{
        prediction = ((double)abs((currentNumber-minNumber)) /(maxNumber-minNumber))*10;
    }
    
    
    if (prediction>10) {
        NSLog(@"prediction %f",prediction);
        
        int minNumber = [[RatingsManager sharedInstance] getminPriceRangeForUser:anUser onlyPositiveRatings:YES];
        int maxNumber = [[RatingsManager sharedInstance] getmaxPriceRangeForUser:anUser onlyPositiveRatings:YES];
        
        double prediction;;
        
        int currentNumber  =  (int)[[[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser WithPriceRangeOfrestaurant:aRestaurant onlyPositive:YES] count];
    }
    return prediction;

 */
    return 0;
}


-(double)countbasedGardenRatingofRestaurant:(NSNumber*)aRestaurantGarden ForUser:(User*)aUser{

    /*
    double currentResturantValue  = [aRestaurant doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getGardenOf:aUser] ;

    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
     */
    return 0;
}

-(double)countbasedCarParkRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser{

    /*
    double currentResturantValue  = [aRestaurant doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getCarPark:aUser] ;
    
    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
     */
    return 0;
}

-(double)countbasedLiveMusicRatingofRestaurant:(NSNumber*)aRestaurantLiveMusic ForUser:(User*)aUser{

    /*
    double currentResturantValue  = [aRestaurant.liveMusic doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getLiveMusic:aUser] ;
    
    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
     */

    return 0;
}

-(double)countbasedChildFriendlyRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser{

    /*
    double currentResturantValue  = [aRestaurant doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getChildFriendly:aUser] ;
    
    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
     */
}

/*
-(double)countbasedVegaterianRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

    double currentResturantValue  = [aRestaurant.childFriendly doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getVegaterian:aUser] ;
    
    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
}
 */

#pragma mark - Past ratings based prediction

//PAst Ratings based prediction
-(double)pastRatingBasedGardenRatingofRestaurant:(NSNumber*)gardenValue ForUser:(User*)aUser onlyPositive:(BOOL)aBool{
    NSArray *ratingsArray;
    if (aBool) {
    ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithGardenValueOfRestaurant:gardenValue onlyPositive:YES];
    }else{
    ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithGardenValueOfRestaurant:gardenValue onlyPositive:NO];
    }

    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
}

-(double)pastRatingBasedCarParkRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool{

    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithCarParkValueOfRestaurant:aRestaurant onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithCarParkValueOfRestaurant:aRestaurant onlyPositive:NO];
    }
    
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
}

-(double)pastRatingBasedLiveMusicRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool{

    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithLiveMusicValueOfRestaurant:aRestaurant onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithLiveMusicValueOfRestaurant:aRestaurant onlyPositive:NO];
    }
    
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
    
}
-(double)pastRatingBasedChildFriendlyRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool{

    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithChildFriendlyValueOfRestaurant:aRestaurant onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithChildFriendlyValueOfRestaurant:aRestaurant onlyPositive:NO];
    }
    
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
    
}

/*
-(double)pastRatingBasedVegaterianRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool{

    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithVegaterianValueOfRestaurant:aRestaurant onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithVegaterianValueOfRestaurant:aRestaurant onlyPositive:NO];
    }
    
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
}
*/

-(double)pastRatingBasedCategoryRatingofRestaurant:(NSString*)aRestaurantcategory ForUser:(User*)aUser onlyPositive:(BOOL)aBool{
    
    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithCategoryOfrestaurant:aRestaurantcategory onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithCategoryOfrestaurant:aRestaurantcategory onlyPositive:NO];
    }
    
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
}

-(double)pastRatingBasedCuisineRatingofRestaurant:(NSString*)aRestaurantCuisine ForUser:(User*)aUser onlyPositive:(BOOL)aBool{
    
    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithCuisineOfrestaurant:aRestaurantCuisine onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithCuisineOfrestaurant:aRestaurantCuisine onlyPositive:NO];
    }
    
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
}

-(double)pastRatingBasedLocationRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool{
    
    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithLocationOfrestaurant:aRestaurant onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithLocationOfrestaurant:aRestaurant onlyPositive:NO];
    }
    
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
}


-(double)pastRatingBasedSmokingRatingofRestaurant:(NSNumber*)aRestaurantSmoking ForUser:(User*)aUser onlyPositive:(BOOL)aBool{
    
    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithSmokingOfrestaurant:aRestaurantSmoking onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithSmokingOfrestaurant:aRestaurantSmoking onlyPositive:NO];
    }
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
}

-(double)pastRatingBasedPriceRangeRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool{
    
    NSArray *ratingsArray;
    if (aBool) {
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithPriceRangeOfrestaurant:aRestaurant onlyPositive:YES];
    }else{
        ratingsArray     = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithPriceRangeOfrestaurant:aRestaurant onlyPositive:NO];
    }
    
    double average =[[RatingsManager sharedInstance] weightedAverageForRatings:ratingsArray OfUser:aUser];
    return average;
}

@end
