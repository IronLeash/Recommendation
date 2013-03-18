//
//  DataGenerationRulesRating.m
//  Recommendation
//
//  Created by ilker on 10.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerationRulesRating.h"
#import "DataFetcher.h"
#import "User.h"
#import "Constants.h"

@implementation DataGenerationRulesRating

static DataGenerationRulesRating* dataGenerationRulesRating = nil;

static NSArray *favoriteStudentCategories;
static NSArray *favoriteTouriestCategories;
static NSArray *favoriteGourmetCategories;
static NSArray *favoriteFamilyCategories;
static NSArray *favoriteAmbianceLoverCategories;
static NSArray *favoriteVegaterianCategories;


static NSArray *favoriteStudentCuisines;
static NSArray *favoriteTouriestCuisines;
static NSArray *favoriteGourmetCuisines;
static NSArray *favoriteFamilyCuisines;
static NSArray *favoriteAmbianceLoverCuisines;
static NSArray *favoriteVegaterianCuisines;


#pragma mark - Shared Instance
#pragma mark -
+(DataGenerationRulesRating*)sharedInstance;
{
	@synchronized(self)
	{

		if (!dataGenerationRulesRating)
        {

            favoriteStudentCategories = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kStudent]];
            favoriteTouriestCategories =[[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kTourist]];
            favoriteGourmetCategories =[[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kGourmet]];
            favoriteFamilyCategories =[[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kFamily]];
            favoriteAmbianceLoverCategories =[[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kAmbianceLover]];
            favoriteVegaterianCategories = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kVegaterian]];
            
            favoriteStudentCuisines     = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCuisinesForStereotype:kStudent]];
            favoriteTouriestCuisines    = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCuisinesForStereotype:kTourist]];
            favoriteGourmetCuisines     = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCuisinesForStereotype:kGourmet]];
            favoriteFamilyCuisines      = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCuisinesForStereotype:kFamily]];
            favoriteAmbianceLoverCuisines = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCuisinesForStereotype:kAmbianceLover]];
            favoriteVegaterianCuisines  = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCuisinesForStereotype:kVegaterian]];
            
            dataGenerationRulesRating = [[self alloc] init];

        }
    }
    
	return dataGenerationRulesRating;
}


- (id) init {

    self = [super init];
    if (self) {
        // Initialization
        
        favoriteStudentCategories = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kStudent]];
        favoriteTouriestCategories =[[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kTourist]];
        favoriteGourmetCategories =[[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kGourmet]];
        favoriteFamilyCategories =[[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kFamily]];
        favoriteAmbianceLoverCategories =[[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kAmbianceLover]];
        favoriteVegaterianCategories = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kVegaterian]];
        
    }
    return self;
}


