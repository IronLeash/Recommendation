//
//  DataGenerationRulesRating.m
//  Recommendation
//
//  Created by ilker on 10.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerationRulesRating.h"

@implementation DataGenerationRulesRating

static DataGenerationRulesRating* dataGenerationRulesRating = nil;


#pragma mark - Shared Instance
#pragma mark -
+(DataGenerationRulesRating*)sharedInstance;
{
	@synchronized([DataGenerationRulesRating class])
	{


        
		if (!dataGenerationRulesRating)
        {
            /*
            favoriteStudentCategories;
            NSSet *favoriteTouriestCategories;
            NSSet *favoriteGourmetCategories;
            NSSet *favoriteFamilyCategories;
            NSSet *favoriteAmbianceLoverCategories;
            */
            return [[self alloc] init];
        }else{
            return dataGenerationRulesRating;
        }
    }
    
	return nil;
}

-(NSDictionary*)ratingsForRestaruant:(Restaurant*)aRest ofUser:(User*)aUser
{

//Stereotype - consider favorite categories, potential cuisines
//Define favorite category sets for users
    
//Consider price
    
//Consider smoking

//Consider vegaterian etc

//consider location or not
    

    



}


@end
