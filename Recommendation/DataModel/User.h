//
//  User.h
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RatingWeight, UserPreference, UserPreferenceWeight;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * location;
@property (nonatomic, retain) NSNumber * smoker;
@property (nonatomic, retain) NSString * stereotype;
@property (nonatomic, retain) NSNumber * vegeterian;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) UserPreference *preference;
@property (nonatomic, retain) UserPreferenceWeight *userPrerefenceWeight;
@property (nonatomic, retain) RatingWeight *ratingWeight;

@end
