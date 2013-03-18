//
//  RatingsManager.m
//  Recommendation
//
//  Created by ilker on 16.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "RatingsManager.h"
#import "RatingWeight.h"
#import "RestaurantRating.h"
#import "AppDelegate.h"
#import "DataFetcher.h"
#import "StatisticsLibrary.h"
#import "Restaurant.h"
#import "Constants.h"
#import "PreferencesManager.h"
#import "RecommendationManager.h"
#import "FavoritePriceRange.h"
#import "AttributeValueConverter.h"
static RatingsManager *ratingsManager = nil;

@implementation RatingsManager

+(RatingsManager*)sharedInstance{


   	@synchronized(self)
	{
		if (ratingsManager==nil)
        {
            ratingsManager = [[self alloc] init];
            
        }
            return ratingsManager;
    }
	return nil;
}

-(id)init{
    
	self = [super init];
	if (self != nil) {
        
        AppDelegate *appdelegate = (AppDelegate*)[[NSApplication sharedApplication] delegate];
        ratingsMoC = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *coordinator = appdelegate.persistentStoreCoordinator;
        [ratingsMoC setPersistentStoreCoordinator:coordinator];
        [ratingsMoC setUndoManager:nil];
        
        posiviteUserRatings = [[NSMutableArray alloc] init];
        currentUserRatings =  [[NSMutableArray alloc] init];
        
        
        minCategory     = -1;
        maxCategory     = -1;
        
        minCuisine      = -1;
        maxCuisine      = -1;
        
        minLocation     = -1;
        maxLocation     = -1;
        
        minSmoking      = -1;
        maxSmoking      = -1;
        
        minPriceRange   = -1;
        maxPriceRange   = -1;
	}
    
	return self;
}

#pragma mark - Custom Methods

-(void)cleanUp{
    
    currentUser = nil;
    [posiviteUserRatings removeAllObjects];
    [currentUserRatings removeAllObjects];
}

#pragma mark - Ratings

//Gets all restaurant ratings
-(NSArray*)getRestaurantRatings{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"RestaurantRating" inManagedObjectContext:ratingsMoC];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setReturnsObjectsAsFaults:NO];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [ratingsMoC executeFetchRequest:request error:&error];
    
    return array;
}


-(NSArray*)getRestaurantRatingsForUser:(User*)aUser{
    
    if ([aUser isEqualTo:currentUser] && currentUserRatings) {
        return currentUserRatings;
    }else{
        //Check if cusines are alreadyThere
        //Fetsch results
        [self cleanUp];
        
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"RestaurantRating" inManagedObjectContext:ratingsMoC];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setReturnsObjectsAsFaults:NO];
        [request setEntity:entityDescription];
        [request setPredicate:[NSPredicate predicateWithFormat:@"user == %@",aUser]];
        
        NSSortDescriptor *sortDescriptor =  [NSSortDescriptor sortDescriptorWithKey:@"self.restaurant.uniqueName"
                                                                          ascending:YES
                                                                         comparator:^(id obj1, id obj2){
                                                                             return [(NSString*)obj1 compare:(NSString*)obj2
                                                                                                     options:NSNumericSearch];
                                                                         }];
        NSError *error;
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:[ratingsMoC executeFetchRequest:request error:&error]];
        //Sort ratings according to Rest name
        NSArray *sortedArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

        @synchronized(currentUserRatings){
        currentUser = aUser;
        [currentUserRatings addObjectsFromArray:sortedArray];
        }
        currentUser = aUser;
        return sortedArray;
    }
}

-(RestaurantRating*)getRatingsOfRestaurant:(Restaurant*) ForUser:(User*)aUser{


}


-(double)weightedAverageForRatings:(NSArray*)ratingsArray OfUser:(User*)anUser{

    RatingWeight *ratingWeight = anUser.ratingWeight;
    double average = 0;
    
    for (RestaurantRating *currentRating in ratingsArray) {
        
        average  += [currentRating.tangiblesRating doubleValue]*[ratingWeight.tangibles doubleValue]+
                   [currentRating.coreServiceRating doubleValue]*[ratingWeight.coreService doubleValue]+
                    [currentRating.accessibilityRating doubleValue]*[ratingWeight.accessibility doubleValue]+
                    [currentRating.personalRating doubleValue]*[ratingWeight.personal doubleValue]+
                    [currentRating.serviceRating doubleValue]*[ratingWeight.service doubleValue];
    }

    if ([ratingsArray count]==0) {
        return 0;
    }else{
    return average/[ratingsArray count];
    }
}