-(NSDictionary*)getRatingForRestaurant:(Restaurant*)aRest ofFamilyUser:(User*)aUser{

    double childFriendly;
    double carPark;
    double smoking;
    double garden;
    double liveMusic;
    double category;
    double cuisine;
    double price;
    
//    if ([aUser.stereotype isEqualToString:kFamily]) {
        childFriendly   = [[DataGenerationRulesRating sharedInstance] childFriendly:aRest ofUser:aUser];
        carPark         = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
        smoking         = [[DataGenerationRulesRating sharedInstance] smokingFactor:aRest ofUser:aUser];
        garden          = [[DataGenerationRulesRating sharedInstance] gardenFactor :aRest ofUser:aUser];
        liveMusic       = [[DataGenerationRulesRating sharedInstance] liveMusicFactor:aRest ofUser:aUser];
        category        = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
        cuisine         = [[DataGenerationRulesRating sharedInstance] cuisineFactor:aRest ofUser:aUser];
        price           = [[DataGenerationRulesRating sharedInstance] priceFactor:aRest ofUser:aUser];
//    } else {

//    }

    
    int accessibilityRatingPenalty = (arc4random() %(2));
    int coreServiceRatingPenalty = (arc4random() %(2));
    int personalRatingPenalty = (arc4random() %(2));
    int serviceRatingPenalty = (arc4random() %(2));
    int tangiblesRatingPenalty = (arc4random() %(2));

    
    //    if ([aUser.stereotype isEqualToString:kFamily]) {
    int accessibilityRating = (price*0.10
                               +childFriendly*0.20
                               +garden*0.20
                               +smoking*0.30
                               +carPark*0.20)+accessibilityRatingPenalty;
    int coreServiceRating   = (price*0.10+
                               childFriendly*0.10
                               +garden*0.10
                               +smoking*0.10
                               +category*0.20
                               +cuisine*0.20
                               +carPark*0.10
                               +liveMusic*0.10)+coreServiceRatingPenalty;
    int personalRating      = (price*0.20+
                               childFriendly*0.20+
                               garden*0.10+
                               category*0.15+
                               cuisine*0.15+
                               liveMusic*0.20)+personalRatingPenalty;
    int serviceRating       = (price*0.10+
                               +garden*0.10+
                               smoking*0.10
                               +category*0.20
                               +cuisine*0.30
                               +carPark*0.10
                               +liveMusic*0.10)+serviceRatingPenalty;
    int tangiblesRating     = (price*0.3
                               +childFriendly*0.3
                               +garden*0.10
                               +carPark*0.20
                               +liveMusic*0.10)
                                +tangiblesRatingPenalty;
    
    
    if (accessibilityRating > 10) {
        accessibilityRating = 10;
    }
    
    if (coreServiceRating >10) {
        coreServiceRating = 10;
    }
    
    if (personalRating >10) {
        personalRating = 10;
    }
    
    if (serviceRating >10) {
        serviceRating = 10;
    }
    
    if (tangiblesRating >10) {
        tangiblesRating= 10;
    }
    
    
    if (accessibilityRating < 1) {
        accessibilityRating = 1;
    }
    if (coreServiceRating <1) {
        coreServiceRating = 1;
    }
    if (personalRating  < 1) {
        personalRating = 1;
    }
    if (serviceRating < 1) {
        serviceRating = 1;
    }
    if (tangiblesRating < 1) {
        tangiblesRating= 1;
    }
    
    
    NSDictionary *returnDicitonary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:accessibilityRating],
                                                                          [NSNumber numberWithInt:coreServiceRating],
                                                                          [NSNumber numberWithInt:personalRating],
                                                                          [NSNumber numberWithInt:serviceRating],
                                                                          [NSNumber numberWithInt:tangiblesRating],nil]
                                                                 forKeys:[NSArray arrayWithObjects:kAccessibility,kCoreService,kPersonal,kService,kTangibles, nil]];
    return returnDicitonary;
}


