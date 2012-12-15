//
//  DataGenerationRules.h
//  Recommendation
//
//  Created by ilker on 08.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataGenerationRulesRestaurant : NSObject



//Rules based on category

//Assings a Cuisine for a given gategory
+(NSString*)cuisineForCategory:(NSString*)aRestaurantCategory;

//Price
+(int)priceForCategory:(NSString*)aRestaurantCategory;
//Child Friendly
+(int)childFriendlyForCategory:(NSString*)aRestaurantCategory;
//Car Park
+(int)carParkForCategory:(NSString*)aRestaurantCategory;
//Garden
+(int)gardenForCategory:(NSString*)aRestaurantCategory;
//Live Music
+(int)liveMusicForCategory:(NSString*)aRestaurantCategory;

+(int)locationForCategory:(NSString*)aRestaurantCategory;
//Smoking
+(int)smokingForCategory:(NSString*)aRestaurantCategory;
//Vegaterian
+(int)vegetarianForCategory:(NSString*)aRestaurantCategory;


//Rules based on cuisine


@end
