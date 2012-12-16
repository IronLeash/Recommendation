//
//  DataFetcher.m
//  Recommendation
//
//  Created by ilker on 05.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataFetcher.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "StatisticsLibrary.h"


#import "Restaurant.h"

@implementation DataFetcher

static DataFetcher* dataFetcher = nil;
static  NSManagedObjectContext *moc;

static NSArray *restaurantsArray;
static NSArray *usersArray;

static NSArray *restaurantCategories;
static NSArray *restaurantCuisines;

#pragma mark - Shared Instance
#pragma mark -
+(DataFetcher*)sharedInstance;
{
	@synchronized([DataFetcher class])
	{
        AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
        moc= [appDelegate managedObjectContext];
        
		if (!dataFetcher)
        {
            
            return [[self alloc] init];
        }else{
            return dataFetcher;
        }
    }
    
	return nil;
}



#pragma mark - Managed Object

-(NSManagedObjectContext*)getManagedObjectContext{
    return moc;
}
#pragma mark - Restaurant related
-(NSArray*)getRestaurantCategories{
    

    if (![restaurantCategories count]) {
        
        /*
        //Check if cusines are alreadyThere
        //Fetsch results
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"Category" inManagedObjectContext:moc];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        // Set example predicate and sort orderings...
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:@"name" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        NSError *error;
        restaurantCategories = [[NSArray alloc] initWithArray:[moc executeFetchRequest:request error:&error]];
        
        */
        restaurantCategories = [[NSArray alloc] initWithObjects:
                                  @"Bakery",
                                  @"Bistro",
                                  @"Sea Food Restaurant",
                                  @"Brew Pub",
                                  @"Counter Service",
                                  @"Cantina",
                                  @"Coffeehouse",
                                  @"Fast Food Rest",
                                  @"Fine Dining",
                                  @"Food Court",
                                  @"Heuriger",
                                  @"Osteria",
                                  @"Ouzeria/Tavern",
                                  @"Pizzeria",
                                  @"Pub",
                                  @"Running Sushi",
                                  @"Snack Bar",
                                  @"Steak house",
                                  @"Take-Out",
                                  nil];
    
    }
    
        return restaurantCategories;
}

-(NSArray*)getRestaurantCuisines{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    
    if (![restaurantCuisines count]) {
        
        
        /*
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"Cuisine" inManagedObjectContext:moc];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        // Set example predicate and sort orderings...
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:@"name" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        NSError *error;
        restaurantCuisines = [[NSArray alloc] initWithArray:[moc executeFetchRequest:request error:&error]];
        */

            restaurantCuisines = [[NSArray alloc] initWithObjects:
                                  @"American",
                                  @"Argentina",
                                  @"Austrian",
                                  @"Turkish",
                                  @"French",
                                  @"English",
                                  @"Italian",
                                  @"Irish",
                                  @"Spanish",
                                  @"Greek",
                                  @"World",
                                  @"Korea",
                                  @"Japan",
                                  @"Thailand",
                                  @"Chinese",
                                  @"Mexica",
                                  nil];
    }
    return restaurantCuisines;
    
}
/*
-(Cuisine*)getRestaurantCuisineWithName:(NSString*)name{

    
    //Check if cusines are alreadyThere
    //Fetsch results
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Cuisine" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@",name]];
    

    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    
    Cuisine *currentCuisine;
    if ([array count]) {
        currentCuisine = [array objectAtIndex:0];
    }else{
    
    }
    
    return currentCuisine;
}
*/

#warning - implement a method with force to reload

-(NSArray*)getRestaurants{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    
    NSArray *returnArray;
    
    if (![restaurantsArray count] || [restaurantsArray count]==0) {
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"Restaurant" inManagedObjectContext:moc];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        /*
         // Set example predicate and sort orderings...
         NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
         initWithKey:@"name" ascending:YES];
         [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
         */
        
        NSError *error;
        restaurantsArray = [[NSArray alloc] initWithArray:[moc executeFetchRequest:request error:&error]];
    }
        returnArray = restaurantsArray;
    
    return returnArray;
}




-(NSArray*)getRestaurantsinManagedObjectContext:(NSManagedObjectContext*)aManagedObjectContext{
    
    //Check if cusines are alreadyThere
    //Fetsch results
        
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"Restaurant" inManagedObjectContext:aManagedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        /*
         // Set example predicate and sort orderings...
         NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
         initWithKey:@"name" ascending:YES];
         [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
         */
        
        NSError *error;
        return [[NSArray alloc] initWithArray:[aManagedObjectContext executeFetchRequest:request error:&error]];

}

-(NSArray*)getRestaurantsofCategory:(NSString*)aCategory{

    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"category == %@",aCategory]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
    
}

