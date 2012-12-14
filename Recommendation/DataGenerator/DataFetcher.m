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
    }
        return restaurantCategories;
}

-(NSArray*)getRestaurantCuisines{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    
    if (![restaurantCuisines count]) {
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
        
    }
    return restaurantCuisines;
    
}

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

-(NSArray*)getRestaurants{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    
    NSArray *returnArray;
    
    if (![restaurantsArray count]) {
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
        
    }else{
        returnArray = restaurantsArray;
    }

    return returnArray;
}

-(NSArray*)getRestaurantsofCategory:(Category*)aCategory{
    
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"categories == %@",aCategory]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
    
}

-(NSArray*)getRestaurantsofCuisine:(Cuisine*)aCuisine{
    
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
    
    if ([aString isEqualToString:kGourmet])
    {
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kFineDining,kSteakHouse,kSeaFoodRestaurant]];
    } else if (([aString isEqualToString:kStudent])) {
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kBakery,kBistro,kFastFoodRest,kTakeOut,kSnackBar,kPub,kBrewPub]];
    }else if (([aString isEqualToString:kTourist])) {
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kCoffeehouse,kFastFoodRest,kHeuriger,kSnackBar,kTakeOut]];
    }else if (([aString isEqualToString:kFamily])) {
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kCounterService,kFoodCourt,kPizzeria]];
    }else if (([aString isEqualToString:kAmbianceLover])) {
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kRunningSushi,kOuzeriaTavern,kBrewPub,kFineDining,kOsteria]];
    }else{
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@ OR name == %@ OR name == %@",kBakery,kFoodCourt,kCounterService]];
    }
    

    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;

}



-(NSArray*)getUsers{
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    moc= [appDelegate managedObjectContext];
    
    if (![usersArray count]) {
        
        //Check if cusines are alreadyThere
        //Fetsch results
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"User" inManagedObjectContext:moc];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        NSError *error;
        usersArray = [[NSArray alloc] initWithArray:[moc executeFetchRequest:request error:&error]];
        return usersArray;
    }else{
    
        return usersArray;
    }
    
    
}

-(NSArray*)getRestaurantRatings{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"RestaurantRating" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"RestaurantRating" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:[NSPredicate predicateWithFormat:@"user == %@",aUser]];
    
    NSSortDescriptor *sortDescriptor =  [NSSortDescriptor sortDescriptorWithKey:@"self.restaurant.uniqueName"
                                                                      ascending:YES
                                                                     comparator:^(id obj1, id obj2){
                                                                         return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                 options:NSNumericSearch];
                                                                     }];


    
    NSError *error;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[moc executeFetchRequest:request error:&error]];
    //Sort ratings according to Rest name
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return sortedArray;
    
}


-(NSArray*)getPositiveRatingsforUser:(User*)aUser{
    
    NSArray *userRatings = [[DataFetcher sharedInstance] getRestaurantRatingsForUser:aUser];
    NSMutableArray *positiveRatings = [NSMutableArray arrayWithArray:userRatings];
    
    //Eleminate the  restaurants which are below threshold
    
    
    for (RestaurantRating *currentRatings in userRatings)
    {
        float weightedAverage = [StatisticsLibrary weightedSumForRating:currentRatings];
        
        if (weightedAverage < POSITIVERATINGTHRESHOLD)
        {
            [positiveRatings removeObject:currentRatings];
        }
    }
    
    return positiveRatings;
}


