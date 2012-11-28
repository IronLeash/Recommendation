//
//  ListPopUpcontroller.h
//  Recommendation
//
//  Created by ilker on 28.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListPopUpcontroller : NSObject<NSTableViewDataSource,NSTableViewDelegate>
{
IBOutlet NSTableView *scoreTableview;
NSMutableArray *scoreListArray;
IBOutlet NSTableColumn *firstColumn;
    
}

-(void)setDataSource:(NSArray*)dataSourceArray;

@end
