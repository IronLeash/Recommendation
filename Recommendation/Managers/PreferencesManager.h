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
    NSString *userId;
    NSDictionary *entrophyDictionary;
    NSDictionary *currentUserPreferenceWeight;
    NSDictionary *currentPreferencesDictionary;
    NSArray      *currentUserRatingsArray;
    
    double entrophyWeight;
    BOOL recalculateWeights;
}

@property(nonatomic)     double entrophyWeight;
@property(nonatomic)     BOOL recalculateWeights;

+(PreferencesManager*)sharedInstance;

//Setters
-(void)setEntrophyDictionary;

-(void)setUserPreferenceWeightDicitonary:(User*)currentUser;

//Getters

-(NSDictionary*)getEntrophyDictionary;

-(NSDictionary*)getUserPreferenceWeightDicitonary:(User*)currentUser;

-(NSDictionary*)getPreferencesDictionaryForUser:(User*)currentUser;

-(User*)getCurrentUser;

//Individual Preference Values;
-(double)getGardenOf:(User*)aUser;
-(double)getLiveMusic:(User*)aUser;
-(double)getChildFriendly:(User*)aUser;
-(double)getCarPark:(User*)aUser;
-(double)getVegaterian:(User*)aUser;


//Helper
-(NSArray*)contingencyMatrixForAttribute:(NSString*)anAttribute;

-(NSMutableArray*)contingencyMatrixForAttribute:(NSString*)anAttribute OfUser:(User*)aUser;


@end
