//
//  RatingsView.m
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "RatingsView.h"
#import "DataGenerator.h"
#import "DataGenerationRulesRating.h"

#import "PreferencesManager.h"
#import "RecommendationManager.h"

#import "DataFetcher.h"

#import "User.h"
#import "RatingWeight.h"
#import "Restaurant.h"
#import "RestaurantRating.h"
#import "StatisticsLibrary.h"
#import "Constants.h"
#import "AppDelegate.h"

#import "RatingsManager.h"

@implementation RatingsView

NSString *userSelectedNotification = @"aUserSelectedNotificaiton";

-(id)init
{
    
    self  = [super init];
    if (self) {
        usersArray = [[NSMutableArray alloc]init];
        ratingsArray = [[NSMutableArray alloc] init];
        weightedAverageArray = [[NSMutableArray alloc]  init];
        preferencesDictionary = [[NSMutableDictionary alloc] init];
        listPopUpcontroller = [[ListPopUpcontroller alloc] init];
    }
    
    return self;
}

-(void)awakeFromNib{
    usersArray = [NSMutableArray arrayWithArray:[[DataFetcher sharedInstance] getUsers]];
    ratingsArray = [NSMutableArray arrayWithArray:[[RatingsManager sharedInstance] getRestaurantRatings]];
    entrophyDictionary = [[PreferencesManager sharedInstance] getEntrophyDictionary];
    
    [_categoryTextfield setSelectable:NO];
    [_categoryTextfield setEditable:NO];
    [_gardenTextField setEditable:NO];
    [_liveMusicTextfield setEditable:NO];
    [_childFriendlyTextfield setEditable:NO];
    [_vegetarianTextfield setEditable:NO];
        
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateRatingsTable:)
                                                 name:ratingsGeneratedNotification
                                               object:nil];
    
}

#pragma mark = Notifications

-(void)updateRatingsTable:(NSNotification*)aNptification{
    usersArray = [NSMutableArray arrayWithArray:[[DataFetcher sharedInstance] getUsers]];
    ratingsArray = [NSMutableArray arrayWithArray:[[RatingsManager sharedInstance] getRestaurantRatings]];
    [usersTableView reloadData];
    [ratingsTableView reloadData];
}

#pragma mark - Custom Methods

