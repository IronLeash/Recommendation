//
//  Recommendation.h
//  Recommendation
//
//  Created by ilker on 29.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"



typedef enum{
    truePositive,
    falsePositive,
    falseNegative,
    trueNagative
}RecommendationClass;


@interface Recommendation : NSObject
{

}

@property (strong,nonatomic)     Restaurant *restaurant;
@property (assign)               double distance;
@property (assign)               double rating;

@property (assign)               double realRating;
@property (assign)               double ranking;

@property (assign)               double difference;
@property (assign)               NSInteger realRanking;
@property (assign)               RecommendationClass recommendationClass;

@end
