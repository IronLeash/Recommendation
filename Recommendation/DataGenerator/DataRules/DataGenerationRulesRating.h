//
//  DataGenerationRulesRating.h
//  Recommendation
//
//  Created by ilker on 10.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
#import "User.h"

@interface DataGenerationRulesRating : NSObject
{

}

-(NSDictionary*)ratingsForRestaruant:(Restaurant*)aRest ofUser:(User*)aUser;

-(double)priceFactor:(Restaurant*)aRest ofUser:(User*)aUser;
-(double)smokingFactor:(Restaurant*)aRest ofUser:(User*)aUser;
-(double)childFriendly:(Restaurant*)aRest ofUser:(User*)aUser;
-(double)gardenFactor:(Restaurant*)aRest ofUser:(User*)aUser;
-(double)liveMusicFactor:(Restaurant*)aRest ofUser:(User*)aUser;
-(double)carParkFactor:(Restaurant*)aRest ofUser:(User*)aUser;
-(double)categoryFacator:(Restaurant*)aRestCat ofUser:(User*)aUser;
-(double)cuisineFactor:(Restaurant*)aRestCuisine ofUser:(User*)aUser;

-(NSDictionary*)getRatingForRestaurant:(Restaurant*)aRest ofUser:(User*)aUser;

+(DataGenerationRulesRating*)sharedInstance;


@end
