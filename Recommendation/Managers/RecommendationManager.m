//
//  RecommendationManager.m
//  Recommendation
//
//  Created by ilker on 28.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "RecommendationManager.h"

static RecommendationManager *recommendationManager;

@implementation RecommendationManager

+(RecommendationManager*)sharedInstance{
    @synchronized(self)
    {
        if (recommendationManager==nil)
        {
            recommendationManager = [[self alloc] init];
        }
        return recommendationManager;
    }
}

-(id)init{

	self = [super init];
	if (self != nil) {

	}
    
	return self;
}

@end
