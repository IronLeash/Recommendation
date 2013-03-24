//
//  EvaluationManager.h
//  Recommendation
//
//  Created by ilker on 02.02.13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationManager : NSObject
{
    double rootMeanSquareError;
    double meanAbsoluteError;

    double precision;
    //true positive rate
    double recall;
    //false positive rate
    double falsePosiitveRate;
    
    int numberOfRatings;
    int numberOfUsers;
    
    int numberOfTruePositiveRatings;
    int numberOfTrueNegativeRatings;

    int numberOfFalseNegativeRatings;
    int numberOfFalsePositiveRatings;
    
    double positiveRatingThreshold;
    double recommendationRelevanceRatio;
    
}

+(EvaluationManager*)sharedInstance;

-(double)calculateMSE;
-(double)calculateRMSE;

-(double)calculatePresicion;
-(double)calculateRecall;

-(double)calculateNDPM;



@property (assign)     double rootMeanSquareError;
@property (assign)     double meanAbsoluteError;

@property (assign)     double positiveRatingThreshold;
@property (assign)     double recommendationRelevanceRatio;

@end
