//

//  DataGenerator.m
//  Recommendation
//
//  Created by ilker on 18.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerator.h"
#import "DataFetcher.h"

#import "AppDelegate.h"

#import "Restaurant.h"
#import "User.h"
#import "RatingWeight.h"
#import "RestaurantRating.h"
#import "StatisticsLibrary.h"

#import "Constants.h"

#import "FavoriteCuisine.h"
#import "FavoriteSmoking.h"

//Rules
#import "DataGenerationRulesRestaurant.h"
#import "DataGenerationRulesUser.h"
#import "DataGenerationRulesRating.h"
#import "RatingsManager.h"



@implementation DataGenerator

NSString *ratingsGeneratedNotification = @"ratingGeenratedNotification";

static DataGenerator* dataGenerator = nil;
static  NSManagedObjectContext *moc;


#pragma mark - Shared Instance
#pragma mark -
+(DataGenerator*)sharedInstance;
{
	@synchronized([DataGenerator class])
	{
        AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
        moc= [appDelegate managedObjectContext];

		if (!dataGenerator)
        {
		return [[self alloc] init];
        }else{
        return dataGenerator;
        }
    }
    
	return nil;
}

+(id)alloc
{
	@synchronized([DataGenerator class])
	{
		NSAssert(dataGenerator == nil, @"Attempted to allocate a second instance of a singleton.");
		dataGenerator = [super alloc];

		return dataGenerator;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
    
	return self;
}

#pragma mark - Generator methods
#pragma mark -

/*
-(void)generateCusines{
    
    
    //Check if cusines are alreadyThere
    //Fetsch results
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Cuisine" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];

    
    if (array == nil)
    {
        // Deal with error...
    }

    //Entity does not exist
    if ([array  count] == 0) {
        //Get Managed Context
        NSArray *cuisinesArray = [[NSArray alloc] initWithObjects:
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
        
        
        @autoreleasepool
        {
            for (NSString* currentCuisineName in cuisinesArray) {
                
                NSManagedObject *cuisineEntityManagedObject = [NSEntityDescription
                                                               insertNewObjectForEntityForName:@"Cuisine"
                                                               inManagedObjectContext:moc];
                
                [cuisineEntityManagedObject setValue:currentCuisineName forKey:@"name"];
            }
            
            NSError *error = nil;
            [moc save:&error];
            
            if (error) {
                NSLog(@"Error %@",error);
            }
        }
    }
}
*/

/*
-(void)generateCategories{
    
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
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    
    if (array == nil)
    {
        // Deal with error...
    }
    
    //Entity does not exist
    if ([array  count] == 0) {
        //Get Managed Context
        NSArray *cuisinesArray = [[NSArray alloc] initWithObjects:
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
    
        @autoreleasepool
        {
            
            for (NSString* currentCuisineName in cuisinesArray) {
                
                NSManagedObject *cuisineEntityManagedObject = [NSEntityDescription
                                                               insertNewObjectForEntityForName:@"Category"
                                                               inManagedObjectContext:moc];
                
                [cuisineEntityManagedObject setValue:currentCuisineName forKey:@"name"];
                
            }
            
            NSError *error = nil;
            [moc save:&error];
            
            if (error) {
                NSLog(@"Error %@",error);
            }
            
        }
    }


}
 */


-(void)generateUserStereotypes{

}
-(void)generateUsers:(int)numberOfUsers{
    
    NSArray *stereoTypes  = [NSArray arrayWithObjects:kStudent,kAmbianceLover,kGourmet,kFamily,kVegaterian,kTourist,nil];
    
        @autoreleasepool
        {
            int currentUserIndex = 1;
            for (NSString *currentStereotype in stereoTypes) {
            
                for (int i = 0; i < numberOfUsers/[stereoTypes count]; i++) {

                    User* currentUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc];
                    
//                    int age = (arc4random() %(40))+25;
                    int gender = arc4random() %(2);
                    int location = arc4random() %(15);
//                    int smoker = arc4random() %(2);
//                    int vegaterian = arc4random() %(2);
                    
                    currentUser.userid      = [NSString stringWithFormat:@"User %@",[NSNumber numberWithInt:currentUserIndex]];
                    currentUser.age         = [NSNumber numberWithInt:[DataGenerationRulesUser userAgePredictionFor:currentStereotype]];
                    currentUser.gender      = [NSNumber numberWithInt:gender];
                    currentUser.location    = [NSNumber numberWithInt:location];
                    currentUser.smoker      = [NSNumber numberWithInt:[DataGenerationRulesUser userSmokingPredictionFor:currentStereotype]];
                    currentUser.vegaterian  = [NSNumber numberWithInt:[DataGenerationRulesUser userVegetarianPredictionFor:currentStereotype]];
                    currentUser.stereotype  = currentStereotype;
                
                    
                    RatingWeight *ratingWeight = [NSEntityDescription insertNewObjectForEntityForName:@"RatingWeight" inManagedObjectContext:moc];
                    float accessibility = (arc4random() %(9))+1;
                    float coreService = (arc4random() %(9))+1;
                    float personal = (arc4random() %(9))+1;
                    float service = (arc4random() %(9))+1;
                    float tangibles = (arc4random() %(9))+1;
                
                    //normalizer
                    float total = accessibility+coreService+personal+service+tangibles;
                    
                    accessibility = accessibility/total;
                    coreService = coreService/total;
                    personal = personal/total;
                    service= service/total;
                    tangibles= tangibles/total;
                    
                    ratingWeight.accessibility = [NSNumber numberWithFloat:accessibility];
                    ratingWeight.coreService = [NSNumber numberWithFloat:coreService];
                    ratingWeight.personal = [NSNumber numberWithFloat:personal];
                    ratingWeight.service = [NSNumber numberWithFloat:service];
                    ratingWeight.tangibles = [NSNumber numberWithFloat:tangibles];
                    
                    currentUser.ratingWeight = ratingWeight;
                    currentUserIndex++;
                    

                }
            }
        }

    
    NSError *error = nil;
    [moc save:&error];
    
    if (error) {
        NSLog(@"Error %@",error);
    }

}

