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
    NSArray      *currentUserRatingsArray;
}



+(PreferencesManager*)sharedInstance;

//Setters
-(void)setEntrophyDictionary;

-(void)setUserPreferenceWeightDicitonary:(User*)currentUser;

//Getters

-(NSDictionary*)getEntrophyDictionary;

-(NSDictionary*)getUserPreferenceWeightDicitonary:(User*)currentUser;

-(NSDictionary*)getPreferencesDictionaryForUser:(User*)currentUser;

//Helper
-(NSArray*)contingencyMatrixForAttribute:(NSString*)anAttribute;

-(NSMutableArray*)contingencyMatrixForAttribute:(NSString*)anAttribute OfUser:(User*)aUser;


@end