-(IBAction)aRowIsSelected:(id)sender{
    
    


    NSLog(@"Selected row %ld",[usersTableView selectedRow]);
    
    currentlySelectedUser = [usersArray objectAtIndex:[usersTableView selectedRow]];
    
    //Change preferences
    preferencesDictionary = [NSMutableDictionary dictionaryWithDictionary: [[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:currentlySelectedUser]];
    
    //Change weights
    preferencesWeightDictionary = [NSMutableDictionary dictionaryWithDictionary:
                                   [[PreferencesManager sharedInstance] getUserPreferenceWeightDicitonary:currentlySelectedUser]];

    FavoriteCategory *favoriteCategory      = [[preferencesDictionary objectForKey:kCategory] objectAtIndex:0];
    FavoriteCategory *favoriteCuisine       = [[preferencesDictionary objectForKey:kCuisine] objectAtIndex:0];
    FavoriteSmoking *favoriteSmoking        = [[preferencesDictionary objectForKey:kSmoking] objectAtIndex:0];
    FavoriteLocation *favoriteLocation      = [[preferencesDictionary objectForKey:kLocation] objectAtIndex:0];

    NSString *smokingValue;
    
    if ([favoriteSmoking.value isEqualToNumber:[NSNumber numberWithInt:0]]) {
        smokingValue = @"NO";
    }else if ([favoriteSmoking.value isEqualToNumber:[NSNumber numberWithInt:1]]) {
        smokingValue = @"YES";
    }else{
        smokingValue = @"YES/NO";
    }
    
    NSString *location = [NSString stringWithFormat:@"Dist. %@",favoriteLocation.nameNumber];
    
    [_categoryTextfield setStringValue:favoriteCategory.name];
    [_cuisineTextField setStringValue:favoriteCuisine.name];
    [_smoking setStringValue:smokingValue];
    [_locationTextField setStringValue:location];
    
    //Set preferences Value
    [_priceRange setStringValue:[[preferencesDictionary objectForKey:kPrice] stringValue]];
    [_gardenTextField setStringValue: [[preferencesDictionary objectForKey:kGarden] stringValue]];
    [_liveMusicTextfield setStringValue: [[preferencesDictionary objectForKey:kLiveMusic] stringValue]];
    [_childFriendlyTextfield setStringValue: [[preferencesDictionary objectForKey:kChildfriendly] stringValue]];
    [_vegetarianTextfield setStringValue: [[preferencesDictionary objectForKey:kVegaterian] stringValue]];
    
    //Set preferenceWeights
    [_categoryWeight setStringValue:[[preferencesWeightDictionary objectForKey:kCategory] stringValue]];
    [_cuisineWeight setStringValue:[[preferencesWeightDictionary objectForKey:kCuisine] stringValue]];
    [_locationWeight setStringValue:[[preferencesWeightDictionary objectForKey:kLocation] stringValue]];
    [_smokingWeight setStringValue:[[preferencesWeightDictionary objectForKey:kSmoking] stringValue]];
    [_priceRangeWeight setStringValue:[[preferencesWeightDictionary objectForKey:kPrice] stringValue]];
    [_gardenWeight setStringValue:[[preferencesWeightDictionary objectForKey:kGarden] stringValue]];
    [_liveMusicWeight setStringValue:[[preferencesWeightDictionary objectForKey:kLiveMusic] stringValue]];
    [_childFriendlyWeight setStringValue:[[preferencesWeightDictionary objectForKey:kChildfriendly] stringValue]];
    [_vegaterianWeight setStringValue:[[preferencesWeightDictionary objectForKey:kVegaterian] stringValue]];
        
    [self updateRatingTable];
    
    //Post Notification for the RecommendationView
    NSNotification *userChangedNotification  = [NSNotification notificationWithName:userSelectedNotification object:currentlySelectedUser];
    [[NSNotificationCenter defaultCenter] postNotification:userChangedNotification];
    
//    [[RatingsManager sharedInstance] getNumberOfPositiveRatingsForUser:currentlySelectedUser WithAttribute:@"smoking" andValue:@"0"];
    [[RatingsManager sharedInstance] countBasedRatingForAttribute:@"garden" Value:@"0" andUser:currentlySelectedUser];
    [[RatingsManager sharedInstance] countBasedRatingForAttribute:@"garden" Value:@"1" andUser:currentlySelectedUser];
}

-(IBAction)checkBoxchangedValue:(id)sender
{
    [self updateRatingTable];
}

-(void)updateRatingTable{
    
    if (_onlyPositiveRatingscheckBox.state==NSOnState) {
        
        NSArray *anArray = [[RatingsManager sharedInstance] getPositiveRatingsforUser:currentlySelectedUser];
        [ratingsArray removeAllObjects];
        [ratingsArray addObjectsFromArray:anArray];
        
    }else if (_onlyPositiveRatingscheckBox.state==NSOffState){
        
        NSArray *anArray = [[RatingsManager sharedInstance] getRestaurantRatingsForUser:currentlySelectedUser];
        [ratingsArray removeAllObjects];
        [ratingsArray addObjectsFromArray:anArray];
        
    }
    
    [weightedAverageArray removeAllObjects];
    for (RestaurantRating *currentRating in ratingsArray)
    {
        [weightedAverageArray addObject:[NSNumber numberWithFloat:[StatisticsLibrary weightedSumForRating:currentRating]]];
    }
    
    
    [ratingsTableView reloadData];

}

-(IBAction)showListPopOver:(id)sender{


    NSButton *clickedButton = (NSButton*)sender;

    if (currentlySelectedUser != nil && [preferencesDictionary objectForKey:kCategory])
    {
    switch (clickedButton.tag) {
        case 101:
        {
            [listPopUpcontroller setDataSource:[preferencesDictionary objectForKey:kCategory]];
            break;
        }
        case 102:
        {
            [listPopUpcontroller setDataSource:[preferencesDictionary objectForKey:kCuisine]];
            break;
        }
        case 103:
        {
            [listPopUpcontroller setDataSource:[preferencesDictionary objectForKey:kLocation]];
            break;
        }
        case 104:
        {
            [listPopUpcontroller setDataSource:[preferencesDictionary objectForKey:kSmoking]];
            break;
        }
        default:
            break;
    }
    [_listPopover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];

    }
}


#pragma mark - Tableview Delegate

- (NSInteger)clickedRow{
    return [usersTableView selectedRow];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
        
    if ([tableView.identifier isEqualToString:@"ratings"]) {
        return [ratingsArray count];
    }
    else
    {
        return [usersArray count];
    }
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{

    if ([tableView.identifier isEqualToString:@"ratings"]) {
        
        RestaurantRating *currentRating = (RestaurantRating*)[ratingsArray objectAtIndex:row];
        
        if ([tableColumn.identifier isEqualToString:@"restaurant"])
        {
            return currentRating.restaurant.uniqueName;
        }else if([tableColumn.identifier isEqualToString:@"coreService"]) {
            return currentRating.coreServiceRating;
        }else if([tableColumn.identifier isEqualToString:@"accessibility"]) {
            return currentRating.accessibilityRating;
        }else if([tableColumn.identifier isEqualToString:@"service"]) {
            return currentRating.serviceRating;
        }else if([tableColumn.identifier isEqualToString:@"tangibles"]) {
            return currentRating.tangiblesRating;
        }else if([tableColumn.identifier isEqualToString:@"personal"]) {
            return currentRating.personalRating;
        }else if([tableColumn.identifier isEqualToString:@"average"]) {

            if ([weightedAverageArray count])
            {
            return [weightedAverageArray objectAtIndex:row];
            }else{
            return @"N/A";
            }

        }
        else{
            return @"Poof";
        }
    }
    else
    {
        User *currentUser = [usersArray objectAtIndex:row];
        
        if ([tableColumn.identifier isEqualToString:@"user"]) {
            
            return currentUser.userid;
            
        }else if([tableColumn.identifier isEqualToString:@"stereotype"]) {
            
            return currentUser.stereotype;
        }else if([tableColumn.identifier isEqualToString:@"accessibility"]) {
            return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.accessibility floatValue]];
        }else if([tableColumn.identifier isEqualToString:@"personal"]) {
            return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.personal floatValue]];
        }else if([tableColumn.identifier isEqualToString:@"service"]) {
                        return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.service floatValue]];
        }else if([tableColumn.identifier isEqualToString:@"coreService"]) {
                        return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.coreService floatValue]];
        }else if([tableColumn.identifier isEqualToString:@"tangibles"]) {
                        return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.tangibles floatValue]];
        }else{
        
        return @"Poof";
        }
    }
    
}

