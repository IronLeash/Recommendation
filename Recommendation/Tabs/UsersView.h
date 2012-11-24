//
//  UsersView.h
//  Recommendation
//
//  Created by ilker on 21.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersView : NSObject <NSTableViewDataSource,NSTableViewDelegate>{

    IBOutlet NSTableView *usersTableView;
    NSMutableArray *usersArray;
    
    __weak NSTextField *_numberOfUsers;
}

-(IBAction)generateUsers:(id)sender;

@property (weak) IBOutlet NSTextField *numberOfUsers;
@end
