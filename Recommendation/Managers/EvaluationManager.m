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

@synthesize positiveRatingThreshold;

static EvaluationManager *evaluationManager;

+(EvaluationManager*)sharedInstance{

    @synchronized(evaluationManager){

        if (!evaluationManager) {
            evaluationManager  =[[self alloc] init];
        }
    
        return evaluationManager;
    }
}


-(id)init{

    self = [super init];
    if (self) {
        self.positiveRatingThreshold = 7.0;
    }
return self;
}


-(double)calculateMSE{

    NSArray *usersArray = [[DataFetcher sharedInstance] getUsers];
    double mse = 0;
    double localAbsoluteMeanError = 0;

    
    numberOfTruePositiveRatings = 0;
    numberOfTrueNegativeRatings = 0;
    
    numberOfFalseNegativeRatings = 0;
    numberOfFalsePositiveRatings = 0;
    numberOfRatings = 0;
    
    for (User *currentUser in usersArray)
    {
    
        NSDictionary *preferencesDictionary = [[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:currentUser];
        NSDictionary *weightsDictionary = [[PreferencesManager sharedInstance] getUserPreferenceWeightDicitonary:currentUser];
        
        NSArray *restaurantRatingPredictionArray = [[RecommendationManager sharedInstance] getRecommendationForUser:currentUser
                                                                                           withPreferences:preferencesDictionary
                                                                                                 andWeight:weightsDictionary onlyPosiiveRatings:NO];
        
        numberOfRatings += [restaurantRatingPredictionArray count];

        for (Recommendation *currentRestaurntReccomendation in restaurantRatingPredictionArray) {
            
            double squaredDifference = pow(currentRestaurntReccomendation.difference, 2);
            double absoluteDifference = ABS(currentRestaurntReccomendation.difference);
            
            
            if (currentRestaurntReccomendation.realRating >= self.positiveRatingThreshold && currentRestaurntReccomendation.rating >= self.positiveRatingThreshold) {
                numberOfTruePositiveRatings++;
            }else if (currentRestaurntReccomendation.realRating < self.positiveRatingThreshold && currentRestaurntReccomendation.rating < self.positiveRatingThreshold){
                numberOfTrueNegativeRatings++;
            }else if (currentRestaurntReccomendation.realRating < self.positiveRatingThreshold && currentRestaurntReccomendation.rating >= self.positiveRatingThreshold){
                numberOfFalsePositiveRatings++;
            }else{
                numberOfFalseNegativeRatings++;
            }
            
            mse                     +=squaredDifference;
            localAbsoluteMeanError  +=absoluteDifference;
        }
    
        NSLog(@"Number Of Ratings-------------------------------------------- %d",numberOfRatings);
        NSLog(@"Positive rating threshold   %f",positiveRatingThreshold);
        NSLog(@"numberOfTruePositiveRatings %d",numberOfTruePositiveRatings);
        NSLog(@"numberOfTrueNegativeRatings %d",numberOfTrueNegativeRatings);
        NSLog(@"numberOfFalsePositiveRatings %d",numberOfFalsePositiveRatings);
        NSLog(@"numberOfFalseNegativeRatings %d",numberOfFalseNegativeRatings);
        NSLog(@"------------------------------------------------------------- Presicion %f",(float)numberOfTruePositiveRatings/(numberOfTruePositiveRatings+numberOfFalsePositiveRatings));
        NSLog(@"------------------------------------------------------------- Recall %f",(float)numberOfTruePositiveRatings/(numberOfTruePositiveRatings+numberOfFalseNegativeRatings));
        NSLog(@"------------------------------------------------------------- False Positive Rate %f",(float)numberOfFalsePositiveRatings/(numberOfFalsePositiveRatings+numberOfFalseNegativeRatings)
              );

    }
    mse = mse/numberOfRatings;
    mse = sqrt(mse);
    
    localAbsoluteMeanError = localAbsoluteMeanError/numberOfRatings;
    localAbsoluteMeanError = sqrt(localAbsoluteMeanError);
    
    self.rootMeanSquareError = mse;
    self.meanAbsoluteError = localAbsoluteMeanError;
    
    return mse;
}

@end