-(void)generateRestaurants:(int)numberOfRestaurants{

    //Get all restaurant categories
//    NSArray *cuisines = [NSArray arrayWithArray:[[DataFetcher sharedInstance] getRestaurantCuisines]];
    //Get all cuisine in
    NSArray *categories = [NSArray arrayWithArray:[[DataFetcher sharedInstance] getRestaurantCategories]];
    
    
    @autoreleasepool
    {
    for (int i = 0; i < numberOfRestaurants ; i++) {
        
        int curentRandomCategoryNumber = arc4random() %([categories count]-1);
        int curentRandomLocationNumber = (arc4random() %(15))+1;        
        
        NSString *currentCateory = [categories objectAtIndex:curentRandomCategoryNumber];
        NSString *currentCuisine = [DataGenerationRulesRestaurant cuisineForCategory:currentCateory];

            Restaurant* currentRestaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:moc];
            currentRestaurant.category = currentCateory;

            currentRestaurant.cuisine = currentCuisine;
            currentRestaurant.uniqueName = [NSString stringWithFormat:@"RestId %d",i];
            currentRestaurant.liveMusic = [NSNumber numberWithInt:[DataGenerationRulesRestaurant liveMusicForCategory:currentCateory]];
            currentRestaurant.garden = [NSNumber numberWithInt:[DataGenerationRulesRestaurant gardenForCategory:currentCateory]];
            currentRestaurant.carPark = [NSNumber numberWithInt:[DataGenerationRulesRestaurant carParkForCategory:currentCateory]];
            currentRestaurant.location = [NSNumber numberWithInt:curentRandomLocationNumber];
            currentRestaurant.smoking = [NSNumber numberWithInt:[DataGenerationRulesRestaurant smokingForCategory:currentCateory]];
            currentRestaurant.childFriendly = [NSNumber numberWithInt:[DataGenerationRulesRestaurant childFriendlyForCategory:currentCateory]];
            currentRestaurant.priceRange = [NSNumber numberWithInt:[DataGenerationRulesRestaurant priceForCategory:currentCateory]];
            currentRestaurant.vegaterian = [NSNumber numberWithInt:[DataGenerationRulesRestaurant vegetarianForCategory:currentCateory]];
        
    }
    }
    
    
    //Restaurants generated save entropies in NSUserDefauls
    NSDictionary *restaurantAttributesEntropyDictionary = [StatisticsLibrary entopyOfVariable];
    [[NSUserDefaults standardUserDefaults] setObject:restaurantAttributesEntropyDictionary forKey:kRestaurantAttributesEntropyDistionary];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSError *error = nil;
    [moc save:&error];
    
    if (error) {
        NSLog(@"Error %@",error);
    }
    
}

