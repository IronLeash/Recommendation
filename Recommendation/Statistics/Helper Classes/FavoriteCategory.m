//
//  FavoriteCategory.m
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "FavoriteCategory.h"

@implementation FavoriteCategory

@synthesize totalOccurances;
@synthesize ratingtotal;
@synthesize weightedValue;
@synthesize name;

    
-(id)init{

    self=[super init];

    if (self != nil) {
        totalOccurances = 0;
        ratingtotal = 0;
        weightedValue = 0;
    }
    return self;
}


-(NSString*)description{

    return [NSString stringWithFormat:@"Name: %@ Total Occurances : %@ Rating Total: %f Weighted Value %f",self.name,[NSNumber numberWithInt:totalOccurances], ratingtotal,weightedValue];
}

@end
