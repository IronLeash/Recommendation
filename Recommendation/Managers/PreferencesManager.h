//
//  PreferencesManager.h
//  Recommendation
//
//  Created by Ilker Baltaci on 12/14/12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface PreferencesManager : NSObject
{

    User *currentUser;

    NSDictionary *entrophyDictionary;
    NSDictionary *currentUserPreferenceWeight;

}


//Setters
-(void)setEntrophyDictionary:(NSDictionary*)entropyDicitonary;

-(void)setUserPreferenceWeightDicitonary:(User*)currentUser;


//Getters

-(NSDictionary*)getEntrophyDictionary:(User*)currentUser;

-(NSDictionary*)getUserPreferenceWeightDicitonary:(User*)currentUser;


@end
