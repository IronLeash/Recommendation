//
//  RatingsView.m
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "RatingsView.h"
#import "DataGenerator.h"

#import "User.h"
#import "RatingWeight.h"
#import "Restaurant.h"
#import "RestaurantRating.h"
#import "StatisticsLibrary.h"
#import "Constants.h"


@implementation RatingsView

-(id)init
{
    
    self  = [super init];
    if (self) {
        usersArray = [[NSMutableArray alloc] initWithCapacity:0];
        ratingsArray = [[NSMutableArray alloc] init];
        weightedAverageArray = [[NSMutableArray alloc]  init];
        preferencesDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)awakeFromNib{
    usersArray = [NSMutableArray arrayWithArray:[[DataGenerator sharedInstance] getUsers]];
    ratingsArray = [NSMutableArray arrayWithArray:[[DataGenerator sharedInstance] getRestaurantRatings]];
    
    [_gardenTextField setEditable:NO];
    [_liveMusicTextfield setEditable:NO];
    [_childFriendlyTextfield setEditable:NO];
    [_vegetarianTextfield setEditable:NO];
    
    [usersTableView reloadData];
    
}

#pragma mark - Custom Methods


-(IBAction)aRowIsSelected:(id)sender{

    NSLog(@"Selected row %ld",[usersTableView selectedRow]);
    
    currentlySelectedUser = [usersArray objectAtIndex:[usersTableView selectedRow]];
    
    //Change preferences
    NSArray *positiveRatings = [[DataGenerator sharedInstance] getPositiveRatingsforUser:currentlySelectedUser];
    preferencesDictionary = [NSMutableDictionary dictionaryWithDictionary: [StatisticsLibrary preferencesDictionary:positiveRatings]];

    
    [_gardenTextField setStringValue: [[preferencesDictionary objectForKey:kGarden] stringValue]];
    [_liveMusicTextfield setStringValue: [[preferencesDictionary objectForKey:kLiveMusic] stringValue]];
    [_childFriendlyTextfield setStringValue: [[preferencesDictionary objectForKey:kChildfriendly] stringValue]];
    [_vegetarianTextfield setStringValue: [[preferencesDictionary objectForKey:kVegetarian] stringValue]];
    
    NSLog(@"Preferences %@",preferencesDictionary);
    
    [self updateRatingTable];
}

-(IBAction)checkBoxchangedValue:(id)sender
{

    [self updateRatingTable];
}


-(void)updateRatingTable{
    

    if (_onlyPositiveRatingscheckBox.state==NSOnState) {
        
        NSArray *userRatings = [[DataGenerator sharedInstance] getPositiveRatingsforUser:currentlySelectedUser];
        [ratingsArray removeAllObjects];
        [ratingsArray addObjectsFromArray:userRatings];
        
    }else if (_onlyPositiveRatingscheckBox.state==NSOffState){
        
        NSArray *userRatings = [[DataGenerator sharedInstance] getRestaurantRatingsForUser:currentlySelectedUser];
        [ratingsArray removeAllObjects];
        [ratingsArray addObjectsFromArray:userRatings];
        
    }
    
    [weightedAverageArray removeAllObjects];
    for (RestaurantRating *currentRating in ratingsArray)
    {
        [weightedAverageArray addObject:[NSNumber numberWithFloat:[StatisticsLibrary weightedSumForRating:currentRating]]];
    }
    
    
    [ratingsTableView reloadData];

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
            return currentRating.restaurant.restaurantId;
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

-(IBAction)generateRatings:(id)sender
{
#warning show loading indication
    [self performSelectorInBackground:@selector(generateRatingBackgroundThread) withObject:nil];
}

-(void)generateRatingBackgroundThread{

    @autoreleasepool
    {
        NSArray *allUsersArray = [[DataGenerator sharedInstance] getUsers];
        
        for (User *currentUser in allUsersArray) {
            [[DataGenerator sharedInstance] generateRatingForUser:currentUser];
        }
    }
#warning post notification to remove loading secrren
    
}


@end
