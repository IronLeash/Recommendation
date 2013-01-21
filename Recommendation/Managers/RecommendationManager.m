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


NSString *recommendationArrayGeneratedNotification = @"RecommendationGeneratedNotification";

static RecommendationManager *recommendationManager;

@implementation RecommendationManager

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
-(NSArray*)getRecommendationForUser:(User*)anUser withPreferences:(NSDictionary*)preferences andWeight:(NSDictionary*)weights{

    NSMutableArray *recommendationsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    double categoryWeight   = [[weights objectForKey:kCategory] doubleValue];
    double cuisineWeight    = [[weights objectForKey:kCuisine] doubleValue];
    double priceWeight      = [[weights objectForKey:kPrice] doubleValue];
    double smokingWeight    = [[weights objectForKey:kSmoking] doubleValue];
    
    double gardenWeight             = [[weights objectForKey:kGarden] doubleValue];
    double liveMusicWeight          = [[weights objectForKey:kLiveMusic] doubleValue];
    double childFriendlyWeight      = [[weights objectForKey:kChildfriendly] doubleValue];
    double vegaterianWeight         = [[weights objectForKey:kVegaterian] doubleValue];

    
    NSArray *orderedCategoryArray   = [preferences objectForKey:kCategory];
    NSArray *orderedCuisineArray    = [preferences objectForKey:kCuisine];
    NSArray *orderedSmokingArray    = [preferences objectForKey:kSmoking];

    NSArray *restaurantsArray = [[DataFetcher sharedInstance] getRestaurants];
    
    for (Restaurant *currentRestaurant in restaurantsArray) {

        [[RecommendationManager sharedInstance] overalRatingPredictionOfRestaurant:currentRestaurant ForUser:anUser];
        
        Recommendation *currentRecommendation = [[Recommendation alloc] init];
        currentRecommendation.restaurant = currentRestaurant;

        NSUInteger cuisinePosition     = [ActionGeneric positionInArray:orderedCuisineArray :currentRestaurant.cuisine];
        double categoryPosition    = ([ActionGeneric positionInArray:orderedCategoryArray :currentRestaurant.category])*19/16;
        NSLog(@"Current Category %@ with Position %f",currentRestaurant.category,categoryPosition);
        
        double smokingPosition     = ([ActionGeneric positionInArray:orderedSmokingArray :currentRestaurant.smoking])*19/3;
        
        double pricePosition       = ([currentRestaurant.priceRange intValue] - [[preferences objectForKey:kPrice] intValue])*19/4;
        
         double gardenPosition      = ([currentRestaurant.garden doubleValue] - [[preferences objectForKey:kGarden] doubleValue])*19;
         double liveMusicPosition   = ([currentRestaurant.liveMusic doubleValue] - [[preferences objectForKey:kLiveMusic] doubleValue])*19;
         double childFriendly       = ([currentRestaurant.childFriendly doubleValue] - [[preferences objectForKey:kChildfriendly] doubleValue])*19;
         double vegaterianFriendly  = ([currentRestaurant.vegaterian doubleValue] - [[preferences objectForKey:kVegaterian] doubleValue])*19;
        
        /*
        currentRecommendation.distance =    pow((double)(cuisinePosition*cuisineWeight), 2) +
                                            pow((double)(categoryPosition*categoryWeight), 2) +
                                            pow((double)(smokingPosition*smokingWeight), 2) +
                                            pow((double)(pricePosition*priceWeight), 2) +
                                            pow((double)(gardenPosition*gardenWeight), 2) +
                                            pow((double)(liveMusicPosition*liveMusicWeight), 2) +
                                            pow((double)(childFriendly*childFriendlyWeight), 2) +
                                            pow((double)(vegaterianFriendly*vegaterianWeight), 2);
        

        NSLog(@"Distance %f",currentRecommendation.distance);
        */
        
        currentRecommendation.distance =    pow((double)(cuisinePosition), 2)*cuisineWeight +
        pow((double)(categoryPosition), 2)*categoryWeight +
        pow((double)(smokingPosition), 2)*smokingWeight +
        pow((double)(pricePosition), 2)*priceWeight +
        pow((double)(gardenPosition), 2)*gardenWeight +
        pow((double)(liveMusicPosition), 2)*liveMusicWeight +
        pow((double)(childFriendly), 2)*childFriendlyWeight +
        pow((double)(vegaterianFriendly), 2)*vegaterianWeight;

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

-(double)overalRatingPredictionOfRestaurant:(Restaurant*)aRestaurant ForUser:(User*)anUser{

    double garden           = [[RecommendationManager sharedInstance] countbasedGardenRatingofRestaurant:aRestaurant ForUser:anUser];
    NSLog(@"Garden value %f",garden);
    double carPark          = [[RecommendationManager sharedInstance] countbasedCarParkRatingofRestaurant:aRestaurant ForUser:anUser];
        NSLog(@"Garden value %f",carPark);
    double liveMusic        = [[RecommendationManager sharedInstance] countbasedLiveMusicRatingofRestaurant:aRestaurant ForUser:anUser];
        NSLog(@"Garden value %f",liveMusic);
    double childFriendly    = [[RecommendationManager sharedInstance] countbasedChildFriendlyRatingofRestaurant:aRestaurant ForUser:anUser];
        NSLog(@"Garden value %f",childFriendly);
    
    return 1;
}

-(double)countbasedGardenRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

    double currentResturantValue  = [aRestaurant.garden doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getGardenOf:aUser] ;

    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
}

-(double)countbasedCarParkRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

    double currentResturantValue  = [aRestaurant.carPark doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getCarPark:aUser] ;
    
    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
}

-(double)countbasedLiveMusicRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

    double currentResturantValue  = [aRestaurant.liveMusic doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getLiveMusic:aUser] ;
    
    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
}

-(double)countbasedChildFriendlyRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

    double currentResturantValue  = [aRestaurant.childFriendly doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getChildFriendly:aUser] ;
    
    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
}

-(double)countbasedVegaterianRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

    double currentResturantValue  = [aRestaurant.childFriendly doubleValue];
    double preferenceValue = [[PreferencesManager sharedInstance] getVegaterian:aUser] ;
    
    double distanceValue =  fabs(currentResturantValue-preferenceValue);
    
    return 1.0 - distanceValue;
}

//PAst Ratings based prediction
-(double)pastRatingBasedGardenRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

    
}
-(double)pastRatingBasedCarParkRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

}
-(double)pastRatingBasedLiveMusicRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

}
-(double)pastRatingBasedChildFriendlyRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

}

-(double)pastRatingBasedVegaterianRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser{

}

@end