-(NSArray*)getPositiveRatingsforUser:(User*)aUser{
    
    
    if ([aUser isEqualTo:currentUser] && posiviteUserRatings) {

        return posiviteUserRatings;
    }else{
    
        NSArray *userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
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
        
        [posiviteUserRatings addObjectsFromArray:positiveRatings];
        
        return positiveRatings;
    }
}


-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithCategoryOfrestaurant:(NSString*)aRestaurantCategory onlyPositive:(BOOL)aBool{
    
    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }

    NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.category==%@",aRestaurantCategory];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:categoryPredicate];
    
    return filteredArray;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithCuisineOfrestaurant:(NSString*)aRestaurantCuisine onlyPositive:(BOOL)aBool{
    
    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.cuisine==%@",aRestaurantCuisine];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:categoryPredicate];
    
    return filteredArray;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithLocationOfrestaurant:(Restaurant*)aRestaurant onlyPositive:(BOOL)aBool{
    
    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.location==%@",aRestaurant.location];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:categoryPredicate];
    
    return filteredArray;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithSmokingOfrestaurant:(NSNumber*)aRestaurantSmoking onlyPositive:(BOOL)aBool{
    
    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *smokingPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.smoking==%@",aRestaurantSmoking];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:smokingPredicate];
    
    return filteredArray;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithPriceRangeOfrestaurant:(NSNumber*)aRestaurant onlyPositive:(BOOL)aBool{
    
    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.priceRange==%@",aRestaurant];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:categoryPredicate];
    
    return filteredArray;
}



-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithGardenValueOfRestaurant:(NSNumber*)gardenValue onlyPositive:(BOOL)aBool{
    
    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *gardenPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.garden==%@",gardenValue];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:gardenPredicate];
    
    return filteredArray;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithLiveMusicValueOfRestaurant:(NSNumber*)aRestaurant onlyPositive:(BOOL)aBool{

    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *gardenPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.liveMusic==%@",aRestaurant];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:gardenPredicate];
    
    return filteredArray;
}


-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithChildFriendlyValueOfRestaurant:(NSNumber*)aRestaurant onlyPositive:(BOOL)aBool{

    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *gardenPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.childFriendly==%@",aRestaurant];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:gardenPredicate];
    
    return filteredArray;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithVegaterianValueOfRestaurant:(NSNumber*)aRestaurant onlyPositive:(BOOL)aBool{

    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *gardenPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.vegaterian==%@",aRestaurant];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:gardenPredicate];
    
    return filteredArray;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser WithCarParkValueOfRestaurant:(NSNumber*)aRestaurant onlyPositive:(BOOL)aBool{

    NSArray *userRatings;
    if (aBool) {
        userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
    }else{
        userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser];
    }
    
    NSPredicate *gardenPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.carPark==%@",aRestaurant];
    NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:gardenPredicate];
    
    return filteredArray;
}


-(NSArray*)getFavoriteGarden:(User*)aUser{


    NSMutableArray *favoriteGarden = [[NSMutableArray alloc] init];

    
    for (int gardenValue=0 ; gardenValue<2;gardenValue++){
        
        
#warning refactor countbased
        float   countBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] countbasedGardenRatingofRestaurant:[NSNumber numberWithInt:gardenValue] ForUser:aUser];
        
        float   ratingBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] pastRatingBasedGardenRatingofRestaurant:[NSNumber numberWithInt:gardenValue]
                                                                                                                                ForUser:aUser onlyPositive:NO];
        
//        currentFavCategory.totalOccurances = [restaurantRatingsWithCategory count];
        double weightedValue    = (countBasedRatingForCurrentCategory*0 + ratingBasedRatingForCurrentCategory*1);
        [favoriteGarden addObject:[NSNumber numberWithDouble:weightedValue]];
    }
//    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
//    [favoriteGarden sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    //add weighted rating
    
    //Sort the favoriteCategoriesArray
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
//    [favoriteCategories sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoriteGarden;

}

