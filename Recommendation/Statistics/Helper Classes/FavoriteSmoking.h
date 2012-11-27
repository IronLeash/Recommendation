//
//  FavoriteSmoking.h
//  Recommendation
//
//  Created by ilker on 26.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteSmoking : NSObject

@property (nonatomic,assign) int totalOccurances;
@property (nonatomic,assign) float ratingtotal;
@property (nonatomic,assign) float weightedValue;
@property (nonatomic,strong) NSNumber *value;


@end
