//
//  FavoriteCuisine.h
//  Recommendation
//
//  Created by ilker on 26.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "Category.h"

@interface FavoriteCuisine : NSObject


@property (nonatomic,assign) int totalOccurances;
@property (nonatomic,assign) float ratingtotal;
@property (nonatomic,assign) float weightedValue;
@property (nonatomic,strong) NSString *name;


@end