-(NSDictionary*)getRatingForRestaurant:(Restaurant*)aRest ofStudentUser:(User*)aUser{

    double carPark;
    double smoking;
    double garden;
    double liveMusic;
    double category;
    double cuisine;
    double price;
    

    carPark         = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    smoking         = [[DataGenerationRulesRating sharedInstance] smokingFactor:aRest ofUser:aUser];
    garden          = [[DataGenerationRulesRating sharedInstance] gardenFactor :aRest ofUser:aUser];
    liveMusic       = [[DataGenerationRulesRating sharedInstance] liveMusicFactor:aRest ofUser:aUser];
    category        = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    cuisine         = [[DataGenerationRulesRating sharedInstance] cuisineFactor:aRest ofUser:aUser];
    price           = [[DataGenerationRulesRating sharedInstance] priceFactor:aRest ofUser:aUser];
    
    int accessibilityRatingPenalty = (arc4random() %(2));
    int coreServiceRatingPenalty = (arc4random() %(2));
    int personalRatingPenalty = (arc4random() %(2));
    int serviceRatingPenalty = (arc4random() %(2));
    int tangiblesRatingPenalty = (arc4random() %(2));
    
    
    //    if ([aUser.stereotype isEqualToString:kFamily]) {
    int accessibilityRating = (price*0.50
                               +garden*0.20
                               +smoking*0.20
                               +carPark*0.10)+accessibilityRatingPenalty;

    int coreServiceRating   = (price*0.20+
                               +garden*0.10
                               +smoking*0.10
                               +category*0.20
                               +cuisine*0.20
                               +liveMusic*0.20)+coreServiceRatingPenalty;
    
    
    int personalRating      = (price*0.30+
                               garden*0.20+
                               category*0.15+
                               cuisine*0.15+
                               liveMusic*0.20)+personalRatingPenalty;
    
    int serviceRating       = (price*0.30+
                               +garden*0.10+
                               smoking*0.20
                               +category*0.10
                               +cuisine*0.10
                               +liveMusic*0.20)+serviceRatingPenalty;
    
    int tangiblesRating     = (price*0.10
                               +garden*0.50
                               +carPark*0.10
                               +liveMusic*0.30)+tangiblesRatingPenalty;
    
    
    if (accessibilityRating > 10) {
        accessibilityRating = 10;
    }
    
    if (coreServiceRating >10) {
        coreServiceRating = 10;
    }
    
    if (personalRating >10) {
        personalRating = 10;
    }
    
    if (serviceRating >10) {
        serviceRating = 10;
    }
    
    if (tangiblesRating >10) {
        tangiblesRating= 10;
    }
    
    
    if (accessibilityRating < 1) {
        accessibilityRating = 1;
    }
    if (coreServiceRating <1) {
        coreServiceRating = 1;
    }
    if (personalRating  < 1) {
        personalRating = 1;
    }
    if (serviceRating < 1) {
        serviceRating = 1;
    }
    if (tangiblesRating < 1) {
        tangiblesRating= 1;
    }
    
    
    NSDictionary *returnDicitonary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:accessibilityRating],
                                                                          [NSNumber numberWithInt:coreServiceRating],
                                                                          [NSNumber numberWithInt:personalRating],
                                                                          [NSNumber numberWithInt:serviceRating],
                                                                          [NSNumber numberWithInt:tangiblesRating],nil]
                                                                 forKeys:[NSArray arrayWithObjects:kAccessibility,kCoreService,kPersonal,kService,kTangibles, nil]];
    return returnDicitonary;
}



-(NSDictionary*)getRatingForRestaurant:(Restaurant*)aRest ofGourmetUser:(User*)aUser{

    double childFriendly;
    double carPark;
    double smoking;
    double garden;
    double liveMusic;
    double category;
    double cuisine;
    double price;
    
    //    if ([aUser.stereotype isEqualToString:kFamily]) {
    childFriendly   = [[DataGenerationRulesRating sharedInstance] childFriendly:aRest ofUser:aUser];
    carPark         = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    smoking         = [[DataGenerationRulesRating sharedInstance] smokingFactor:aRest ofUser:aUser];
    garden          = [[DataGenerationRulesRating sharedInstance] gardenFactor :aRest ofUser:aUser];
    liveMusic       = [[DataGenerationRulesRating sharedInstance] liveMusicFactor:aRest ofUser:aUser];
    category        = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    cuisine         = [[DataGenerationRulesRating sharedInstance] cuisineFactor:aRest ofUser:aUser];
    price           = [[DataGenerationRulesRating sharedInstance] priceFactor:aRest ofUser:aUser];
    //    } else {
    
    //    }
    
    
    int accessibilityRatingPenalty = (arc4random() %(4));
    int coreServiceRatingPenalty = (arc4random() %(4));
    int personalRatingPenalty = (arc4random() %(4));
    int serviceRatingPenalty = (arc4random() %(4));
    int tangiblesRatingPenalty = (arc4random() %(4));
    
    int accessibilityRating = (price*0.30
                               +childFriendly*0.05
                               +garden*0.05
                               +smoking*0.40
                               +carPark*0.20)+accessibilityRatingPenalty;
    
    int coreServiceRating   = (price*0.40+
                               +smoking*0.30
                               +category*0.05
                               +cuisine*0.05
                               +carPark*0.10
                               +liveMusic*0.10)+coreServiceRatingPenalty;
    
    
    int personalRating      = (price*0.40+
                               category*0.15+
                               cuisine*0.15+
                               carPark*0.10+
                               smoking*0.10+
                               liveMusic*0.10)+personalRatingPenalty;
    
    int serviceRating       = (price*0.40+
                               smoking*0.20
                               +category*0.10
                               +cuisine*0.10
                               +carPark*0.10
                               +liveMusic*0.10)+serviceRatingPenalty;
    
    int tangiblesRating     = (price*0.6
                               +garden*0.10
                               +carPark*0.20
                               +liveMusic*0.10)
    +tangiblesRatingPenalty;
    
    
    if (accessibilityRating > 10) {
        accessibilityRating = 10;
    }
    
    if (coreServiceRating >10) {
        coreServiceRating = 10;
    }
    
    if (personalRating >10) {
        personalRating = 10;
    }
    
    if (serviceRating >10) {
        serviceRating = 10;
    }
    
    if (tangiblesRating >10) {
        tangiblesRating= 10;
    }
    
    
    if (accessibilityRating < 1) {
        accessibilityRating = 1;
    }
    if (coreServiceRating <1) {
        coreServiceRating = 1;
    }
    if (personalRating  < 1) {
        personalRating = 1;
    }
    if (serviceRating < 1) {
        serviceRating = 1;
    }
    if (tangiblesRating < 1) {
        tangiblesRating= 1;
    }
    
    
    NSDictionary *returnDicitonary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:accessibilityRating],
                                                                          [NSNumber numberWithInt:coreServiceRating],
                                                                          [NSNumber numberWithInt:personalRating],
                                                                          [NSNumber numberWithInt:serviceRating],
                                                                          [NSNumber numberWithInt:tangiblesRating],nil]
                                                                 forKeys:[NSArray arrayWithObjects:kAccessibility,kCoreService,kPersonal,kService,kTangibles, nil]];
    return returnDicitonary;


}


