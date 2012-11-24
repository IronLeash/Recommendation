//
//  RatingsView.h
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RatingsView : NSObject <NSTabViewDelegate,NSTableViewDataSource>
{

    NSMutableArray *usersArray;
    IBOutlet NSTableView *usersTableView;

}
@end
