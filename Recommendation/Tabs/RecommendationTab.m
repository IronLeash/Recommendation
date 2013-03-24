//
//  RecommendationTab.m
//  Recommendation
//
//  Created by Ilker Baltaci on 1/9/13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import "RecommendationTab.h"
#import "RatingsView.h"
#import "RecommendationManager.h"
#import "PreferencesManager.h"

#import "Recommendation.h"
#import "AttributeValueConverter.h"

@implementation RecommendationTab

-(id)init
{
    
    self  = [super init];
    if (self) {
        recommendationArray  = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}

-(void)awakeFromNib{

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateRecommendationTable:)
                                                 name:recommendationArrayGeneratedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateCurrentUser:)
                                                 name:userSelectedNotification
                                               object:nil];
    
    
    textformatter = [[NSNumberFormatter alloc] init];
    textformatter.roundingIncrement = [NSNumber numberWithDouble:0.1];
    textformatter.numberStyle = NSNumberFormatterDecimalStyle;
}




-(void)updateCurrentUser:(NSNotification*)aNotification
{
    currentUser = [aNotification object];
    NSMutableString *userInformationString = [[NSMutableString alloc] initWithString:[AttributeValueConverter userDescription:currentUser]];
    [userInformationString appendString:@"\n"];
    [userInformationString appendString:[AttributeValueConverter userPreferencesDescription:[[PreferencesManager sharedInstance] getPreferencesDictionaryForUser:currentUser]]];
    [selectedUsetTextView setString:userInformationString];
    
    NSLog(@"Current User %@",currentUser);
}


-(void)updateRecommendationTable:(NSNotification*)aNotification
{
    
    [recommendationArray removeAllObjects];
    [recommendationArray addObjectsFromArray:[aNotification object]];
    [recommendationTableView reloadData];
}

#pragma mark - Tableview Delegate

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [recommendationArray count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *returnString;
    Recommendation *currentRecommendation = [recommendationArray objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:@"restaurant"]) {
        returnString = [NSString stringWithFormat:@"%@",currentRecommendation.restaurant.uniqueName];
    }
    else if ([tableColumn.identifier isEqualToString:@"cuisine"])
    {
        returnString = currentRecommendation.restaurant.cuisine;
    }else if([tableColumn.identifier isEqualToString:@"category"]){
        returnString = currentRecommendation.restaurant.category;
    }else if([tableColumn.identifier isEqualToString:@"place"]){
        returnString = [currentRecommendation.restaurant.location stringValue];
    }else if([tableColumn.identifier isEqualToString:@"price"]){
        returnString = [AttributeValueConverter priceValueRepresentation:currentRecommendation.restaurant.priceRange];
    }else if([tableColumn.identifier isEqualToString:@"smoking"]){
        returnString = [AttributeValueConverter smoingValueRepresentation:currentRecommendation.restaurant.smoking];
    }else if([tableColumn.identifier isEqualToString:@"garden"]){
        returnString = BOOLREP([currentRecommendation.restaurant.garden intValue]);
    }else if([tableColumn.identifier isEqualToString:@"liveMusic"]){
        returnString = BOOLREP([currentRecommendation.restaurant.liveMusic intValue]);
    }else if([tableColumn.identifier isEqualToString:@"carPark"]){
        returnString = BOOLREP([currentRecommendation.restaurant.carPark intValue]);
    }else if([tableColumn.identifier isEqualToString:@"childFriendly"]){
        returnString = BOOLREP([currentRecommendation.restaurant.childFriendly intValue]);
    }else if ([tableColumn.identifier isEqualToString:@"realRating"]){
        NSString *roundedRating = [textformatter stringFromNumber:[NSNumber numberWithDouble:currentRecommendation.realRating]];
        returnString = roundedRating;
    }else if ([tableColumn.identifier isEqualToString:@"realRanking"]){
        returnString = [NSString stringWithFormat:@"%ld",currentRecommendation.realRanking+1];
    }else if ([tableColumn.identifier isEqualToString:@"ranking"]){
        returnString = [NSString stringWithFormat:@"%ld",(row+1)];
    }
    else{

        NSString *roundedRating = [textformatter stringFromNumber:[NSNumber numberWithDouble:currentRecommendation.rating]];
        returnString = roundedRating;
    }

    return returnString;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldEditTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return NO;
}


@end
