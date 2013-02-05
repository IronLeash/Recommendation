//
//  DataGenerationRulesUser.h
//  Recommendation
//
//  Created by ilker on 10.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataGenerationRulesUser : NSObject

+(int)userSmokingPredictionFor:(NSString*)userStereotype;

+(int)userHasCar:(NSString*)userStereotype;

+(int)userHasChild:(NSString*)userStereotype;

@end
