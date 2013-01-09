//
//  RecommendationTab.h
//  Recommendation
//
//  Created by Ilker Baltaci on 1/9/13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendationTab : NSObject <NSTableViewDataSource,NSTableViewDelegate>
{
    IBOutlet NSTableView *recommendationTableView;
    IBOutlet NSTextView  *selectedUsetTextView;
}
@end