-(NSArray*)getFavoriteCategoriesForUser:(User*)currentUser{
    
    NSArray *allCategories = [[DataFetcher sharedInstance] getRestaurantCategories];
    NSMutableArray *favoriteCategories = [NSMutableArray arrayWithCapacity:[allCategories count]];
    
    for (Category *currentCAtegory in allCategories)
    {
        FavoriteCategory *curentFavoriteCategory = [[FavoriteCategory alloc] init];
        curentFavoriteCategory.name =currentCAtegory.name;
        [favoriteCategories addObject:curentFavoriteCategory];
    }
    
    NSArray *positiveRAtingsArray =  [[DataFetcher sharedInstance] getPositiveRatingsforUser:currentUser];
    float   averagePositveRating =[StatisticsLibrary weightedpositveRatingsMean:positiveRAtingsArray];
    
    //Iterate all positive ratings
    for (RestaurantRating *currentRating in positiveRAtingsArray){
        Category *likedCategory = currentRating.restaurant.categories;
        
        for (FavoriteCategory *favCategory in favoriteCategories) {
            if ([favCategory.name isEqualToString:likedCategory.name]) {
                favCategory.totalOccurances++;
                favCategory.ratingtotal += [StatisticsLibrary weightedSumForRating:currentRating];
                favCategory.weightedValue = [StatisticsLibrary scoreofCategory:favCategory amongRatingNumber:[positiveRAtingsArray count] withAverage:averagePositveRating];
            }
        }
    }
    
    
    
    //add weighted rating
    
    //Sort the favoriteCategoriesArray
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
    [favoriteCategories sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoriteCategories;
}

-(NSArray*)getFavoriteCuisinesForUser:(User*)currentUser{
    
    NSArray *allCuisines = [[DataFetcher sharedInstance] getRestaurantCuisines];
    NSMutableArray *favoriteCuisines = [NSMutableArray arrayWithCapacity:[allCuisines count]];
    
    for (Cuisine *currentCuisine in allCuisines)
    {
        FavoriteCuisine *currentFavoriteCuisine = [[FavoriteCuisine alloc] init];
        currentFavoriteCuisine.name =currentCuisine.name;
        [favoriteCuisines addObject:currentFavoriteCuisine];
    }
    
    NSArray *positiveRAtingsArray =  [[DataFetcher sharedInstance] getPositiveRatingsforUser:currentUser];
    float   averagePositveRating =[StatisticsLibrary weightedpositveRatingsMean:positiveRAtingsArray];
    
    //Iterate all positive ratings
    for (RestaurantRating *currentRating in positiveRAtingsArray){
        Cuisine *likedCuisine = currentRating.restaurant.cuisine;
        
        for (FavoriteCuisine *favoriteCuisine in favoriteCuisines) {
            if ([favoriteCuisine.name isEqualToString:likedCuisine.name]) {
                favoriteCuisine.totalOccurances++;
                favoriteCuisine.ratingtotal += [StatisticsLibrary weightedSumForRating:currentRating];
                favoriteCuisine.weightedValue = [StatisticsLibrary scoreofCuisine:favoriteCuisine amongRatingNumber:[positiveRAtingsArray count] withAverage:averagePositveRating];
            }
        }
        //        Category *likedCuisine = currentRating.restaurant.categories;
    }
    
    
    
    //add weighted rating
    
    //Sort the favoriteCategoriesArray
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
    [favoriteCuisines sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoriteCuisines;
}


-(NSArray*)getFavoriteSmokingForUser:(User*)currentUser{
    
    //    NSArray *smokeingValues = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2], nil];
    NSMutableArray *favoriteSmokingArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < 3 ; i++)
    {
        FavoriteSmoking *currentFavoriteSmoking = [[FavoriteSmoking alloc] init];
        currentFavoriteSmoking.value = [NSNumber numberWithInt:i];
        [favoriteSmokingArray addObject:currentFavoriteSmoking];
    }
    
    NSArray *positiveRAtingsArray =  [[DataFetcher sharedInstance] getPositiveRatingsforUser:currentUser];
    float   averagePositveRating =[StatisticsLibrary weightedpositveRatingsMean:positiveRAtingsArray];
    
    //Iterate all positive ratings
    for (RestaurantRating *currentRating in positiveRAtingsArray){
        
        for (FavoriteSmoking *favoriteSmoking in favoriteSmokingArray) {
            if ([favoriteSmoking.value isEqualToNumber:currentRating.restaurant.smoking]) {
                favoriteSmoking.totalOccurances++;
                favoriteSmoking.ratingtotal += [StatisticsLibrary weightedSumForRating:currentRating];
                favoriteSmoking.weightedValue = [StatisticsLibrary scoreoSmoking:favoriteSmoking amongRatingNumber:[positiveRAtingsArray count] withAverage:averagePositveRating];
            }
        }
        
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
    [favoriteSmokingArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoriteSmokingArray;
}


-(NSArray*)getFavoriteLocationForUser:(User*)currentUser{
    
    //    NSArray *smokeingValues = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2], nil];
    NSMutableArray *favoriteLocationArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 1; i < 16 ; i++)
    {
        FavoriteLocation *currentFavoriteLocation = [[FavoriteLocation alloc] init];
        currentFavoriteLocation.nameNumber = [NSNumber numberWithInt:i];
        [favoriteLocationArray addObject:currentFavoriteLocation];
    }
    
    NSArray *positiveRAtingsArray =  [[DataFetcher sharedInstance] getPositiveRatingsforUser:currentUser];
    float   averagePositveRating =[StatisticsLibrary weightedpositveRatingsMean:positiveRAtingsArray];
    
    //Iterate all positive ratings
    for (RestaurantRating *currentRating in positiveRAtingsArray){
        
        for (FavoriteLocation *favoriteLocation in favoriteLocationArray) {
            if ([favoriteLocation.nameNumber isEqualToNumber:currentRating.restaurant.location]) {
                favoriteLocation.totalOccurances++;
                favoriteLocation.ratingtotal += [StatisticsLibrary weightedSumForRating:currentRating];
                favoriteLocation.weightedValue = [StatisticsLibrary scoreoLocation:favoriteLocation amongRatingNumber:[positiveRAtingsArray count] withAverage:averagePositveRating];
            }
        }
        
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
    [favoriteLocationArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoriteLocationArray;
}


-(NSDictionary*)getPreferencesDictionaryForUser:(User*)currentUser{
    
    NSArray *positiveRatingsArray = [[DataFetcher sharedInstance] getPositiveRatingsforUser:currentUser];
    
    float vegetarian = 0;
    float childFriendly = 0;
    float liveMusic = 0;
    float garden = 0;
    float priceRange = 0;
    
    NSArray *favoriteCategories = [[DataFetcher sharedInstance] getFavoriteCategoriesForUser:((RestaurantRating*)[positiveRatingsArray objectAtIndex:0]).user];
    NSArray *favoriteCuisines = [[DataFetcher sharedInstance] getFavoriteCuisinesForUser:((RestaurantRating*)[positiveRatingsArray objectAtIndex:0]).user];
    NSArray *favoriteSmoking = [[DataFetcher sharedInstance] getFavoriteSmokingForUser:((RestaurantRating*)[positiveRatingsArray objectAtIndex:0]).user];
    NSArray *favoriteLocation = [[DataFetcher sharedInstance] getFavoriteLocationForUser:((RestaurantRating*)[positiveRatingsArray objectAtIndex:0]).user];
    
    
    for (RestaurantRating *currentRating in positiveRatingsArray)
    {
#warning you can add a weighting factor according to rating value
        vegetarian     += [currentRating.restaurant.vegeterian floatValue];
        childFriendly  += [currentRating.restaurant.childFriendly floatValue];
        liveMusic      += [currentRating.restaurant.liveMusic floatValue];
        garden         += [currentRating.restaurant.garden floatValue];
        priceRange     += [currentRating.restaurant.priceRange floatValue];
    }
    
    vegetarian     = vegetarian/[positiveRatingsArray count];
    childFriendly  = childFriendly/ [positiveRatingsArray count];
    liveMusic      = liveMusic / [positiveRatingsArray count];
    garden         = garden / [positiveRatingsArray count];
    priceRange     = priceRange / [positiveRatingsArray count];
    
    NSDictionary *preferencesDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                               [NSNumber numberWithFloat:vegetarian],
                                                                               [NSNumber numberWithFloat:childFriendly],
                                                                               [NSNumber numberWithFloat:liveMusic],
                                                                               [NSNumber numberWithFloat:garden],
                                                                               [NSNumber numberWithFloat:priceRange],
                                                                               favoriteCategories,
                                                                               favoriteCuisines,
                                                                               favoriteSmoking,
                                                                               favoriteLocation,
                                                                               nil]
                                                                      forKeys:[NSArray arrayWithObjects:kVegetarian,kChildfriendly,kLiveMusic,kGarden,kPrice,kCategory,kCuisine,kSmoking,kLocation,nil]];
    
    return preferencesDictionary;
}


-(NSDictionary*)getResturantEntrophyDictionary
{
    NSDictionary *returnDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kRestaurantAttributesEntropyDistionary];
    return returnDictionary;
}

@end
