//
//  DataGenerationRules.h
//  Recommendation
//
//  Created by ilker on 08.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Category.h"
#import "Cuisine.h"
@interface DataGenerationRulesRestaurant : NSObject



//Rules based on category

//Assings a Cuisine for a given gategory
+(Cuisine*)cuisineForCategory:(Category*)aRestaurantCategory;

//Price
+(int)priceForCategory:(Category*)aRestaurantCategory;
//Child Friendly
+(int)childFriendlyForCategory:(Category*)aRestaurantCategory;
//Car Park
+(int)carParkForCategory:(Category*)aRestaurantCategory;
//Garden
+(int)gardenForCategory:(Category*)aRestaurantCategory;
//Live Music
+(int)liveMusicForCategory:(Category*)aRestaurantCategory;

+(int)locationForCategory:(Category*)aRestaurantCategory;
//Smoking
+(int)smokingForCategory:(Category*)aRestaurantCategory;
//Vegaterian
+(int)vegetarianForCategory:(Category*)aRestaurantCategory;


//Rules based on cuisine


@end
