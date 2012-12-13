//
//  DataGenerationRulesRating.h
//  Recommendation
//
//  Created by ilker on 10.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
#import "User.h"

@interface DataGenerationRulesRating : NSObject
{
    /*
    NSSet *favoriteStudentCategories;
    NSSet *favoriteTouriestCategories;
    NSSet *favoriteGourmetCategories;
    NSSet *favoriteFamilyCategories;
    NSSet *favoriteAmbianceLoverCategories;
    */
}

-(NSDictionary*)ratingsForRestaruant:(Restaurant*)aRest ofUser:(User*)aUser;

+(DataGenerationRulesRating*)sharedInstance;


@end
