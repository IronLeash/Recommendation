//
//  DataGenerationRulesUser.h
//  Recommendation
//
//  Created by ilker on 10.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataGenerationRulesUser : NSObject

+(int)userAgePredictionFor:(NSString*)userStereotype;

+(int)userGenderPredictionFor:(NSString*)userStereotype;

+(int)userLocationPredictionFor:(NSString*)userStereotype;

+(int)userSmokingPredictionFor:(NSString*)userStereotype;

+(int)userVegetarianPredictionFor:(NSString*)userStereotype;


@end
