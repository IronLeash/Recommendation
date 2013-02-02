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
    
    double numberOfRatings;
    double numberOfUsers;
    double positiveRatingThreshold;
    
}

+(EvaluationManager*)sharedInstance;

-(double)calculateMSE;


@property (assign)     double rootMeanSquareError;
@property (assign)     double meanAbsoluteError;

@end
