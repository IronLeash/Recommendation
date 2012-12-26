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
        accessibilityRating = (arc4random() %(6))+5;
        coreServiceRating = (arc4random() %(6))+5;
        personalRating = (arc4random() %(7))+4;
        serviceRating = (arc4random() %(7))+4;
        tangiblesRating = (arc4random() %(7))+4;

    }

    double priceFactor          = [[DataGenerationRulesRating sharedInstance] priceFactor:aRest ofUser:aUser];
    double childFactor          = [[DataGenerationRulesRating sharedInstance] childFriendly:aRest ofUser:aUser];
    double gardenFactor         = [[DataGenerationRulesRating sharedInstance] gardenFactor:aRest ofUser:aUser];
    double vegaterianFactor     = [[DataGenerationRulesRating sharedInstance] vegaterianFactor:aRest ofUser:aUser];
    double liveMusicFactor      = [[DataGenerationRulesRating sharedInstance] liveMusicFactor:aRest ofUser:aUser];

#warning seperate garden factor from personal rating
    accessibilityRating *=(priceFactor*childFactor*gardenFactor*vegaterianFactor);
    coreServiceRating   *=(priceFactor*childFactor*gardenFactor*vegaterianFactor*liveMusicFactor);
    personalRating      *=(priceFactor*childFactor*gardenFactor*vegaterianFactor);
    serviceRating       *=(priceFactor*childFactor*gardenFactor*vegaterianFactor*liveMusicFactor);
    tangiblesRating     *=(priceFactor*childFactor*gardenFactor*vegaterianFactor*liveMusicFactor);
    
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



#pragma mark - Attribute factors
-(double)priceFactor:(Restaurant*)aRest ofUser:(User*)aUser{

    double priceFactor = 1;

    //Price
    if ([aUser.stereotype isEqualToString:kStudent]) {
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 1.3;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 1.1;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 0.8;
        }else {
            priceFactor = 0.7;
        }
        
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 0.6;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 0.8;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 1;
        }else {
            priceFactor = 1.2;
        }
        
    }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 0.7;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 0.9;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 1;
        }else {
            priceFactor = 1.2;
        }
        
    }else if ([aUser.stereotype isEqualToString:kFamily]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 1.2;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 1;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 0.9;
        }else {
            priceFactor = 0.8;
        }
    }else if ([aUser.stereotype isEqualToString:kTourist]){
        
        if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:0]]) {
            priceFactor = 1;
        } else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:1]]) {
            priceFactor = 1;
        }else if ([aRest.priceRange isEqualToNumber:[NSNumber numberWithInt:2]]) {
            priceFactor = 0.9;
        }else {
            priceFactor = 0.8;
        }
        
    }else {
        priceFactor = 1;
    }

    return priceFactor;
}

-(double)childFriendly:(Restaurant*)aRest ofUser:(User*)aUser{

    double childFriendlyFactor = 0;
    
    if ([aRest.childFriendly isEqualToNumber:[NSNumber numberWithInt:0]]) {
    
        if ([aUser.stereotype isEqualToString:kFamily]) {
            childFriendlyFactor = 0.3;
        }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
            childFriendlyFactor = 1.2;
        }else
        {
            childFriendlyFactor = 1;
        }
        
    }else{
    
        if ([aUser.stereotype isEqualToString:kFamily]) {
            childFriendlyFactor = 1.4;
        }else if ([aUser.stereotype isEqualToString:kGourmet] || [aUser.stereotype isEqualToString:kAmbianceLover]){
            childFriendlyFactor = 0.7;
        }else{
            childFriendlyFactor = 1;
        }

    }
    return childFriendlyFactor;
}

-(double)gardenFactor:(Restaurant*)aRest ofUser:(User*)aUser{

    double gardenFactor = 0;

    if ([aRest.garden isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        if ([aUser.stereotype isEqualToString:kFamily]) {
            gardenFactor = 1.2;
        }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
            gardenFactor = 1.1;
        }else
        {
            gardenFactor = 1;
        }
        
    }else{
        
        if ([aUser.stereotype isEqualToString:kFamily] || [aUser.stereotype isEqualToString:kAmbianceLover]) {
            gardenFactor = 0.9;
        }else{
            gardenFactor = 1;
        }
        
    }
    return gardenFactor;
}

-(double)vegaterianFactor:(Restaurant*)aRest ofUser:(User*)aUser{

    double vegaterianRating = 0;


    if ([aUser.vegaterian isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        if ([aRest.vegaterian isEqualToNumber:[NSNumber numberWithInt:1]]) {
            vegaterianRating = 1.3;
        }else{
            vegaterianRating = 1;
        }
        
    }else{
    
        if ([aRest.vegaterian isEqualToNumber:[NSNumber numberWithInt:0]]) {
            vegaterianRating = 1;
        }else{
            vegaterianRating = 0.6;
        }
    }
    
    return vegaterianRating;
}

-(double)liveMusicFactor:(Restaurant*)aRest ofUser:(User*)aUser{
    
    double liveMusicFactor = 0;
    
    //Live Music
    if ([aUser.stereotype isEqualToString:kStudent]) {
        
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            liveMusicFactor = 1.3;
        }else{

            liveMusicFactor = 1;
        }
        
    }else if ([aUser.stereotype isEqualToString:kGourmet]){
        
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            liveMusicFactor = 1.1;
        }else{
            
            liveMusicFactor = 1;
        }
        
    }else{
        if ([aRest.liveMusic isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            liveMusicFactor = 1.2;
        }else{
            
            liveMusicFactor = 1;
        }
    
    }
    
    return liveMusicFactor;
}




@end