-(NSDictionary*)getRatingForRestaurant:(Restaurant*)aRest ofAmbianceLoverUser:(User*)aUser{


    double childFriendly;
    double carPark;
    double smoking;
    double garden;
    double liveMusic;
    double category;
    double cuisine;
    double price;
    
    //    if ([aUser.stereotype isEqualToString:kFamily]) {
    childFriendly   = [[DataGenerationRulesRating sharedInstance] childFriendly:aRest ofUser:aUser];
    carPark         = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    smoking         = [[DataGenerationRulesRating sharedInstance] smokingFactor:aRest ofUser:aUser];
    garden          = [[DataGenerationRulesRating sharedInstance] gardenFactor :aRest ofUser:aUser];
    liveMusic       = [[DataGenerationRulesRating sharedInstance] liveMusicFactor:aRest ofUser:aUser];
    category        = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    cuisine         = [[DataGenerationRulesRating sharedInstance] cuisineFactor:aRest ofUser:aUser];
    price           = [[DataGenerationRulesRating sharedInstance] priceFactor:aRest ofUser:aUser];
    //    } else {
    
    //    }
    
    
    int accessibilityRatingPenalty = (arc4random() %(2));
    int coreServiceRatingPenalty = (arc4random() %(2));
    int personalRatingPenalty = (arc4random() %(2));
    int serviceRatingPenalty = (arc4random() %(2));
    int tangiblesRatingPenalty = (arc4random() %(2));
    
    int accessibilityRating = (price*0.20+
                               liveMusic*0.20
                               +childFriendly*0.10
                               +garden*0.30
                               +smoking*0.10
                               +carPark*0.10)+accessibilityRatingPenalty;
    
    int coreServiceRating   = (price*0.20+
                               +garden*0.30
                               +smoking*0.10
                               +category*0.10
                               +cuisine*0.10
                               +carPark*0.10
                               +liveMusic*0.10)+coreServiceRatingPenalty;
    
    
    int personalRating      = (price*0.20+
                               garden*0.20+
                               category*0.20+
                               cuisine*0.10+
                               carPark*0.10+
                               smoking*0.10+
                               liveMusic*0.10)+personalRatingPenalty;
    
    int serviceRating       = (price*0.20+
                               smoking*0.20
                               +category*0.10
                               +cuisine*0.10
                               +carPark*0.10
                               +garden*0.20
                               +liveMusic*0.10)+serviceRatingPenalty;
    
    int tangiblesRating     = (price*0.2
                               +garden*0.30
                               +carPark*0.10
                               +liveMusic*0.40)
    +tangiblesRatingPenalty;
    
    
    if (accessibilityRating > 10) {
        accessibilityRating = 10;
    }
    
    if (coreServiceRating >10) {
        coreServiceRating = 10;
    }
    
    if (personalRating >10) {
        personalRating = 10;
    }
    
    if (serviceRating >10) {
        serviceRating = 10;
    }
    
    if (tangiblesRating >10) {
        tangiblesRating= 10;
    }
    
    
    if (accessibilityRating < 1) {
        accessibilityRating = 1;
    }
    if (coreServiceRating <1) {
        coreServiceRating = 1;
    }
    if (personalRating  < 1) {
        personalRating = 1;
    }
    if (serviceRating < 1) {
        serviceRating = 1;
    }
    if (tangiblesRating < 1) {
        tangiblesRating= 1;
    }
    
    
    NSDictionary *returnDicitonary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:accessibilityRating],
                                                                          [NSNumber numberWithInt:coreServiceRating],
                                                                          [NSNumber numberWithInt:personalRating],
                                                                          [NSNumber numberWithInt:serviceRating],
                                                                          [NSNumber numberWithInt:tangiblesRating],nil]
                                                                 forKeys:[NSArray arrayWithObjects:kAccessibility,kCoreService,kPersonal,kService,kTangibles, nil]];
    return returnDicitonary;


}


