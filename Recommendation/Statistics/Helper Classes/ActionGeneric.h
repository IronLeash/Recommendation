//
//  ActionGeneric.h
//  Recommendation
//
//  Created by ilker on 16.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionGeneric : NSObject

+(int)cuisinePosiitonInContigencyMatrix:(NSString*)attributeValue;

+(int)categoryPosiitonInContigencyMatrix:(NSString*)attributeValue;

+(NSMutableArray*)weightedAveraRatingsArrayForRatings:(NSArray*)ratingsArray;

+(NSDictionary*)restaurantAttributevaluesForRatings:(NSArray*)ratingsArray;

@end
