//
//  Restaurants.h
//  Recommendation
//
//  Created by ilker on 14.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantsView : NSObject <NSTableViewDataSource,NSTableViewDelegate>{

    IBOutlet NSTableView *RestaurantTableView;
    NSMutableArray *restaurantsArray;
    
    __weak NSTextField *_numberOfRestaurants;
    
}


- (IBAction) populateTableView:(id)sender;


@property (weak) IBOutlet NSTextField *numberOfRestaurants;
@end