-(NSArray*)getFavoriteLiveMusic:(User*)aUser{
    
    NSMutableArray *favoriteLiveMusic = [[NSMutableArray alloc] init];
    
    for (int liveMusicValue=0 ; liveMusicValue<2;liveMusicValue++){
    
#warning refactor countbased
        float   countBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] countbasedLiveMusicRatingofRestaurant:[NSNumber numberWithInt:liveMusicValue] ForUser:aUser];
        
        float   ratingBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] pastRatingBasedLiveMusicRatingofRestaurant:[NSNumber numberWithInt:liveMusicValue]
                                                                                                                                ForUser:aUser onlyPositive:NO];
        
        double weightedValue    = (countBasedRatingForCurrentCategory*0 + ratingBasedRatingForCurrentCategory*1);
        [favoriteLiveMusic addObject:[NSNumber numberWithDouble:weightedValue]];
    }
//    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
//    [favoriteLiveMusic sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];

    return favoriteLiveMusic;    
}


-(NSArray*)getFavoriteChildFriendly:(User*)aUser{
    
    NSMutableArray *favoriteChildFriendlyArray = [[NSMutableArray alloc] init];
    
    for (int childFriendly=0 ; childFriendly<2;childFriendly++){
        
#warning refactor countbased
        float   countBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] countbasedChildFriendlyRatingofRestaurant:[NSNumber numberWithInt:childFriendly] ForUser:aUser];
        
        float   ratingBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] pastRatingBasedChildFriendlyRatingofRestaurant:[NSNumber numberWithInt:childFriendly]
                                                                                                                                   ForUser:aUser onlyPositive:NO];
        
        double weightedValue    = (countBasedRatingForCurrentCategory*0 + ratingBasedRatingForCurrentCategory*1);
        [favoriteChildFriendlyArray addObject:[NSNumber numberWithDouble:weightedValue]];
    }
//    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
//    [favoriteChildFriendlyArray sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    return favoriteChildFriendlyArray;
}

-(NSArray*)getFavoriteCarPark:(User*)aUser{

    NSMutableArray *favoritecarParkArray = [[NSMutableArray alloc] init];
    
    for (int carPark=0 ; carPark<2;carPark++){
        
#warning refactor countbased
        float   countBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] countbasedCarParkRatingofRestaurant:[NSNumber numberWithInt:carPark] ForUser:aUser];
        
        float   ratingBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] pastRatingBasedCarParkRatingofRestaurant:[NSNumber numberWithInt:carPark]
                                                                                                                                       ForUser:aUser onlyPositive:NO];
        
        double weightedValue    = (countBasedRatingForCurrentCategory*0 + ratingBasedRatingForCurrentCategory*1);
        [favoritecarParkArray addObject:[NSNumber numberWithDouble:weightedValue]];
    }
//    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
//    [favoritecarParkArray sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    return favoritecarParkArray;
}


-(NSArray*)getFavoriteCategoriesForUser:(User*)aUser{
    
    NSArray *allCategories = [[DataFetcher sharedInstance] getRestaurantCategories];
    NSMutableArray *favoriteCategories = [NSMutableArray arrayWithCapacity:[allCategories count]];
    
    
    for (NSString *currentCategory in allCategories)
    {
        FavoriteCategory *curentFavoriteCategory = [[FavoriteCategory alloc] init];
        curentFavoriteCategory.name =currentCategory;
        [favoriteCategories addObject:curentFavoriteCategory];
    }

    
    
    for (FavoriteCategory *currentFavCategory in favoriteCategories){
        
        NSString *currentCategory = currentFavCategory.name;
        NSArray *restaurantRatingsWithCategory      =  [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithCategoryOfrestaurant:currentCategory onlyPositive:NO];
        float   countBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] countBasedRatingForCategoryOfRestaurant:currentCategory andUser:aUser onlyPositive:NO];
        float   ratingBasedRatingForCurrentCategory  =  [[RecommendationManager sharedInstance] pastRatingBasedCategoryRatingofRestaurant:currentCategory ForUser:aUser onlyPositive:NO];

        currentFavCategory.totalOccurances = [restaurantRatingsWithCategory count];
        currentFavCategory.weightedValue    = (countBasedRatingForCurrentCategory*0 + ratingBasedRatingForCurrentCategory*1);
        
    }
        
    //add weighted rating
    
    //Sort the favoriteCategoriesArray
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
    [favoriteCategories sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoriteCategories;
}