-(NSDictionary*)getRatingForRestaurant:(Restaurant*)aRest ofTouristUser:(User*)aUser{


    double childFriendly;
    double carPark;
    double smoking;
    double garden;
    double liveMusic;
    double category;
    double cuisine;
    double price;
    
    //    if ([aUser.stereotype isEqualToString:kFamily]) {
    childFriendly   = [[DataGenerationRulesRating sharedInstance] childFriendly:aRest ofUser:aUser];
    carPark         = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    smoking         = [[DataGenerationRulesRating sharedInstance] smokingFactor:aRest ofUser:aUser];
    garden          = [[DataGenerationRulesRating sharedInstance] gardenFactor :aRest ofUser:aUser];
    liveMusic       = [[DataGenerationRulesRating sharedInstance] liveMusicFactor:aRest ofUser:aUser];
    category        = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    cuisine         = [[DataGenerationRulesRating sharedInstance] cuisineFactor:aRest ofUser:aUser];
    price           = [[DataGenerationRulesRating sharedInstance] priceFactor:aRest ofUser:aUser];
    //    } else {
    
    //    }
    
    
    int accessibilityRatingPenalty = (arc4random() %(4));
    int coreServiceRatingPenalty = (arc4random() %(3));
    int personalRatingPenalty = (arc4random() %(3));
    int serviceRatingPenalty = (arc4random() %(4));
    int tangiblesRatingPenalty = (arc4random() %(3));
    

    int accessibilityRating = (price*0.20+
                               cuisine*0.3+
                               category*0.2+
                               smoking*0.1
                               +childFriendly*0.10)+accessibilityRatingPenalty;
    
    int coreServiceRating   = (price*0.20+
                               +garden*0.10
                               +smoking*0.10
                               +category*0.20
                               +smoking*0.1
                               +cuisine*0.30)+coreServiceRatingPenalty;
    
    
    int personalRating      = (price*0.20+
                               garden*0.10+
                               category*0.30+
                               smoking*0.10+
                               cuisine*0.30)+personalRatingPenalty;
    
    int serviceRating       = (price*0.30+
                               +category*0.30
                               +cuisine*0.40)+serviceRatingPenalty;
    
    int tangiblesRating     = (price*0.2
                               +garden*0.20
                               +cuisine*0.30
                               +category*0.10
                               +liveMusic*0.20)+tangiblesRatingPenalty;

    /*
    int accessibilityRating = childFriendly;
    int coreServiceRating   = childFriendly;
    int personalRating      = childFriendly;
    int serviceRating       = childFriendly;
    int tangiblesRating     = childFriendly;
    */

    
    
    if (accessibilityRating > 10) {
        accessibilityRating = 10;
    }
    
    if (coreServiceRating >10) {
        coreServiceRating = 10;
    }
    
    if (personalRating >10) {
        personalRating = 10;
    }
    
    if (serviceRating >10) {
        serviceRating = 10;
    }
    
    if (tangiblesRating >10) {
        tangiblesRating= 10;
    }
    
    
    if (accessibilityRating < 1) {
        accessibilityRating = 1;
    }
    if (coreServiceRating <1) {
        coreServiceRating = 1;
    }
    if (personalRating  < 1) {
        personalRating = 1;
    }
    if (serviceRating < 1) {
        serviceRating = 1;
    }
    if (tangiblesRating < 1) {
        tangiblesRating= 1;
    }
    
    
    NSDictionary *returnDicitonary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:accessibilityRating],
                                                                          [NSNumber numberWithInt:coreServiceRating],
                                                                          [NSNumber numberWithInt:personalRating],
                                                                          [NSNumber numberWithInt:serviceRating],
                                                                          [NSNumber numberWithInt:tangiblesRating],nil]
                                                                 forKeys:[NSArray arrayWithObjects:kAccessibility,kCoreService,kPersonal,kService,kTangibles, nil]];
    return returnDicitonary;


}




