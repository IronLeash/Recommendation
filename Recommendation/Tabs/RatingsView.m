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
@implementation RatingsView



-(id)init
{
    
    self  = [super init];
    if (self) {
        usersArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    
    return self;
}

-(void)awakeFromNib{
    usersArray = [NSMutableArray arrayWithArray:[[DataGenerator sharedInstance] getUsers]];

    [usersTableView reloadData];

}



-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
        
    if ([tableView.identifier isEqualToString:@"ratings"]) {
        return 4;
    }
    else
    {
        return [usersArray count];
    }
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    
    
    if ([tableView.identifier isEqualToString:@"ratings"]) {
        return @"ratings";
    }
    else
    {

        User *currentUser = [usersArray objectAtIndex:row];

        
        if ([tableColumn.identifier isEqualToString:@"user"]) {
            
            return currentUser.userid;
            
        }else if([tableColumn.identifier isEqualToString:@"stereotype"]) {
            
            return currentUser.stereotype;
        }else if([tableColumn.identifier isEqualToString:@"accessibility"]) {
        
//            return currentUser.ratingWeight.accessibility;
            return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.accessibility floatValue]];
        }else if([tableColumn.identifier isEqualToString:@"personal"]) {
            return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.personal floatValue]];
//                        return currentUser.ratingWeight.personal;
        }else if([tableColumn.identifier isEqualToString:@"service"]) {
                        return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.service floatValue]];
//                    return currentUser.ratingWeight.service;
        }else if([tableColumn.identifier isEqualToString:@"coreService"]) {
                        return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.coreService floatValue]];
//            return currentUser.ratingWeight.coreService;
        }else if([tableColumn.identifier isEqualToString:@"tangibles"]) {
                        return [NSString stringWithFormat:@"%.3f",[currentUser.ratingWeight.tangibles floatValue]];
//                        return currentUser.ratingWeight.tangibles;
        }else{
        
        return @"Poof";
        }
    }
    
}

- (BOOL)tableView:(NSTableView *)aTableView shouldEditTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return NO;
}



@end
