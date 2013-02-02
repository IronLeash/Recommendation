//
//  EvaluationManager.m
//  Recommendation
//
//  Created by ilker on 02.02.13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import "EvaluationManager.h"
#import "RecommendationManager.h"
#import "PreferencesManager.h"

#import "DataFetcher.h"

#import "User.h"

#import "RestaurantRating.h"

#import "Recommendation.h"

@implementation EvaluationManager

@synthesize meanAbsoluteError;
@synthesize rootMeanSquareError;

static EvaluationManager *evaluationManager;

+(EvaluationManager*)sharedInstance{

    @synchronized(evaluationManager){

        if (!evaluationManager) {
            evaluationManager  =[[self alloc] init];
        }
    
        return evaluationManager;
    }
}


-(double)calculateMSE{

    NSArray *usersArray = [[DataFetcher sharedInstance] getUsers];
    double mse = 0;
    double localAbsoluteMeanError = 0;
    double totalRatings = 0;
    
    
    for (User *currentUser in usersArray)
    {
    
        NSDictionary *preferencesDictionary = [[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:currentUser];
        NSDictionary *weightsDictionary = [[PreferencesManager sharedInstance] getUserPreferenceWeightDicitonary:currentUser];
        
        NSArray *restaurantRatingPredictionArray = [[RecommendationManager sharedInstance] getRecommendationForUser:currentUser
                                                                                           withPreferences:preferencesDictionary
                                                                                                 andWeight:weightsDictionary onlyPosiiveRatings:NO];
        
        totalRatings += [restaurantRatingPredictionArray count];

        for (Recommendation *currentRestaurntReccomendation in restaurantRatingPredictionArray) {
            
            double squaredDifference = pow(currentRestaurntReccomendation.difference, 2);
            double absoluteDifference = ABS(currentRestaurntReccomendation.difference);
            
            mse                     +=squaredDifference;
            localAbsoluteMeanError  +=absoluteDifference;
        }

//        NSLog(@"Current difference %f",difference);

    }
    mse = mse/totalRatings;
    mse = sqrt(mse);
    
    localAbsoluteMeanError = localAbsoluteMeanError/totalRatings;
    localAbsoluteMeanError = sqrt(localAbsoluteMeanError);
    
    self.rootMeanSquareError = mse;
    self.meanAbsoluteError = localAbsoluteMeanError;
    
    return mse;
}

@end
