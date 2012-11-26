//
//  FavoriteCategory.h
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "Category.h"

@interface FavoriteCategory : NSObject
{

    
    

    /*
    //Iterate and find this
    int totalOccurances;
    
    //During iteration increament this value so taht average rating is possible calciulate the avera
    float ratingtotal;
    
    
    //Finally set the
    float weightedValue;
*/
}


@property (nonatomic,assign) int totalOccurances;
@property (nonatomic,assign) float ratingtotal;
@property (nonatomic,assign) float weightedValue;
@property (nonatomic,strong) NSString *name;


@end
