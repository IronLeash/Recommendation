//
//  RecommendationManager.h
//  Recommendation
//
//  Created by ilker on 28.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RestaurantRating.h"
#import "Restaurant.h"



NSString *recommendationArrayGeneratedNotification;

@interface RecommendationManager : NSObject
{
    User *currentUser;
    NSDictionary *userPreferencesDictionary;
    NSArray *recommendationResultsArray;
    double alphaWeight;
    
}

@property (nonatomic) double alphaWeight;

+(RecommendationManager*)sharedInstance;
-(NSArray*)getRecommendationForUser:(User*)anUser withPreferences:(NSDictionary*)preferences andWeight:(NSDictionary*)weights onlyPosiiveRatings:(BOOL)aBool;


-(double)overalRatingPredictionOfRestaurant:(Restaurant*)aRestaurant ForUser:(User*)anUser onlyPosivite:(BOOL)aBool;

//Count based ratings
-(double)countBasedRatingForCategoryOfRestaurant:(Restaurant*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countBasedRatingForCuisineOfRestaurant:(Restaurant*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countBasedRatingForLocationOfRestaurant:(Restaurant*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countBasedRatingForSmokingOfRestaurant:(Restaurant*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countBasedRatingForPriceOfRestaurant:(Restaurant*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countbasedGardenRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser;
-(double)countbasedCarParkRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser;
-(double)countbasedLiveMusicRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser;
-(double)countbasedChildFriendlyRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser;
-(double)countbasedVegaterianRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser;

//PAst Ratings based prediction
-(double)pastRatingBasedGardenRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedCarParkRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedLiveMusicRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedChildFriendlyRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
//-(double)pastRatingBasedVegaterianRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;

@end