- (BOOL)tableView:(NSTableView *)aTableView shouldEditTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return NO;
}


#pragma mark - Generator Methods

-(IBAction)generateRecommendation:(id)sender{


    [[RecommendationManager sharedInstance] getRecommendationForUser:currentlySelectedUser
                                                     withPreferences:preferencesDictionary
                                                           andWeight:preferencesWeightDictionary];
    
    //Change tab to recommendation
    [tabview selectTabViewItemAtIndex:3];

}


-(IBAction)generateRatings:(id)sender
{
#warning show loading indication
    /*
    NSArray *array1 = [NSArray arrayWithObjects:[NSNumber numberWithFloat:32.523532532],[NSNumber numberWithFloat:-32.532532],[NSNumber numberWithFloat:99.0],[NSNumber numberWithFloat:12.532532],[NSNumber numberWithFloat:22], nil];
    NSArray *array2 = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-2.532532],[NSNumber numberWithFloat:-3.1],[NSNumber numberWithFloat:-9.1],[NSNumber numberWithFloat:22.53253],[NSNumber numberWithFloat:-12.0], nil];
    
     */
//    NSLog(@"Correlation %f",[StatisticsLibrary pearsonCorreleationBetweenArray1:array1 andArray2:array2]);
//    NSLog(@"Cramer %f",[StatisticsLibrary cramersVforAttribute]);
    


//    [self generateRatingBackgroundThread];
    [self performSelectorInBackground:@selector(generateRatingBackgroundThread) withObject:nil];
    
//    [self generateRatingBackgroundThread];
    
//    NSLog(@"Entropy %f",[StatisticsLibrary entopyOfVariable]);
}

-(void)generateRatingBackgroundThread{

/*
        NSArray *allUsersArray = [[DataFetcher sharedInstance] getUsers];
        int i =0;
    
    NSTimeInterval start= [[NSDate date] timeIntervalSince1970];
 */
    @autoreleasepool
    {
        [[DataGenerator sharedInstance] generateAllUserRatings];
    }
    

    [self performSelectorOnMainThread:@selector(notifyViewsAfterRAtingGeneration) withObject:nil waitUntilDone:NO];
    
}

-(void)notifyViewsAfterRAtingGeneration{
    
    NSNotification *ratingsCreatedNotification = [NSNotification notificationWithName:ratingsGeneratedNotification object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:ratingsCreatedNotification];
}


@end
