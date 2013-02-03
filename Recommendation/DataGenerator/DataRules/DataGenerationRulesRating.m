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



-(NSDictionary*)ratingsForRestaruant:(Restaurant*)aRest ofUser:(User*)aUser
{
    
#warning extend with dislikes

    int accessibilityRating = (arc4random() %(10))+1;
    int coreServiceRating = (arc4random() %(10))+1;
    int personalRating = (arc4random() %(10))+1;
    int serviceRating = (arc4random() %(10))+1;
    int tangiblesRating = (arc4random() %(10))+1;
    
    double categoryFactor       = [[DataGenerationRulesRating sharedInstance] categoryFactor:aRest ofUser:aUser];
    double cuisineFactor        = [[DataGenerationRulesRating sharedInstance] cuisineFactor:aRest ofUser:aUser];
    double priceFactor          = [[DataGenerationRulesRating sharedInstance] priceFactor:aRest ofUser:aUser];
    double childFactor          = [[DataGenerationRulesRating sharedInstance] childFriendly:aRest ofUser:aUser];
    double gardenFactor         = [[DataGenerationRulesRating sharedInstance] gardenFactor:aRest ofUser:aUser];
    double smokingfactor        = [[DataGenerationRulesRating sharedInstance] smokingFactor:aRest ofUser:aUser];
    double carParkfactor        = [[DataGenerationRulesRating sharedInstance] carParkFactor:aRest ofUser:aUser];
    double liveMusicFactor      = [[DataGenerationRulesRating sharedInstance] liveMusicFactor:aRest ofUser:aUser];
    
    
    if (categoryFactor>0 && cuisineFactor >0) {
        accessibilityRating = (arc4random() %(5))+6;
        coreServiceRating = (arc4random() %(5))+6;
        personalRating = (arc4random() %(5))+6;
        serviceRating = (arc4random() %(5))+6;
        tangiblesRating = (arc4random() %(5))+6;
    }else if (categoryFactor < 0 || cuisineFactor < 0){

        accessibilityRating = (arc4random() %(7))+5;
        coreServiceRating = (arc4random() %(6))+5;
        personalRating = (arc4random() %(6))+5;
        serviceRating = (arc4random() %(6))+5;
        tangiblesRating = (arc4random() %(6))+5;
    }else{
        accessibilityRating = (arc4random() %(7))+1;
        coreServiceRating = (arc4random() %(7))+1;
        personalRating = (arc4random() %(7))+1;
        serviceRating = (arc4random() %(7))+1;
        tangiblesRating = (arc4random() %(7))+1;
    }
    

    


#warning seperate garden factor from personal rating
    
    
    double totalShot = priceFactor+childFactor+gardenFactor+smokingfactor+carParkfactor+liveMusicFactor;
    
//    accessibilityRating +=(priceFactor+childFactor*gardenFactor+smokingfactor);
//    coreServiceRating   +=(priceFactor+childFactor*gardenFactor+liveMusicFactor);
//    personalRating      +=(priceFactor+childFactor*gardenFactor+smokingfactor);
//    serviceRating       +=(priceFactor+childFactor+gardenFactor+liveMusicFactor);
//    tangiblesRating     +=(priceFactor+childFactor+gardenFactor+liveMusicFactor);
    
    accessibilityRating +=totalShot;
    coreServiceRating   +=totalShot;
    personalRating      +=totalShot;
    serviceRating       +=totalShot;
    tangiblesRating     +=totalShot;
    
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
    

#warning consider following
//Stereotype - consider favorite categories, potential cuisines

//Assign has car
//assign has child
//consider location
//consider location or not
//Limit maximum deviation between highes and lowest rating
    
    return returnDicitonary;

}

-(double)cuisineFactor:(Restaurant*)aRest ofUser:(User*)aUser
{
    BOOL favoriteRest = NO;
    NSSet *favoriteSet;
    NSSet *cuisineSet = [NSSet setWithObject:aRest.cuisine];
    
    
    if ([aUser.stereotype isEqualToString:kStudent]) {
        favoriteSet = [NSSet setWithArray:favoriteStudentCuisines];
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteGourmetCuisines];
    }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteAmbianceLoverCuisines];
    }else if ([aUser.stereotype isEqualToString:kFamily]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteFamilyCuisines];
    }else if ([aUser.stereotype isEqualToString:kTourist]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteTouriestCuisines];
    }else {
        favoriteSet = [[NSSet alloc] initWithArray:favoriteVegaterianCuisines];
    }
    

    if ([cuisineSet isSubsetOfSet:favoriteSet]) {
        favoriteRest = YES;
    }
    
    if (favoriteRest) {
        return 1;
    }else{
        return -2;
    }
    
}

