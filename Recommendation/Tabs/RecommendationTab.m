//
//  RecommendationTab.m
//  Recommendation
//
//  Created by Ilker Baltaci on 1/9/13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import "RecommendationTab.h"
#import "RecommendationManager.h"
#import "Recommendation.h"

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
        returnString = currentRecommendation.restaurant.uniqueName;
    }
    else if ([tableColumn.identifier isEqualToString:@"cuisine"])
    {
        returnString = currentRecommendation.restaurant.cuisine;
    }else if([tableColumn.identifier isEqualToString:@"category"]){
        returnString = currentRecommendation.restaurant.category;
    }else{
        returnString = @"Hi";
    }

    return returnString;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldEditTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return NO;
}


@end
