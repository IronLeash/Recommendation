//
//  RatingsManager.m
//  Recommendation
//
//  Created by ilker on 16.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "RatingsManager.h"
#import "RestaurantRating.h"
#import "AppDelegate.h"
#import "DataFetcher.h"
#import "StatisticsLibrary.h"
#import "Restaurant.h"
#import "Constants.h"

static RatingsManager *ratingsManager = nil;
static NSManagedObjectContext *ratingsMoC;


@implementation RatingsManager

+(RatingsManager*)sharedInstance{


   	@synchronized([RatingsManager class])
	{

        
		if (!ratingsManager)
        {

            AppDelegate *appdelegate = (AppDelegate*)[[NSApplication sharedApplication] delegate];
            ratingsMoC = [[NSManagedObjectContext alloc] init];
            
            NSPersistentStoreCoordinator *coordinator = appdelegate.persistentStoreCoordinator;
            [ratingsMoC setPersistentStoreCoordinator:coordinator];
            [ratingsMoC setUndoManager:nil];
            
            return [[self alloc] init];
        }else{
            return ratingsManager;
        }
    }
    
	return nil;


}

#pragma mark - Ratings

-(NSArray*)getRestaurantRatings{
    
    //Check if cusines are alreadyThere
    //Fetsch results
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"RestaurantRating" inManagedObjectContext:ratingsMoC];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [ratingsMoC executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray*)getRestaurantRatingsForUser:(User*)aUser{
    
    //Check if cusines are alreadyThere
    //Fetsch results
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
    
    return sortedArray;
    
}


-(NSArray*)getPositiveRatingsforUser:(User*)aUser{
    
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
    
    return positiveRatings;
}


-(NSArray*)getFavoriteCategoriesForUser:(User*)currentUser{
    
    NSArray *allCategories = [[DataFetcher sharedInstance] getRestaurantCategories];
    NSMutableArray *favoriteCategories = [NSMutableArray arrayWithCapacity:[allCategories count]];
    
    for (NSString *currentCategory in allCategories)
    {
        FavoriteCategory *curentFavoriteCategory = [[FavoriteCategory alloc] init];
        curentFavoriteCategory.name =currentCategory;
        [favoriteCategories addObject:curentFavoriteCategory];
    }
    
    NSArray *positiveRAtingsArray =  [[RatingsManager sharedInstance] getPositiveRatingsforUser:currentUser];
    float   averagePositveRating =[StatisticsLibrary weightedpositveRatingsMean:positiveRAtingsArray];
    
    //Iterate all positive ratings
    for (RestaurantRating *currentRating in positiveRAtingsArray){
        
        NSString *likedCategory = currentRating.restaurant.category;
        
        for (FavoriteCategory *favCategory in favoriteCategories) {
            if ([favCategory.name isEqualToString:likedCategory]) {
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
    
    for (NSString *currentCuisine in allCuisines)
    {
        FavoriteCuisine *currentFavoriteCuisine = [[FavoriteCuisine alloc] init];
        currentFavoriteCuisine.name =currentCuisine;
        [favoriteCuisines addObject:currentFavoriteCuisine];
    }
    
    NSArray *positiveRAtingsArray =  [[RatingsManager sharedInstance] getPositiveRatingsforUser:currentUser];
    float   averagePositveRating =[StatisticsLibrary weightedpositveRatingsMean:positiveRAtingsArray];
    
    //Iterate all positive ratings
    for (RestaurantRating *currentRating in positiveRAtingsArray){
        NSString *likedCuisine = currentRating.restaurant.cuisine;
        
        for (FavoriteCuisine *favoriteCuisine in favoriteCuisines) {
            if ([favoriteCuisine.name isEqualToString:likedCuisine]) {
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
    
    NSArray *positiveRAtingsArray =  [[RatingsManager sharedInstance] getPositiveRatingsforUser:currentUser];
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
    
    NSArray *positiveRAtingsArray =  [[RatingsManager sharedInstance] getPositiveRatingsforUser:currentUser];
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


@end