-(NSDictionary*)ratingsForRestaruant:(Restaurant*)aRest ofUser:(User*)aUser
{
 
    if ([aUser.stereotype isEqualToString:kFamily]) {
        return  [self getRatingForRestaurant:aRest ofFamilyUser:aUser];
    }else if([aUser.stereotype isEqualToString:kStudent]){
        return  [self getRatingForRestaurant:aRest ofStudentUser:aUser];
    }else if ([aUser.stereotype isEqualToString:kTourist]){
        return [self getRatingForRestaurant:aRest ofTouristUser:aUser];
    }else{
        return  [self getRatingForRestaurant:aRest ofAmbianceLoverUser:aUser];
    }
}

-(double)cuisineFactor:(Restaurant*)aRest ofUser:(User*)aUser
{
    BOOL favoriteRest = NO;
    NSSet *favoriteSet;
    NSSet *cuisineSet = [NSSet setWithObject:aRest.cuisine];
    double favoriteRestvalue = 0;

    
    if ([aUser.stereotype isEqualToString:kStudent]) {
        favoriteSet = [NSSet setWithArray:favoriteStudentCuisines];
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteGourmetCuisines];
    }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteAmbianceLoverCuisines];
    }else if ([aUser.stereotype isEqualToString:kFamily]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteFamilyCuisines];
        
        NSUInteger position = [favoriteFamilyCuisines indexOfObject:aRest.cuisine];
        
        if (position!=NSNotFound) {
            if (position<3) {
                favoriteRestvalue = 10;
            } else if (position  < 5){
                favoriteRestvalue = 9;
            }else if (position  < 7){
                favoriteRestvalue = 8;
            }else if (position  < 7){
                favoriteRestvalue = 7;
            }else if (position  < 10){
                favoriteRestvalue = 6;
            }else if (position  < 14){
                favoriteRestvalue = 4;
            }else{
                favoriteRestvalue = 3;
            }
            
        }
        
    }else if ([aUser.stereotype isEqualToString:kTourist]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteTouriestCuisines];
    }else {
        favoriteSet = [[NSSet alloc] initWithArray:favoriteVegaterianCuisines];
    }
    

    if ([cuisineSet isSubsetOfSet:favoriteSet]) {
        favoriteRest = YES;
    }
    
    if (favoriteRest) {
        return 10;
    }else{
        return 5;
    }
    
}

-(double)categoryFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    BOOL favoriteRest = NO;
    NSSet *favoriteSet;
    NSSet *categorySet = [NSSet setWithObject:aRest.category];
    double favoriteRestvalue = 0;
    
    if ([aUser.stereotype isEqualToString:kStudent]) {
        favoriteSet = [NSSet setWithArray:favoriteStudentCategories];
        favoriteSet = [[NSSet alloc] initWithArray:favoriteStudentCategories];
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteGourmetCategories];
    }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteAmbianceLoverCategories];
    }else if ([aUser.stereotype isEqualToString:kFamily]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteFamilyCategories];
        NSUInteger position = [favoriteFamilyCategories indexOfObject:aRest.category];
        
        if (position!=NSNotFound) {
            if (position<2) {
            favoriteRestvalue = 10;
            } else if (position  < 4){
            favoriteRestvalue = 9;
            }else if (position  < 6){
            favoriteRestvalue = 8;
            }else if (position  < 8){
                favoriteRestvalue = 7;
            }else if (position  < 10){
                favoriteRestvalue = 6;
            }else if (position  < 12){
                favoriteRestvalue = 5;
            }else if (position  < 14){
                favoriteRestvalue = 4;
            }else if (position  < 15){
                favoriteRestvalue = 3;
            }else if (position  < 16){
                favoriteRestvalue = 2;
            }else if (position  < 17){
                favoriteRestvalue = 1;
            }else{
                favoriteRestvalue = 0;
            }
        
        }
        
    }else if ([aUser.stereotype isEqualToString:kTourist]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteTouriestCategories];
    }else {
        favoriteSet = [[NSSet alloc] initWithArray:favoriteVegaterianCategories];
    }
    
    
    
    if ([categorySet isSubsetOfSet:favoriteSet]) {
        favoriteRest = YES;
    }

    if (favoriteRest) {
        return 1;
    }else{
        return -2;
    }
    
}