-(void)generateRatingForUser:(User*)aUser
{

    @autoreleasepool {
        
    //Iterate all restaruants
    RestaurantRating* restaurantRating;
        AppDelegate *appdelegate = (AppDelegate*)[[NSApplication sharedApplication] delegate];
        NSManagedObjectContext *importContext = [[NSManagedObjectContext alloc] init];
        NSPersistentStoreCoordinator *coordinator = appdelegate.persistentStoreCoordinator;
        [importContext setPersistentStoreCoordinator:coordinator];
        [importContext setUndoManager:nil];
        NSArray *restaurantsArray = [[DataFetcher sharedInstance] getRestaurantsinManagedObjectContext:importContext];
//        User *currentUser = [DataFetcher sharedInstance] getUserInManagedObjectContext:importContext]]
    for (Restaurant *currentRestaunt in restaurantsArray)
    {
        
        restaurantRating = [NSEntityDescription insertNewObjectForEntityForName:@"RestaurantRating" inManagedObjectContext:importContext];        

#warning just assign restaurant and user ids ????
#warning slowing down
        
        [importContext refreshObject:restaurantRating mergeChanges:YES];
        restaurantRating.restaurant = currentRestaunt;
//        restaurantRating.user   = aUser;
        
        NSDictionary *ratingDicitonary = [[DataGenerationRulesRating sharedInstance] ratingsForRestaruant:currentRestaunt ofUser:aUser];
        
        restaurantRating.accessibilityRating = [ratingDicitonary objectForKey:kAccessibility];
        restaurantRating.coreServiceRating = [ratingDicitonary objectForKey:kCoreService];
        restaurantRating.personalRating = [ratingDicitonary objectForKey:kPersonal];
        restaurantRating.serviceRating = [ratingDicitonary objectForKey:kService];
        restaurantRating.tangiblesRating = [ratingDicitonary objectForKey:kTangibles];


    }
    
    NSError *error = nil;
    [importContext save:&error];
    
    if (error) {
        NSLog(@"Error %@",error);
    }

    }

}

-(void)generateAllUserRatings{
    NSTimeInterval start= [[NSDate date] timeIntervalSince1970];

    @autoreleasepool {
        
        //Iterate all restaruants

        AppDelegate *appdelegate = (AppDelegate*)[[NSApplication sharedApplication] delegate];
        NSManagedObjectContext *importContext = [[NSManagedObjectContext alloc] init];
        NSPersistentStoreCoordinator *coordinator = appdelegate.persistentStoreCoordinator;
        [importContext setPersistentStoreCoordinator:coordinator];
        [importContext setUndoManager:nil];
        
        NSArray *restaurantsArray = [[DataFetcher sharedInstance] getRestaurantsinManagedObjectContext:importContext];
        NSArray *usersArray = [[DataFetcher sharedInstance] getUsersInManagedObjectContext:importContext];
        
    
        int i = 0;
        for (User *aUser in usersArray) {
            NSTimeInterval userStartTime= [[NSDate date] timeIntervalSince1970];

            for (Restaurant *currentRestaunt in restaurantsArray)
            {
                
                RestaurantRating* restaurantRating = [NSEntityDescription insertNewObjectForEntityForName:@"RestaurantRating" inManagedObjectContext:importContext];
                
                restaurantRating.restaurant = currentRestaunt;
                restaurantRating.user   = aUser;
                
                NSDictionary *ratingDicitonary = [[DataGenerationRulesRating sharedInstance] ratingsForRestaruant:currentRestaunt ofUser:aUser];
                
                restaurantRating.accessibilityRating = [ratingDicitonary objectForKey:kAccessibility];
                restaurantRating.coreServiceRating = [ratingDicitonary objectForKey:kCoreService];
                restaurantRating.personalRating = [ratingDicitonary objectForKey:kPersonal];
                restaurantRating.serviceRating = [ratingDicitonary objectForKey:kService];
                restaurantRating.tangiblesRating = [ratingDicitonary objectForKey:kTangibles];

                 }
            
            NSError *error = nil;
            [importContext save:&error];
            
            if (error) {
                NSLog(@"Error %@",error);
            }
            NSTimeInterval userEndTime= [[NSDate date] timeIntervalSince1970];

            i++;
            NSLog(@"User %d Created in %f",i, userEndTime-userStartTime);
        }

    }
    NSTimeInterval end= [[NSDate date] timeIntervalSince1970];
    
    NSLog(@"Seconds %f",end-start);
}



-(void)setUserPreferenceForUser:(User*)aUser
{

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
}





@end