-(double)categoryFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    BOOL favoriteRest = NO;
    NSSet *favoriteSet;
    NSSet *categorySet = [NSSet setWithObject:aRest.category];
    
    
    if ([aUser.stereotype isEqualToString:kStudent]) {
        favoriteSet = [NSSet setWithArray:favoriteStudentCategories];
        favoriteSet = [[NSSet alloc] initWithArray:favoriteStudentCategories];
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteGourmetCategories];
    }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteAmbianceLoverCategories];
    }else if ([aUser.stereotype isEqualToString:kFamily]){
        favoriteSet = [[NSSet alloc] initWithArray:favoriteFamilyCategories];
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
            priceFactor = 1;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 0;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = -1;
        }else{
            priceFactor = -1.5;
        }
        
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = -0.5;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = -0.2;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 1;
        }else {
            priceFactor = 1.5;
        }
        
    }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = -0.5;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 0;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 0.5;
        }else {
            priceFactor = 1;
        }
        
    }else if ([aUser.stereotype isEqualToString:kFamily]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 0.5;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 0.25;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = -0.75;
        }else {
            priceFactor = -1;
        }
    }else if ([aUser.stereotype isEqualToString:kTourist]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 1;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 0;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = -0.5;
        }else {
            priceFactor = -1;
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
            childFriendlyFactor = -1;
        }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
            childFriendlyFactor = 0.25;
        }else
        {
            childFriendlyFactor = 0;
        }
        
    }else{
    
        if ([aUser.stereotype isEqualToString:kFamily]) {
            childFriendlyFactor = +2;
        }else if ([aUser.stereotype isEqualToString:kGourmet] || [aUser.stereotype isEqualToString:kAmbianceLover]){
            childFriendlyFactor = -1;
        }else{
            childFriendlyFactor = 0;
        }

    }
    return childFriendlyFactor;
}

-(double)gardenFactor:(Restaurant*)aRest ofUser:(User*)aUser{

    double gardenFactor = 0;

    if ([aRest.garden isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        gardenFactor = 1;
        
    }else{
        
        gardenFactor = -0.25;
        
    }
    return gardenFactor;
}



-(double)smokingFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    double smokingFactor = 0;
    
    if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:0]]) {
        
        if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:0]]) {
            smokingFactor = 1;
        }else{
            smokingFactor = -2;
        }
        
    }else if ([aRest.smoking isEqualToNumber:[NSNumber numberWithInt:1]]){
        
        if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:0]]) {

            smokingFactor = 0;
        }else{
            smokingFactor = 2;
        }
        
    
    }else{
        
        if ([aUser.smoker isEqualToNumber:[NSNumber numberWithInt:0]]) {
            smokingFactor = 0.25;
        }else{
            smokingFactor = 0.5;
        }
    
    }
    
    return smokingFactor;
}

-(double)liveMusicFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    double liveMusicFactor = 0;
    
    //Live Music
    if ([aUser.stereotype isEqualToString:kStudent]) {
        
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            liveMusicFactor = 1;
        }else{

            liveMusicFactor = 0;
        }
        
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            liveMusicFactor = 0.25;
        }else{
            
            liveMusicFactor = 0;
        }
        
    }else{
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            liveMusicFactor = 0.5;
        }else{
            
            liveMusicFactor = -0.35;
        }
    
    }
    
    return liveMusicFactor;
}

-(double)carParkFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    double carParkFactor = 0;
    
    if ([aRest.carPark isEqualToNumber:[NSNumber numberWithInt:0]]) {
        
        if ([aUser.stereotype isEqualToString:kFamily] ||[aUser.stereotype isEqualToString:kGourmet]) {
            carParkFactor = -1;
        }else
        {
            carParkFactor = 0;
        }
        
    }else{
        
        if ([aUser.stereotype isEqualToString:kFamily] ||[aUser.stereotype isEqualToString:kGourmet]) {
            carParkFactor = 1;
        }else
        {
            carParkFactor = 0.25;
        }
        
    }
    return carParkFactor;
}



@end
