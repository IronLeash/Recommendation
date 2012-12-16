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
#import "ListPopUpcontroller.h"

@interface RatingsView : NSObject <NSTabViewDelegate,NSTableViewDataSource>
{

    
    NSDictionary *entrophyDictionary;
    double carParkEntrophy;
    double categoryEntrophy;
    double ChildFriendlyEntrophy;
    double cuisineEntrophy;
    double gardenEntrophy;
    double liveMusicEntrophy;
    double locationEntrophy;
    double priceRangeEntrophy;
    double smokingEntrophy;
    double vegetarianEntrophy;
    
    
    
    NSMutableArray *usersArray;
    NSMutableArray *ratingsArray;
    NSMutableArray *weightedAverageArray;

    IBOutlet NSTableView *ratingsTableView;
    IBOutlet NSTableView *usersTableView;
    IBOutlet ListPopUpcontroller *listPopUpcontroller;

    __weak NSTextField *_categoryWeight;
    __weak NSTextField *_cuisineWeight;
    __weak NSTextField *_locationWeight;
    __weak NSTextField *_smokingWeight;
    __weak NSTextField *_priceRangeWeight;
    __weak NSTextField *_gardenWeight;
    __weak NSTextField *_liveMusicWeight;
    __weak NSTextField *_childFriendlyWeight;
    __weak NSTextField *_vegaterianWeight;
    
    __weak NSPopover *_listPopover;
    __weak NSTextField *_locationTextField;
    __weak NSTextField *_smoking;
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


-(IBAction)generateRecommendation:(id)sender;
-(IBAction)generateRatings:(id)sender;
-(IBAction)aRowIsSelected:(id)sender;
-(IBAction)checkBoxchangedValue:(id)sender;
-(IBAction)showListPopOver:(id)sender;



@property (weak) IBOutlet NSButton *onlyPositiveRatingscheckBox;
@property (weak) IBOutlet NSTextField *vegetarianTextfield;
@property (weak) IBOutlet NSTextField *childFriendlyTextfield;
@property (weak) IBOutlet NSTextField *liveMusicTextfield;
@property (weak) IBOutlet NSTextField *gardenTextField;


@property (weak) IBOutlet NSTextField *cuisineTextField;
@property (weak) IBOutlet NSTextField *categoryTextfield;
@property (weak) IBOutlet NSTextField *priceRange;
@property (weak) IBOutlet NSTextField *smoking;
@property (weak) IBOutlet NSTextField *locationTextField;
@property (weak) IBOutlet NSPopover *listPopover;
@property (weak) IBOutlet NSTextField *categoryWeight;
@property (weak) IBOutlet NSTextField *cuisineWeight;
@property (weak) IBOutlet NSTextField *locationWeight;
@property (weak) IBOutlet NSTextField *smokingWeight;
@property (weak) IBOutlet NSTextField *priceRangeWeight;
@property (weak) IBOutlet NSTextField *gardenWeight;
@property (weak) IBOutlet NSTextField *liveMusicWeight;
@property (weak) IBOutlet NSTextField *childFriendlyWeight;
@property (weak) IBOutlet NSTextField *vegaterianWeight;
@end
