//
//  RatingsManager.h
//  Recommendation
//
//  Created by ilker on 16.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
#import "User.h"

@interface RatingsManager : NSObject
{
    NSManagedObjectContext *ratingsMoC;
    User *currentUser;
    NSMutableArray *posiviteUserRatings;
    NSMutableArray *currentUserRatings;

    NSDictionary *userPreferenceDictionary;
    NSDictionary *userPreferenceWeightDictionary;
    
    
    //Min Max values
    int minCategory;
    int maxCategory;
    
    int minCuisine;
    int maxCuisine;
    
    int minLocation;
    int maxLocation;
    
    int minSmoking;
    int maxSmoking;
    
    int minPriceRange;
    int maxPriceRange;
    
}

//Ratings
+(RatingsManager*)sharedInstance;

-(NSArray*)getRestaurantRatings;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser;


-(double)weightedAverageForRatings:(NSArray*)ratingsArray OfUser:(User*)anUser;

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithGardenValueOfRestaurant:(NSNumber*)gardenValue onlyPositive:(BOOL)aBool;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithLiveMusicValueOfRestaurant:(NSNumber*)aRestaurant onlyPositive:(BOOL)aBool;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithChildFriendlyValueOfRestaurant:(NSNumber*)aRestaurant onlyPositive:(BOOL)aBool;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithVegaterianValueOfRestaurant:(Restaurant*)aRestaurant onlyPositive:(BOOL)aBool;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithCarParkValueOfRestaurant:(Restaurant*)aRestaurant onlyPositive:(BOOL)aBool;

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithCategoryOfrestaurant:(NSString*)aRestaurant onlyPositive:(BOOL)aBool;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithCuisineOfrestaurant:(NSString*)aRestaurant onlyPositive:(BOOL)aBool;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithLocationOfrestaurant:(Restaurant*)aRestaurant onlyPositive:(BOOL)aBool;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithSmokingOfrestaurant:(NSNumber*)aRestaurant onlyPositive:(BOOL)aBool;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithPriceRangeOfrestaurant:(Restaurant*)aRestaurant onlyPositive:(BOOL)aBool;


-(NSArray*)getPositiveRatingsforUser:(User*)aUser;

-(NSArray*)getFavoriteGarden:(User*)currentUser;
-(NSArray*)getFavoriteLiveMusic:(User*)aUser;
-(NSArray*)getFavoriteChildFriendly:(User*)aUser;

-(NSArray*)getFavoriteCategoriesForUser:(User*)currentUser;
-(NSArray*)getFavoriteCuisinesForUser:(User*)currentUser;
-(NSArray*)getFavoriteSmokingForUser:(User*)currentUser;
-(NSArray*)getFavoriteLocationForUser:(User*)currentUser;


//Rating Predictions
-(int)getNumberOfPositiveRatingsForUser:(User*)anUser WithAttribute:(NSString*)anAttribute andValue:(NSString*)aValue;
-(double)countBasedRatingForAttribute:(NSString*)attribute Value:(NSString*)aValue andUser:(User*)anUser;

//AverageRatingsWithCommonAttaribute

-(void)cleanUp;


//Min Max Methods

-(int)getMinCategoryForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool;
-(int)getmaxCategoryForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool;

-(int)getminCuisineForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool;
-(int)getmaxCuisineForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool;

-(int)getminLocationForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool;
-(int)getmaxLocationForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool;

-(int)getminSmokingForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool;
-(int)getmaxSmokingForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool;

-(int)getminPriceRangeForUser:(User*)anUser  onlyPositiveRatings:(BOOL)aBool;
-(int)getmaxPriceRangeForUser:(User*)anUser  onlyPositiveRatings:(BOOL)aBool;

@end