-(NSArray*)getFavoriteCuisinesForUser:(User*)aUser{
    
    NSArray *allCuisines = [[DataFetcher sharedInstance] getRestaurantCuisines];
    NSMutableArray *favoriteCuisines = [NSMutableArray arrayWithCapacity:[allCuisines count]];
    
    
    for (NSString *currentCuisine in allCuisines)
    {
        FavoriteCuisine *curentFavoriteCuisine = [[FavoriteCuisine alloc] init];
        curentFavoriteCuisine.name =currentCuisine;
        [favoriteCuisines addObject:curentFavoriteCuisine];
    }
    
    for (FavoriteCuisine *currentFavCuisine in favoriteCuisines){
        
        NSString *currentCuisine = currentFavCuisine.name;
        NSArray *restaurantRatingsWithCuisine      =  [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithCuisineOfrestaurant:currentCuisine onlyPositive:NO];
        float   countBasedRatingForCurrentCuisine  =  [[RecommendationManager sharedInstance] countBasedRatingForCuisineOfRestaurant:currentCuisine andUser:aUser onlyPositive:NO];
        float   ratingBasedRatingForCurrentCuisine  =  [[RecommendationManager sharedInstance] pastRatingBasedCuisineRatingofRestaurant:currentCuisine ForUser:aUser onlyPositive:NO];
        
        currentFavCuisine.totalOccurances = [restaurantRatingsWithCuisine count];
        currentFavCuisine.weightedValue    = (countBasedRatingForCurrentCuisine*0 + ratingBasedRatingForCurrentCuisine*1);
        
    }
    //Sort the favoriteCategoriesArray
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
    [favoriteCuisines sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoriteCuisines;
}


-(NSArray*)getFavoriteSmokingForUser:(User*)aUser{
    
    NSMutableArray *favoriteSmokingArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < 3 ; i++)
    {
        FavoriteSmoking *currentFavoriteSmoking = [[FavoriteSmoking alloc] init];
        currentFavoriteSmoking.value = [NSNumber numberWithInt:i];
        [favoriteSmokingArray addObject:currentFavoriteSmoking];
    }
    
    
    for (FavoriteSmoking *currentSmoking in favoriteSmokingArray){
        
        NSArray *restaurantRatingsWithSmoking      =  [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithSmokingOfrestaurant:currentSmoking.value onlyPositive:NO];
        float   countBasedRatingForCurrentSmoking  =  [[RecommendationManager sharedInstance] countBasedRatingForSmokingOfRestaurant:currentSmoking.value andUser:aUser onlyPositive:NO];
        float   ratingBasedRatingForCurrentSmoking  =  [[RecommendationManager sharedInstance] pastRatingBasedSmokingRatingofRestaurant:currentSmoking.value ForUser:aUser onlyPositive:NO];
        
        currentSmoking.totalOccurances = [restaurantRatingsWithSmoking count];
        currentSmoking.weightedValue    = (countBasedRatingForCurrentSmoking*0 + ratingBasedRatingForCurrentSmoking*1);
        
    }
    //Sort the favoriteCategoriesArray
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
    [favoriteSmokingArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoriteSmokingArray;

}

-(NSArray*)getFavoritePriceRange:(User*)aUser{
    
    NSMutableArray *favoritePriceRangeArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < 4 ; i++)
    {
        FavoritePriceRange *currentFavoritePriceRange = [[FavoritePriceRange alloc] init];
        currentFavoritePriceRange.value = [NSNumber numberWithInt:i];
        [favoritePriceRangeArray addObject:currentFavoritePriceRange];
    }
    
    
    for (FavoritePriceRange *currentPriceRange in favoritePriceRangeArray){
        
//        NSArray *restaurantRatingsWithSmoking      =  [[RatingsManager sharedInstance] getRestaurantRatingsForUser:aUser WithSmokingOfrestaurant:currentSmoking.value onlyPositive:NO];
        float   countBasedRatingForCurrentSmoking  =  [[RecommendationManager sharedInstance] countBasedRatingForPriceOfRestaurant:currentPriceRange.value andUser:aUser onlyPositive:NO];
        float   ratingBasedRatingForCurrentSmoking  =  [[RecommendationManager sharedInstance] pastRatingBasedPriceRangeRatingofRestaurant:currentPriceRange.value ForUser:aUser onlyPositive:NO];
        
//        currentPriceRange.totalOccurances = [restaurantRatingsWithSmoking count];
        currentPriceRange.weightedValue    = (countBasedRatingForCurrentSmoking*0 + ratingBasedRatingForCurrentSmoking*1);

        
    }
    //Sort the favoriteCategoriesArray
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.weightedValue" ascending:NO];
    [favoritePriceRangeArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return favoritePriceRangeArray;
    
}



-(NSArray*)getFavoriteLocationForUser:(User*)aUser{
    
    //    NSArray *smokeingValues = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2], nil];
    NSMutableArray *favoriteLocationArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 1; i < 16 ; i++)
    {
        FavoriteLocation *currentFavoriteLocation = [[FavoriteLocation alloc] init];
        currentFavoriteLocation.nameNumber = [NSNumber numberWithInt:i];
        [favoriteLocationArray addObject:currentFavoriteLocation];
    }
    
    NSArray *positiveRAtingsArray =  [[RatingsManager sharedInstance] getPositiveRatingsforUser:aUser];
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

#pragma mark - Rating Predictions


-(int)getNumberOfPositiveRatingsForUser:(User*)anUser WithAttribute:(NSString*)anAttribute andValue:(NSString*)aValue{

    NSArray *positiveRatingArray = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.restaurant.%@==%@",anAttribute,[NSNumber numberWithInt:[aValue intValue]]];
    NSArray *filteredArray = [positiveRatingArray filteredArrayUsingPredicate:predicate];
    
    return (int)[filteredArray count];
}


#pragma mark - Get min/max


//Min Max values
-(int)getMinCategoryForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool{
    
    if (minCategory!=-1 && [anUser isEqual:currentUser]) {
        return minCategory;
    }else{
    
        NSArray *allCategoriesArray = [[DataFetcher sharedInstance] getRestaurantCategories];
        
        minCategory = -1;
        for (NSString *currentCategory in allCategoriesArray)
        {
        
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.category==%@",currentCategory];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (minCategory == -1 || minCategory > [filteredArray count]) {
                minCategory = (int)[filteredArray count] ;
            }
        
        }
    }
return minCategory;
}
-(int)getmaxCategoryForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool{

    if (maxCategory!=-1 && [anUser isEqual:currentUser]) {
        return maxCategory;
    }else{
        
        NSArray *allCategoriesArray = [[DataFetcher sharedInstance] getRestaurantCategories];
        
        maxCategory = -1;
        for (NSString *currentCategory in allCategoriesArray)
        {
            
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.category==%@",currentCategory];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (maxCategory == -1 || maxCategory < [filteredArray count]) {
                maxCategory = (int)[filteredArray count] ;
            }
            
        }
    }
    return maxCategory;
}
-(int)getminCuisineForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool{
    
    if (minCuisine!=-1 && [anUser isEqual:currentUser]) {
        return minCuisine;
    }else{
        
        NSArray *allCuisines = [[DataFetcher sharedInstance] getRestaurantCuisines];
        
        minCuisine = -1;
        for (NSString *currentCategory in allCuisines)
        {
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.cuisine==%@",currentCategory];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (minCuisine == -1 || minCuisine > [filteredArray count]) {
                minCuisine = (int)[filteredArray count] ;
            }

        }
    }
    return minCuisine;

}
-(int)getmaxCuisineForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool{

    if (maxCuisine!=-1 && [anUser isEqual:currentUser]) {
        return maxCuisine;
    }else{
        
        NSArray *allCuisines = [[DataFetcher sharedInstance] getRestaurantCuisines];
        
        maxCuisine = -1;
        for (NSString *currentCuisine in allCuisines)
        {
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.cuisine==%@",currentCuisine];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (maxCuisine == -1 || maxCuisine < [filteredArray count]) {
                maxCuisine = (int)[filteredArray count] ;
            }
            
        }
    }
    return maxCuisine;
}
-(int)getminLocationForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool{
    
    if (minLocation!=-1 && [anUser isEqual:currentUser]) {
        return minLocation;
    }else{
        
        NSArray *allLocations = [[DataFetcher sharedInstance] getRestaurantLocations];
        
        minLocation = -1;
        for (NSNumber *currentLocation in allLocations)
        {
            
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.location==%@",currentLocation];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (minLocation == -1 || minLocation > [filteredArray count]) {
                minLocation = (int)[filteredArray count] ;
            }
            
        }
    }
    return minLocation;
}
-(int)getmaxLocationForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool{

    if (maxLocation!=-1 && [anUser isEqual:currentUser]) {
        return maxLocation;
    }else{
        
        NSArray *allLocations = [[DataFetcher sharedInstance] getRestaurantLocations];
        
        maxLocation = -1;
        for (NSNumber *currentLocation in allLocations)
        {
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.location==%@",currentLocation];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (maxLocation == -1 || maxLocation < [filteredArray count])
            {
                maxLocation = (int)[filteredArray count] ;
            }
        }
    }
    return maxLocation;
}
-(int)getminSmokingForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool{

    if (minSmoking!=-1 && [anUser isEqual:currentUser]) {
        return minSmoking;
    }else{
        
        NSArray *smokingTypes = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2], nil];
        
        minSmoking = -1;
        for (NSNumber *currentSmokingType in smokingTypes)
        {
            
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.smoking==%@",currentSmokingType];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (minSmoking == -1 || minSmoking > [filteredArray count]) {
                minSmoking = (int)[filteredArray count] ;
            }
        }
    }
    return minSmoking;

}

