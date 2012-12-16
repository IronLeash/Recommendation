//
//  RatingsManager.h
//  Recommendation
//
//  Created by ilker on 16.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface RatingsManager : NSObject
{

}
//Ratings
+(RatingsManager*)sharedInstance;

-(NSArray*)getRestaurantRatings;
-(NSArray*)getRestaurantRatingsForUser:(User*)aUser;
-(NSArray*)getPositiveRatingsforUser:(User*)aUser;
-(NSArray*)getFavoriteCategoriesForUser:(User*)currentUser;
-(NSArray*)getFavoriteCuisinesForUser:(User*)currentUser;
-(NSArray*)getFavoriteSmokingForUser:(User*)currentUser;
-(NSArray*)getFavoriteLocationForUser:(User*)currentUser;

@end
