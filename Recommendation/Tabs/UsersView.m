//
//  UsersView.m
//  Recommendation
//
//  Created by ilker on 21.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "UsersView.h"
#import "User.h"
#import "DataGenerator.h"

@implementation UsersView

-(id)init
{
    
    self  = [super init];
    if (self) {
        usersArray = [[NSMutableArray alloc] initWithCapacity:0];
//        usersArray = [[NSMutableArray alloc] initWithArray:[[DataGenerator sharedInstance] getUsers]];
    }
    
    return self;
}

-(void)awakeFromNib
{
    usersArray = [NSMutableArray arrayWithArray:[[DataGenerator sharedInstance] getUsers]];
    [usersTableView reloadData];
}

-(IBAction)generateUsers:(id)sender
{
    [[DataGenerator sharedInstance] generateUsers:[[_numberOfUsers stringValue] intValue]];
    usersArray = [NSMutableArray arrayWithArray:[[DataGenerator sharedInstance] getUsers]];
    [usersTableView reloadData];
}


#pragma mark - NSTableView Datasource

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    
    return [usersArray count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    
    User *currentUser = [usersArray objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:@"id"]) {
        
        return [NSString stringWithFormat:@"User %ld",row];
        
    }else if([tableColumn.identifier isEqualToString:@"age"]) {
        
        return currentUser.age;
    }else if([tableColumn.identifier isEqualToString:@"gender"]){
        
        switch ([(NSNumber*)currentUser.gender intValue]) {
            case 0:
            {
                return @"Female";
                break;
            }
            case 1:
            {
                return @"Male";
                break;
            }
            default:
                break;
        }
    }else if([tableColumn.identifier isEqualToString:@"location"]){
        
        return currentUser.location;
    }else if([tableColumn.identifier isEqualToString:@"smoker"]){
        
        return currentUser.smoker;
        
    }else if([tableColumn.identifier isEqualToString:@"vegaterian"]){
        
        switch ([(NSNumber*)currentUser.vegeterian intValue]) {
            case 0:
            {
                return @"No";
                break;
            }
            case 1:
            {
                return @"Yes";
                break;
            }
            default:
                break;
        }
        
    }else if([tableColumn.identifier isEqualToString:@"stereotype"]){
        
        return currentUser.stereotype;
    }
        
        
    

    return @"N.A";

}


@end