#pragma mark - Attribute factors
-(double)priceFactor:(Restaurant*)aRest ofUser:(User*)aUser{

    double priceFactor = 0;

    //Price
    if ([aUser.stereotype isEqualToString:kStudent]) {
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 10;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor =9;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 7;
        }else{
            priceFactor = 3;
        }
        
        
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 0;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 8;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 9;
        }else {
            priceFactor = 10;
        }
        
        
    }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 7;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 8;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 10;
        }else {
            priceFactor = 11;
        }
        
    }else if ([aUser.stereotype isEqualToString:kFamily]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor     = 3;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor     = 8;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor     = 10;
        }else {
            priceFactor     = 7;
        }
    }else if ([aUser.stereotype isEqualToString:kTourist]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 8;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 10;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 9;
        }else {
            priceFactor = 5;
        }
        
    }else {
        priceFactor = 0;
    }

    return priceFactor;
}

-(double)childFriendly:(Restaurant*)aRest ofUser:(User*)aUser{

    double childFriendlyFactor = 0;
    
    if ([aRest.childFriendly isEqualToNumber:[NSNumber numberWithInt:0]]) {
    
        if ([aUser.stereotype isEqualToString:kFamily]) {

            if ([aUser.hasChild isEqualToNumber:[NSNumber numberWithInt:0]]) {
                childFriendlyFactor = 7;
            } else {
                childFriendlyFactor = 0;
            }
            
        }else if ([aUser.stereotype isEqualToString:kAmbianceLover] || [aUser.stereotype isEqualToString:kGourmet] || [aUser.stereotype isEqualToString:kStudent]){
            childFriendlyFactor = 10;
        }
        else
        {
            if ([aUser.hasChild isEqualToNumber:[NSNumber numberWithInt:0]]) {
                childFriendlyFactor = 10;
            } else {
                childFriendlyFactor = 8;
            }
        }
        
    }else{
    
        if ([aUser.stereotype isEqualToString:kFamily]) {
            

            if ([aUser.hasChild isEqualToNumber:[NSNumber numberWithInt:1]]) {
                childFriendlyFactor = 10;
            } else {
                childFriendlyFactor = 4;
            }
            
        }else if ([aUser.stereotype isEqualToString:kAmbianceLover] || [aUser.stereotype isEqualToString:kGourmet] || [aUser.stereotype isEqualToString:kStudent]){
            childFriendlyFactor = 0;
        }
        else if ([aUser.stereotype isEqualToString:kTourist])
        {
                childFriendlyFactor = 10;
        }else{
        
            if ([aUser.hasChild isEqualToNumber:[NSNumber numberWithInt:0]]) {
                childFriendlyFactor = 9;
            } else {
                childFriendlyFactor = 10;
            }
        }

    }
    return childFriendlyFactor;
}

-(double)gardenFactor:(Restaurant*)aRest ofUser:(User*)aUser{

    double gardenFactor = 0;

    if ([aUser.stereotype isEqualToString:kAmbianceLover]){
        
        if ([aRest.garden isEqualToNumber:[NSNumber numberWithInt:1]]) {
            
            gardenFactor = 11;
            
        }else{
            
            gardenFactor = 5;
            
        }
        
    }else{
        if ([aRest.garden isEqualToNumber:[NSNumber numberWithInt:1]]) {
            
            gardenFactor = 10;
            
        }else{
            
            gardenFactor = 8;
            
        }
    }
    return gardenFactor;
}



