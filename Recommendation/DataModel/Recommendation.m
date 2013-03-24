//
//  Recommendation.m
//  Recommendation
//
//  Created by ilker on 29.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "Recommendation.h"

@implementation Recommendation

@synthesize distance;
@synthesize restaurant;
@synthesize rating;
@synthesize realRating;
@synthesize difference;
@synthesize realRanking;

@synthesize recommendationClass;

-(NSString*)description
{
    return [NSString stringWithFormat:@"Restaurant %@ Rating %f",restaurant,distance];
}

@end
