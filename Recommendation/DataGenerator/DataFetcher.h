//
//  DataFetcher.h
//  Recommendation
//
//  Created by ilker on 05.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface DataFetcher : NSObject
{

}

+(DataFetcher*)sharedInstance;

//Getters

-(NSManagedObjectContext*)getManagedObjectContext;

-(NSArray*)getRestaurantCategories;

-(NSArray*)getRestaurantCuisines;

-(NSArray*)getRestaurants;

-(NSArray*)getRestaurantsofCategory:(NSString*)aCategory;
-(NSArray*)getRestaurantsofCuisine:(NSString*)aCuisine;

-(NSArray*)getRestaurantsinManagedObjectContext:(NSManagedObjectContext*)aManagedObjectContext;

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



@end
