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
        listPopUpcontroller = [[ListPopUpcontroller alloc] init];
    }
    
    return self;
}

-(void)awakeFromNib{
    usersArray = [NSMutableArray arrayWithArray:[[DataGenerator sharedInstance] getUsers]];
    ratingsArray = [NSMutableArray arrayWithArray:[[DataGenerator sharedInstance] getRestaurantRatings]];
    
    
    [_categoryTextfield setSelectable:NO];
    [_categoryTextfield setEditable:NO];
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
    preferencesDictionary = [NSMutableDictionary dictionaryWithDictionary: [[DataGenerator sharedInstance] getPreferencesDictionaryForUser:currentlySelectedUser]];

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
    
    [_priceRange setStringValue:[[preferencesDictionary objectForKey:kPrice] stringValue]];
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
//            listPopUpcontroller = [[ListPopUpcontroller alloc] initWithDataSource:[preferencesDictionary objectForKey:kLocation]];
            break;
        }
        case 104:
        {
            [listPopUpcontroller setDataSource:[preferencesDictionary objectForKey:kSmoking]];

//            listPopUpcontroller = [[ListPopUpcontroller alloc] initWithDataSource:[preferencesDictionary objectForKey:kSmoking]];
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
