//
//  DataGenerator.h
//  Recommendation
//
//  Created by ilker on 18.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Category.h"
#import "Cuisine.h"

NSString *ratingsGeneratedNotification;

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

//Generates ratings for a user
-(void)generateRatingForUser:(User*)aUser;;

@end
