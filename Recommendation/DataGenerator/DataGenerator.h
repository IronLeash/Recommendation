//
//  DataGenerator.h
//  Recommendation
//
//  Created by ilker on 18.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataGenerator : NSObject
{
//    NSManagedObjectContext *moc;

}
+(DataGenerator*)sharedInstance;


//Data generators
-(void)generateCusines;
-(void)generateCategories;

-(void)generateUserStereotypes;

-(void)generateUsers:(int)numberOfUsers;
-(void)generateRestaurants:(int)numberOfRestaurants;

-(void)generateRatings;



//Getters
-(NSArray*)getRestaurantCategories;
-(NSArray*)getRestaurantCuisines;
-(NSArray*)getRestaurants;
-(NSArray*)getUsers;

@end
