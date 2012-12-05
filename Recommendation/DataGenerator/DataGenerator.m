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

#import "Cuisine.h"
#import "Category.h"
#import "Restaurant.h"
#import "User.h"
#import "RatingWeight.h"
#import "RestaurantRating.h"
#import "StatisticsLibrary.h"

#import "Constants.h"

#import "FavoriteCuisine.h"
#import "FavoriteSmoking.h"

@implementation DataGenerator

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
        NSArray *cuisinesArray = [[NSArray alloc] initWithObjects:@"Turkish",
                                  @"French",
                                  @"Austrian",
                                  @"Italian",
                                  @"Spanish",
                                  @"Greek",
                                  @"World",
                                  @"Korea",
                                  @"Japan",
                                  @"Thailand",
                                  @"Chinese",
                                  @"Mexica",
                                  @"Argentina",
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
-(void)generateUserStereotypes{

}
-(void)generateUsers:(int)numberOfUsers{
    
    
    NSArray *stereoTypes  = [NSArray arrayWithObjects:@"Student",
                                                        @"Ambiance lover",
                                                        @"Gourme",
                                                        @"Family",
                                                        @"Vegaterian",
                                                        @"Tourist",nil];
    
        @autoreleasepool
        {            

#warning assignauniq id
            
            int currentUserIndex = 1;

            for (NSString *currentStereotype in stereoTypes) {
            
                for (int i = 0; i < numberOfUsers/[stereoTypes count]; i++) {

                    User* currentUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc];
                    
                    int age = (arc4random() %(40))+25;
                    int gender = arc4random() %(2);
                    int location = arc4random() %(15);
                    int smoker = arc4random() %(2);
                    int vegaterian = arc4random() %(2);
                    
                    currentUser.userid = [NSString stringWithFormat:@"User %@",[NSNumber numberWithInt:currentUserIndex]];
                    currentUser.age = [NSNumber numberWithInt:age];
                    currentUser.gender = [NSNumber numberWithInt:gender];
                    currentUser.location = [NSNumber numberWithInt:location];
                    currentUser.smoker = [NSNumber numberWithInt:smoker];
                    currentUser.vegeterian = [NSNumber numberWithInt:vegaterian];
                    currentUser.stereotype = currentStereotype;
                
                    
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
    NSArray *cuisines = [NSArray arrayWithArray:[[DataFetcher sharedInstance] getRestaurantCuisines]];
    //Get all cuisine in
    NSArray *categories = [NSArray arrayWithArray:[[DataFetcher sharedInstance] getRestaurantCategories]];
    
    
    @autoreleasepool
    {
    for (int i = 0; i < numberOfRestaurants ; i++) {
        
        int curentRandomCuisineNumber = arc4random() %([cuisines count]-1);
        int curentRandomCategoryNumber = arc4random() %([categories count]-1);
        
        int curentRandomSmokingNumber = arc4random() %(3);
        int curentRandomCarParkNumber = arc4random() %(2);
        int curentRandomChildFriendlyNumber = arc4random() %(2);
        int curentRandomVegeterianNumber = arc4random() %(2);
        int curentRandomPriceRangeNumber = arc4random() %(4);
        int curentRandomLocationNumber = (arc4random() %(15))+1;
        int curentRandomGardenNumber = arc4random() %(2);
        int curentRandomLiveMusicNumber = arc4random() %(2);
        
        
        Cuisine *currentCuisine = [cuisines objectAtIndex:curentRandomCuisineNumber];
        Category *currentCateory = [categories objectAtIndex:curentRandomCategoryNumber];
        
        
        NSLog(@"Generate New restaurant with cuisine %@" ,currentCuisine.name);
        NSLog(@"Generate New restaurant with category %@",currentCateory.name);

        NSLog(@"Generate New restaurant with smoking %d",curentRandomSmokingNumber);
        NSLog(@"Generate New restaurant with park %d",curentRandomCarParkNumber);
        NSLog(@"Generate New restaurant with childFriendly %d",curentRandomChildFriendlyNumber);
        NSLog(@"Generate New restaurant with vegeterian %d",curentRandomVegeterianNumber);
        NSLog(@"Generate New restaurant with price range %d",curentRandomLiveMusicNumber);
        NSLog(@"--------------------------------------");

    
            Restaurant* currentRestaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:moc];
            currentRestaurant.categories = currentCateory;
            currentRestaurant.cuisine = currentCuisine;
            currentRestaurant.restaurantId = [NSString stringWithFormat:@"RestId %d",i];
            currentRestaurant.liveMusic = [NSNumber numberWithInt:curentRandomLiveMusicNumber];
            currentRestaurant.garden = [NSNumber numberWithInt:curentRandomGardenNumber];
            currentRestaurant.carPark = [NSNumber numberWithInt:curentRandomCarParkNumber];
            currentRestaurant.location = [NSNumber numberWithInt:curentRandomLocationNumber];
            currentRestaurant.smoking = [NSNumber numberWithInt:curentRandomSmokingNumber];
            currentRestaurant.childFriendly = [NSNumber numberWithInt:curentRandomChildFriendlyNumber];
            currentRestaurant.priceRange = [NSNumber numberWithInt:curentRandomPriceRangeNumber];
            currentRestaurant.vegeterian = [NSNumber numberWithInt:curentRandomVegeterianNumber];
            
            }
        NSError *error = nil;
        [moc save:&error];
        
        if (error) {
            NSLog(@"Error %@",error);
        }
    
    
    //Restaurants generated save entropies in NSUserDefauls
        NSDictionary *restaurantAttributesEntropyDictionary = [StatisticsLibrary entopyOfVariable];
        [[NSUserDefaults standardUserDefaults] setObject:restaurantAttributesEntropyDictionary forKey:kRestaurantAttributesEntropyDistionary];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

-(void)generateRatingForUser:(User*)aUser
{

    NSArray *restaurantsArray = [[DataFetcher sharedInstance] getRestaurants];
    
    //Iterate all restaruants

    @autoreleasepool {
        
    for (Restaurant *currentRestaunt in restaurantsArray)
    {
        RestaurantRating* restaurantRating = [NSEntityDescription insertNewObjectForEntityForName:@"RestaurantRating" inManagedObjectContext:moc];
        
        restaurantRating.restaurant = currentRestaunt;
        restaurantRating.user   = aUser;
        
        int accessibilityRating = (arc4random() %(10))+1;
        int coreServiceRating = (arc4random() %(10))+1;
        int personalRating = (arc4random() %(10))+1;
        int serviceRating = (arc4random() %(10))+1;
        int tangiblesRating = (arc4random() %(10))+1;
        
        restaurantRating.accessibilityRating = [NSNumber  numberWithInt:accessibilityRating];
        restaurantRating.coreServiceRating = [NSNumber  numberWithInt:coreServiceRating];
        restaurantRating.personalRating = [NSNumber  numberWithInt:personalRating];
        restaurantRating.serviceRating = [NSNumber  numberWithInt:serviceRating];
        restaurantRating.tangiblesRating = [NSNumber  numberWithInt:tangiblesRating];

        
    }
        
        NSError *error = nil;
        [moc save:&error];
        
        if (error) {
            NSLog(@"Error %@",error);
        }
        
    
    }

}


-(void)setUserPreferenceForUser:(User*)aUser
{

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
}



-(void)generateRatingFoAllUsers
{
    NSArray *allUsers = [[DataFetcher sharedInstance] getUsers];

    for (User *currentUser in allUsers){
        
        [[DataGenerator sharedInstance] generateRatingForUser:currentUser];
    }
    
#warning Notification
}





@end