-(int)getmaxSmokingForUser:(User*)anUser onlyPositiveRatings:(BOOL)aBool{

    if (maxSmoking!=-1 && [anUser isEqual:currentUser]) {
        return maxSmoking;
    }else{
        
        NSArray *smokingTypes = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2], nil];
        
        maxSmoking = -1;
        for (NSNumber *curentSmoking in smokingTypes)
        {
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.smoking==%@",curentSmoking];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (maxSmoking == -1 || maxSmoking < [filteredArray count])
            {
                maxSmoking = (int)[filteredArray count] ;
            }
        }
    }
    return maxSmoking;
}

-(int)getminPriceRangeForUser:(User*)anUser  onlyPositiveRatings:(BOOL)aBool{

    if (minPriceRange!=-1 && [anUser isEqual:currentUser]) {
        return minPriceRange;
    }else{
        
        NSArray *smokingTypes = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3], nil];
        
        minPriceRange = -1;
        for (NSNumber *curentSmoking in smokingTypes)
        {
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.priceRange==%@",curentSmoking];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (minPriceRange == -1 || minPriceRange > [filteredArray count])
            {
                minPriceRange = (int)[filteredArray count] ;
            }
        }
    }
    return minPriceRange;
}

-(int)getmaxPriceRangeForUser:(User*)anUser  onlyPositiveRatings:(BOOL)aBool{

    if (maxPriceRange!=-1 && [anUser isEqual:currentUser]) {
        return maxPriceRange;
    }else{
        
        NSArray *smokingTypes = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3], nil];
        
        maxPriceRange = -1;
        for (NSNumber *curentSmoking in smokingTypes)
        {
            NSArray *userRatings;
            if (aBool) {
                userRatings = [[RatingsManager sharedInstance] getPositiveRatingsforUser:anUser];
            }else{
                userRatings = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:anUser];
            }
            
            NSPredicate *ratingsPredicate = [NSPredicate predicateWithFormat:@"self.restaurant.priceRange==%@",curentSmoking];
            NSArray *filteredArray = [userRatings filteredArrayUsingPredicate:ratingsPredicate];
            
            if (maxPriceRange == -1 || maxPriceRange < [filteredArray count])
            {
                maxPriceRange = (int)[filteredArray count] ;
            }
        }
    }
    return maxPriceRange;
}

@end
