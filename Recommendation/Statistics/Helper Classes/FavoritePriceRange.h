//
//  FavoritePriceRange.h
//  Recommendation
//
//  Created by ilker on 04.02.13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritePriceRange : NSObject

@property (nonatomic,assign) int totalOccurances;
@property (nonatomic,assign) float ratingtotal;
@property (nonatomic,assign) float weightedValue;
@property (nonatomic,strong) NSNumber *value;

@end
