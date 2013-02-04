//
//  FavoritePriceRange.m
//  Recommendation
//
//  Created by ilker on 04.02.13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import "FavoritePriceRange.h"

@implementation FavoritePriceRange

@synthesize totalOccurances;
@synthesize ratingtotal;
@synthesize weightedValue;
@synthesize value;

-(id)init{
    
    self=[super init];
    
    if (self != nil) {
        totalOccurances = 0;
        ratingtotal = 0;
        weightedValue = 0;
    }
    return self;
}

@end
