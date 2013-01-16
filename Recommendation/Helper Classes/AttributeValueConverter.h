//
//  AttributeValueConverter.h
//  Recommendation
//
//  Created by ilker on 16.01.13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

#define BOOLREP(x)  (x)==1 ? @"YES" : @"NO";

@interface AttributeValueConverter : NSObject


+(NSString*)priceValueRepresentation:(NSNumber*)aNumber;

+(NSString*)smoingValueRepresentation:(NSNumber*)aNumber;


//Descriptions
+(NSString*)userDescription:(User*)anUser;
+(NSString*)userPreferencesDescription:(NSDictionary*)prefrencesDictionary;

@end