-(NSArray*)getRestaurantsofCuisine:(NSString*)aCuisine{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"cuisine == %@",aCuisine]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getDistinctRestaurantLocations{
    
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Restaurant" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    [request setReturnsDistinctResults:YES];
    [request setPropertiesToFetch:[NSArray arrayWithObject:@"location"]];
    
    // Execute the fetch.
    NSError *error;
    NSArray *objects = [moc executeFetchRequest:request error:&error];
    
    NSSet *aset = [NSSet setWithArray:objects];
    NSArray *distinctvalues = [aset allObjects];
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *currentDictionary in distinctvalues)
    {
        [returnArray addObject:[currentDictionary objectForKey:@"location"]];
    }
    
    if (objects == nil) {
        // Handle the error.
    }
    
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [returnArray sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    return returnArray;
}

-(NSArray*)getRestaurantsInLocation:(NSNumber*)aLocation{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"location == %@",aLocation]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}


-(NSArray*)getRestaurantsForPriceRange:(NSNumber*)aPriceRange{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"priceRange == %@",aPriceRange]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getRestaurantForSmokingValue:(NSNumber*)aSmokingValue{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"smoking == %@",aSmokingValue]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getRestaurantForGardenVale:(NSNumber*)aGardenValue{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"garden == %@",aGardenValue]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getRestaurantForLiveMusicValue:(NSNumber*)aLiveMusic{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"liveMusic == %@",aLiveMusic]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getRestaurantForChildFriendly:(NSNumber*)aChildFriendlyValue{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"childFriendly == %@",aChildFriendlyValue]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getRestaurantsWithVegaterieanValue:(NSNumber*)aVegeterianValue{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"vegeterian == %@",aVegeterianValue]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getRestaurantForCarParkValue:(NSNumber*)aCarParkValue{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"carPark == %@",aCarParkValue]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}


-(NSArray*)getFavoriteCagetoriesForStereotype:(NSString*)aString{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Category" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];

    
    NSArray *favoriteArray;
    if ([aString isEqualToString:kGourmet])
    {
//    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kFineDining,kSteakHouse,kSeaFoodRestaurant]];
        favoriteArray = [[NSArray alloc] initWithObjects:kFineDining,kSteakHouse,kSeaFoodRestaurant, nil];
    } else if (([aString isEqualToString:kStudent])) {
//    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kBakery,kBistro,kFastFoodRest,kTakeOut,kSnackBar,kPub,kBrewPub]];
                favoriteArray = [[NSArray alloc] initWithObjects:kBakery,kBistro,kFastFoodRest,kTakeOut,kSnackBar,kPub,kBrewPub, nil];
    }else if (([aString isEqualToString:kTourist])) {
//    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kCoffeehouse,kFastFoodRest,kHeuriger,kSnackBar,kTakeOut]];
                favoriteArray = [[NSArray alloc] initWithObjects:kCoffeehouse,kFastFoodRest,kHeuriger,kSnackBar,kTakeOut, nil];
    }else if (([aString isEqualToString:kFamily])) {
//    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kCounterService,kFoodCourt,kPizzeria]];
                favoriteArray = [[NSArray alloc] initWithObjects:kCounterService,kFoodCourt,kPizzeria, nil];
    }else if (([aString isEqualToString:kAmbianceLover])) {
//    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kRunningSushi,kOuzeriaTavern,kBrewPub,kFineDining,kOsteria]];
                favoriteArray = [[NSArray alloc] initWithObjects:kRunningSushi,kOuzeriaTavern,kBrewPub,kFineDining,kOsteria, nil];
    }else{
//    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kBakery,kFoodCourt,kCounterService]];
                favoriteArray = [[NSArray alloc] initWithObjects:kBakery,kFoodCourt,kCounterService, nil];
    }
    

//    NSError *error;
//    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return favoriteArray;

}


#pragma mark - Users
-(NSArray*)getUsers{
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    moc= [appDelegate managedObjectContext];
    
    
    /*
    NSArray *returnArray;
    if (![usersArray count] || [usersArray count]==0) {
        
        //Check if cusines are alreadyThere
        //Fetsch results
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"User" inManagedObjectContext:moc];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setReturnsObjectsAsFaults:NO];
        [request setEntity:entityDescription];
        
        NSError *error;
        usersArray = [[NSArray alloc] initWithArray:[moc executeFetchRequest:request error:&error]];
    }
    */
   
    
    //Check if cusines are alreadyThere
    //Fetsch results
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"User" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setReturnsObjectsAsFaults:NO];
    [request setEntity:entityDescription];
    
    NSError *error;
    usersArray = [[NSArray alloc] initWithArray:[moc executeFetchRequest:request error:&error]];
//        returnArray = usersArray;
    return usersArray;

}

-(NSArray*)getUsersInManagedObjectContext:(NSManagedObjectContext*)aManageObjecContext{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"User" inManagedObjectContext:aManageObjecContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    usersArray = [[NSArray alloc] initWithArray:[aManageObjecContext executeFetchRequest:request error:&error]];
    return usersArray;
}

@end
