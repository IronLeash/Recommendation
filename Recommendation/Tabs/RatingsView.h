//
//  RatingsView.h
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Restaurant.h"

@interface RatingsView : NSObject <NSTabViewDelegate,NSTableViewDataSource>
{

    NSMutableArray *usersArray;
    NSMutableArray *ratingsArray;
    NSMutableArray *weightedAverageArray;

    IBOutlet NSTableView *ratingsTableView;
    IBOutlet NSTableView *usersTableView;


    __weak NSTextField *_priceRange;
    __weak NSTextField *_categoryTextfield;
    __weak NSTextField *_cuisineTextField;
    __weak NSTextField *_gardenTextField;
    __weak NSTextField *_liveMusicTextfield;
    __weak NSTextField *_childFriendlyTextfield;
    __weak NSTextField *_vegetarianTextfield;
    
    __weak NSButton *_onlyPositiveRatingscheckBox;
    User *currentlySelectedUser;
    
    NSMutableDictionary *preferencesDictionary;
}


-(IBAction)generateRatings:(id)sender;
-(IBAction)aRowIsSelected:(id)sender;
-(IBAction)checkBoxchangedValue:(id)sender;


@property (weak) IBOutlet NSButton *onlyPositiveRatingscheckBox;
@property (weak) IBOutlet NSTextField *vegetarianTextfield;
@property (weak) IBOutlet NSTextField *childFriendlyTextfield;
@property (weak) IBOutlet NSTextField *liveMusicTextfield;
@property (weak) IBOutlet NSTextField *gardenTextField;


@property (weak) IBOutlet NSTextField *cuisineTextField;
@property (weak) IBOutlet NSTextField *categoryTextfield;
@property (weak) IBOutlet NSTextField *priceRange;
@end
