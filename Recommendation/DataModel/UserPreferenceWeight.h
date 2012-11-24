//
//  UserPreferenceWeight.h
//  Recommendation
//
//  Created by ilker on 20.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface UserPreferenceWeight : NSManagedObject

@property (nonatomic, retain) NSNumber * carPark;
@property (nonatomic, retain) NSNumber * category;
@property (nonatomic, retain) NSNumber * childFriendly;
@property (nonatomic, retain) NSNumber * cuisine;
@property (nonatomic, retain) NSNumber * garden;
@property (nonatomic, retain) NSNumber * liveMusic;
@property (nonatomic, retain) NSNumber * location;
@property (nonatomic, retain) NSNumber * priceRange;
@property (nonatomic, retain) NSNumber * smoking;
@property (nonatomic, retain) NSNumber * vegeterian;
@property (nonatomic, retain) User *user;

@end
