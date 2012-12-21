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
    NSManagedObjectContext *ratingsMoC;
    User *currentUser;
    NSMutableArray *posiviteUserRatings;
    NSMutableArray *currentUserRatings;
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

-(void)cleanUp;

@end
