//
//  Restaurants.m
//  Recommendation
//
//  Created by ilker on 14.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//


#import "DataFetcher.h"
#import "RestaurantsView.h"
#import "AppDelegate.h"

#import "DataGenerator.h"

#import "Restaurant.h"

@implementation RestaurantsView

-(id)init
{

    self  = [super init];
    if (self) {
        restaurantsArray = [[NSMutableArray alloc] initWithCapacity:0];

    }
    
    return self;
}

-(void)awakeFromNib{
    restaurantsArray = [NSMutableArray arrayWithArray:[[DataFetcher sharedInstance] getRestaurants]];
    [RestaurantTableView reloadData];
}


- (IBAction) populateTableView:(id)sender{


    [[DataGenerator sharedInstance] generateRestaurants:[[_numberOfRestaurants stringValue] intValue]];
    restaurantsArray = [NSMutableArray arrayWithArray:[[DataFetcher sharedInstance] getRestaurants]];
    [RestaurantTableView reloadData];

}

#pragma mark - NSTableView Datasource

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{

//    NSLog(@"%ld",[restaurantsArray count]);
    
    return [restaurantsArray count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{

    Restaurant *currentRestaurant = [restaurantsArray objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:@"id"]) {
    
        return [NSString stringWithFormat:@"Rest %ld",row];
    
    }else if([tableColumn.identifier isEqualToString:@"category"]) {

        return currentRestaurant.category;
    }else if([tableColumn.identifier isEqualToString:@"cuisine"]){
    
        return currentRestaurant.cuisine;
    }else if([tableColumn.identifier isEqualToString:@"priceRange"]){
    
        switch ([(NSNumber*)currentRestaurant.priceRange intValue]) {
            case 0:
            {
                return @"Low";
                break;
            }
            case 1:
            {
                return @"Normal";
                break;
            }
            case 2:
            {
                return @"Above average";
                break;
            }case 3:
            {
                return @"Luxus";
                break;
            }
            default:
                break;
        }
    }else if([tableColumn.identifier isEqualToString:@"location"]){

        return [NSString stringWithFormat:@"%d .Dist.",[currentRestaurant.location intValue]];
        
    }else if([tableColumn.identifier isEqualToString:@"smoking"]){

        switch ([(NSNumber*)currentRestaurant.smoking intValue]) {
            case 0:
            {
                return @"NO";
                break;
            }
            case 1:
            {
                return @"YES";
                break;
            }
            case 2:
            {
                return @"YES/NO";
                break;
            }
            default:
                break;
        }
        

    }else if([tableColumn.identifier isEqualToString:@"garden"]){
        
        switch ([(NSNumber*)currentRestaurant.garden intValue]) {
            case 0:
            {
                return @"NO";
                break;
            }
            case 1:
            {
                return @"YES";
                break;
            }
            default:
                break;
        }
        

    }else if([tableColumn.identifier isEqualToString:@"liveMusic"]){
        switch ([(NSNumber*)currentRestaurant.liveMusic intValue]) {
            case 0:
            {
                return @"NO";
                break;
            }
            case 1:
            {
                return @"YES";
                break;
            }
            default:
                break;
        }
        

    }else if([tableColumn.identifier isEqualToString:@"childFriendly"]){
        switch ([(NSNumber*)currentRestaurant.childFriendly intValue]) {
            case 0:
            {
                return @"NO";
                break;
            }
            case 1:
            {
                return @"YES";
                break;
            }
            default:
                break;
        }
        

    }else if([tableColumn.identifier isEqualToString:@"vegaterian"]){
        
        return @"Remove";
        /*
        switch ([(NSNumber*)currentRestaurant.vegaterian intValue]) {
            case 0:
            {
                return @"NO";
                break;
            }
            case 1:
            {
                return @"YES";
                break;
            }
            default:
                break;
        }
        */

    }else if([tableColumn.identifier isEqualToString:@"carPark"]){
        switch ([(NSNumber*)currentRestaurant.carPark intValue]) {
            case 0:
            {
                return @"NO";
                break;
            }
            case 1:
            {
                return @"YES";
                break;
            }
            default:
                break;
        }
        
        
    }
        return @"N.A";

}

@end
