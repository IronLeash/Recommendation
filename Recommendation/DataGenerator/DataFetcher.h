//
//  DataFetcher.h
//  Recommendation
//
//  Created by ilker on 05.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cuisine.h"
#import "Category.h"
#import "User.h"

@interface DataFetcher : NSObject

+(DataFetcher*)sharedInstance;

//Getters
-(NSArray*)getRestaurantCategories;

-(NSArray*)getRestaurantCuisines;

-(NSArray*)getRestaurants;
-(NSArray*)getRestaurantsofCategory:(Category*)aCategory;
-(NSArray*)getRestaurantsofCuisine:(Cuisine*)aCuisine;

-(NSArray*)getDistinctRestaurantLocations;
-(NSArray*)getRestaurantsInLocation:(NSNumber*)aLocation;
-(NSArray*)getRestaurantsForPriceRange:(NSNumber*)aPriceRange;
-(NSArray*)getRestaurantForSmokingValue:(NSNumber*)aSmokingValue;
-(NSArray*)getRestaurantForGardenVale:(NSNumber*)aGardenValue;
-(NSArray*)getRestaurantForLiveMusicValue:(NSNumber*)aLiveMusic;
-(NSArray*)getRestaurantForChildFriendly:(NSNumber*)aChildFriendlyValue;
-(NSArray*)getRestaurantsWithVegaterieanValue:(NSNumber*)aVegeterianValue;
-(NSArray*)getRestaurantForCarParkValue:(NSNumber*)aCarParkValue;



-(NSArray*)getUsers;

-(NSArray*)getRestaurantRatings;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser;
-(NSArray*)getPositiveRatingsforUser:(User*)aUser;
-(NSArray*)getFavoriteCategoriesForUser:(User*)currentUser;
-(NSDictionary*)getPreferencesDictionaryForUser:(User*)currentUser;



@end
