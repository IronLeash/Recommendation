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
-(double)countBasedRatingForCategoryOfRestaurant:(NSString*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countBasedRatingForCuisineOfRestaurant:(NSString*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countBasedRatingForLocationOfRestaurant:(Restaurant*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countBasedRatingForSmokingOfRestaurant:(NSNumber*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countBasedRatingForPriceOfRestaurant:(Restaurant*)aRestaurant andUser:(User*)anUser onlyPositive:(BOOL)aBool;
-(double)countbasedGardenRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser;
-(double)countbasedCarParkRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser;
-(double)countbasedLiveMusicRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser;
-(double)countbasedChildFriendlyRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser;
-(double)countbasedVegaterianRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser;

//PAst Ratings based prediction
-(double)pastRatingBasedGardenRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedCarParkRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedLiveMusicRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedChildFriendlyRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedCategoryRatingofRestaurant:(NSString*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedCuisineRatingofRestaurant:(NSString*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedLocationRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedSmokingRatingofRestaurant:(NSNumber*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;
-(double)pastRatingBasedPriceRangeRatingofRestaurant:(Restaurant*)aRestaurant ForUser:(User*)aUser onlyPositive:(BOOL)aBool;

@end