-(double)smokingFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    double smokingFactor = 0;
    
    
    if ([aUser.stereotype isEqualToString:kFamily]) {
        
        if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:0]]) {
            
            if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:1]]) {
                smokingFactor= 7;
            } else {
                smokingFactor = 10;
            }
            
        }else if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:1]]){
        
            if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:1]]) {
                smokingFactor= 10;
            } else {
                smokingFactor = 0;
            }
        
        }else{
            
                smokingFactor = 9;
        }
        
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
    
        if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:1]]) {
            
            smokingFactor = 0;
            
        }else if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:0]]){
            
            smokingFactor = 10;
            
        }else{
            
            smokingFactor = 6;
        }
    
    }else if ([aUser.stereotype isEqualToString:kTourist]){
        
        if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:1]]) {
            
            
            if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:1]]) {
                smokingFactor= 10;
            } else {
                smokingFactor = 5;
            }
            
        }else if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:0]]){
            
            
            if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:1]]) {
                smokingFactor= 7;
            } else {
                smokingFactor = 10;
            }
            
        }else{
            
            smokingFactor = 9;
        }
        
    }else
    {
        if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:0]]) {
            
            if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:1]]) {
                smokingFactor= 6;
            } else {
                smokingFactor = 10;
            }
            
        }else if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:1]]){
            
            if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:1]]) {
                smokingFactor= 10;
            } else {
                smokingFactor = 0;
            }
            
        }else{
            
            smokingFactor = 10;
        }

    }
    

    return smokingFactor;
}

-(double)liveMusicFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    double liveMusicFactor = 0;
    

    if ([aUser.stereotype isEqualToString:kFamily]) {
        
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:0]]) {
            liveMusicFactor = 8;
            
        }else{
            liveMusicFactor = 10;
        }
        
    }
    else if ([aUser.stereotype isEqualToString:kAmbianceLover]) {
        
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:0]]) {
            liveMusicFactor = 3;
            
        }else{
            liveMusicFactor = 10;
        }
        
    }else if ([aUser.stereotype isEqualToString:kTourist]) {
        
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:0]]) {
            liveMusicFactor = 9;
            
        }else{
            liveMusicFactor = 10;
        }
        
    }
    else
    {
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:1]]) {
            liveMusicFactor = 10;
            
        }else{
            liveMusicFactor = 6;
        }
    }
    
    
    return liveMusicFactor;
}

-(double)carParkFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    double carParkFactor = 0;
    
    
    if ([aUser.stereotype isEqualToString:kAmbianceLover]) {

        if ([aRest.carPark isEqualToNumber:[NSNumber numberWithInt:0]]) {
            
            if ([aUser.hasCar isEqualToNumber:[NSNumber numberWithInt:1]]) {
                carParkFactor= 0;
            } else {
                carParkFactor = 7;
            }
            
        }else{
            
            if ([aUser.hasCar isEqualToNumber:[NSNumber numberWithInt:0]]) {
                carParkFactor= 9;
            } else {
                carParkFactor = 10;
            }
        }
    
    }else  if ([aUser.stereotype isEqualToString:kTourist]) {
        
        if ([aRest.carPark isEqualToNumber:[NSNumber numberWithInt:0]]) {
            
            if ([aUser.hasCar isEqualToNumber:[NSNumber numberWithInt:1]]) {
                carParkFactor= 4;
            } else {
                carParkFactor = 10;
            }
            
        }else{
            
            if ([aUser.hasCar isEqualToNumber:[NSNumber numberWithInt:0]]) {
                carParkFactor = 10;
            }
        }
        
    }else{
    
        if ([aRest.carPark isEqualToNumber:[NSNumber numberWithInt:0]]) {
            
            if ([aUser.hasCar isEqualToNumber:[NSNumber numberWithInt:1]]) {
                carParkFactor= 4;
            } else {
                carParkFactor = 7;
            }
            
        }else{
            
            if ([aUser.hasCar isEqualToNumber:[NSNumber numberWithInt:0]]) {
                carParkFactor= 7;
            } else {
                carParkFactor = 10;
            }
        }
    }
    return carParkFactor;
}



@end
