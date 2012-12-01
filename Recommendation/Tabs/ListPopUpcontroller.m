//
//  ListPopUpcontroller.m
//  Recommendation
//
//  Created by ilker on 28.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "ListPopUpcontroller.h"
#import "FavoriteLocation.h"

@implementation ListPopUpcontroller 


#pragma mark - Init
-(id)init{

    self = [super init];
    if (self!=nil) {

        scoreListArray = [[NSMutableArray alloc] init];

    }
    
    return self;
}

-(void)setDataSource:(NSArray*)dataSourceArray{

//    [[scoreTableview headerView] setNeedsDisplay:YES];
    [scoreListArray removeAllObjects];
    [scoreListArray addObjectsFromArray:dataSourceArray];
    [[firstColumn headerCell] setStringValue:NSStringFromClass([[scoreListArray objectAtIndex:0] class])] ;
    [scoreTableview reloadData];
}


/*
-(void)awakeFromNib{


    [[firstColumn headerCell] setStringValue:@"Deneme"] ;
    [[scoreTableview headerView] setNeedsDisplay:YES];

}
*/


#pragma mark - TableView delegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
 return   [scoreListArray count];
}


- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{


    if ([aTableColumn.identifier isEqualToString:@"name"]) {
        
        if ([[scoreListArray objectAtIndex:rowIndex] respondsToSelector:@selector(name)]) {
            return [[scoreListArray objectAtIndex:rowIndex] name];
            
        }else if([[scoreListArray objectAtIndex:rowIndex] respondsToSelector:@selector(value)]){
            
            NSString *returnValue;
            switch ([[[scoreListArray objectAtIndex:rowIndex] value] intValue]) {
                case 0:
                {
                    returnValue = @"NO";
                    break;
                }
                case 1:
                {
                    returnValue = @"YES";
                    break;
                }
                case 2:
                {
                    returnValue = @"YES/NO";
                    break;
                }
                default:
                    break;
            }
            
            return returnValue;
            
        }else{
            return [NSString stringWithFormat:@"Dist. %@",[(FavoriteLocation*)[scoreListArray objectAtIndex:rowIndex] nameNumber]];
        
        }
        
    }else if ([aTableColumn.identifier isEqualToString:@"rank"]){
        return [NSString stringWithFormat:@"%ld.",rowIndex+1];
    }else{
        
        if ([[scoreListArray objectAtIndex:rowIndex] respondsToSelector:@selector(weightedValue)]) {
            
            return [NSNumber numberWithFloat:[[scoreListArray objectAtIndex:rowIndex] weightedValue]];
        }
        else
        {
            return @"N/A";
        }

    }
    
}


@end
