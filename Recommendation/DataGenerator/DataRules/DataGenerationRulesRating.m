//
//  DataGenerationRulesRating.m
//  Recommendation
//
//  Created by ilker on 10.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerationRulesRating.h"
#import "DataFetcher.h"

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
	@synchronized([DataGenerationRulesRating class])
	{

		if (!dataGenerationRulesRating)
        {

            favoriteStudentCategories = [[NSArray alloc] initWithArray:[[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kStudent]];

            favoriteTouriestCategories = [[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kTourist];
            favoriteGourmetCategories = [[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kGourmet];
            favoriteFamilyCategories = [[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kFamily];
            favoriteAmbianceLoverCategories = [[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kAmbianceLover] ;
            favoriteVegaterianCategories = [[DataFetcher sharedInstance] getFavoriteCagetoriesForStereotype:kVegaterian];
            
            
            dataGenerationRulesRating = [[self alloc] init];
            return dataGenerationRulesRating;
        }else{
            return dataGenerationRulesRating;
        }
    }
    
	return nil;
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
    NSSet *categorySet = [NSSet setWithObject:aRest.categories];
    
    
    if ([aUser.stereotype isEqualToString:kStudent]) {
        favoriteSet = [[NSSet alloc] initWithArray:favoriteStudentCategories];

    }else if ([aUser.stereotype isEqualToString:kGourmet]){
//        favoriteSet = [[NSSet alloc] initWithSet:favoriteGourmetCategories];
    }else if ([aUser.stereotype isEqualToString:kAmbianceLover]){
//        favoriteSet = [[NSSet alloc] initWithSet:favoriteAmbianceLoverCategories];        
    }else if ([aUser.stereotype isEqualToString:kFamily]){
//        favoriteSet = [[NSSet alloc] initWithSet:favoriteFamilyCategories]; 
    }else if ([aUser.stereotype isEqualToString:kTourist]){
//        favoriteSet = [[NSSet alloc] initWithSet:favoriteVegaterianCategories];
    }else {
//        favoriteSet = [[NSSet alloc] initWithSet:favoriteVegaterianCategories];
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
    
    
    
    
    NSDictionary *returnDicitonary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:accessibilityRating],
                                                                                                    [NSNumber numberWithInt:coreServiceRating],
                                                                                                    [NSNumber numberWithInt:personalRating],
                                                                                                    [NSNumber numberWithInt:serviceRating],
                                                                                                    [NSNumber numberWithInt:tangiblesRating],nil]
                                                                 forKeys:[NSArray arrayWithObjects:kAccessibility,kCoreService,kPersonal,kService,kTangibles, nil]];
    

#warning consider following
//Stereotype - consider favorite categories, potential cuisines

//Consider price
    
//Consider smoking

//Consider vegaterian etc

//consider location or not
    
//Limit maximum deviation between highes and lowest rating
    
    
    return returnDicitonary;

}


@end
