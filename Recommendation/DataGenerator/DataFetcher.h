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
{


    
    
}
+(DataFetcher*)sharedInstance;

//Getters

-(NSManagedObjectContext*)getManagedObjectContext;

-(NSArray*)getRestaurantCategories;

-(NSArray*)getRestaurantCuisines;
-(Cuisine*)getRestaurantCuisineWithName:(NSString*)name;

-(NSArray*)getRestaurants;
-(NSArray*)getRestaurantsinManagedObjectContext:(NSManagedObjectContext*)aManagedObjectContext;

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

//Favorite Categories
-(NSArray*)getFavoriteCagetoriesForStereotype:(NSString*)aString;


//Users
-(NSArray*)getUsers;
-(NSArray*)getUsersInManagedObjectContext:(NSManagedObjectContext*)aManageObjecContext;

//Ratings
-(NSArray*)getRestaurantRatings;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser;
-(NSArray*)getPositiveRatingsforUser:(User*)aUser;
-(NSArray*)getFavoriteCategoriesForUser:(User*)currentUser;

-(NSDictionary*)getPreferencesDictionaryForUser:(User*)currentUser;

-(NSDictionary*)getResturantEntrophyDictionary;

@end
