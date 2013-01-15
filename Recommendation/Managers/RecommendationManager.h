//
//  RecommendationManager.h
//  Recommendation
//
//  Created by ilker on 28.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RestaurantRating.h"
#import "Restaurant.h"



NSString *recommendationArrayGeneratedNotification;

@interface RecommendationManager : NSObject
{
    User *currentUser;
    NSDictionary *userPreferencesDictionary;
    NSArray *recommendationResultsArray;
}

+(RecommendationManager*)sharedInstance;
-(NSArray*)getRecommendationForUser:(User*)anUser withPreferences:(NSDictionary*)preferences andWeight:(NSDictionary*)weights;

@end
