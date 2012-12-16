//
//  StatisticsLibrary.m
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerator.h"
#import "DataFetcher.h"

#import "StatisticsLibrary.h"
#import "RatingWeight.h"
#import "Restaurant.h"
#import "Constants.h"
#import "FavoriteSmoking.h"

@implementation StatisticsLibrary


+ (float)weightedSumForRating:(RestaurantRating*)aRating{

    
    
    RatingWeight *currentRatingWeight = aRating.user.ratingWeight;
    
    float accessibility = ([aRating.accessibilityRating floatValue] * [currentRatingWeight.accessibility floatValue]);
    float coreService   = ([aRating.coreServiceRating floatValue] * [currentRatingWeight.coreService floatValue]);
    float tangibles     = ([aRating.tangiblesRating floatValue] * [currentRatingWeight.tangibles floatValue]);
    float service       = ([aRating.serviceRating floatValue] * [currentRatingWeight.service floatValue]);
    float personal      = ([aRating.personalRating floatValue] * [currentRatingWeight.personal floatValue]);
    
    return accessibility + coreService + tangibles + service + personal;
    
}




+ (float)scoreofCategory:(FavoriteCategory*)aCategory amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage{

    float score  = ALPHA*(aCategory.totalOccurances/(float)numberfPositeRatings) + BETA*((aCategory.ratingtotal/aCategory.totalOccurances)/positveRatingAverage);
    return score;
}

+ (float)scoreofCuisine:(FavoriteCuisine*)aCuisine amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage{
    
    float score  = ALPHA*(aCuisine.totalOccurances/(float)numberfPositeRatings) + BETA*((aCuisine.ratingtotal/aCuisine.totalOccurances)/positveRatingAverage);
    return score;
}

+ (float)scoreoSmoking:(FavoriteSmoking*)aSmoking amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage{
    
    float score  = ALPHA*(aSmoking.totalOccurances/(float)numberfPositeRatings) + BETA*((aSmoking.ratingtotal/aSmoking.totalOccurances)/positveRatingAverage);
    return score;
}

+ (float)scoreoLocation:(FavoriteLocation*)aLocation amongRatingNumber:(int)numberfPositeRatings withAverage:(float)positveRatingAverage{
    
    float score  = ALPHA*(aLocation.totalOccurances/(float)numberfPositeRatings) + BETA*((aLocation.ratingtotal/aLocation.totalOccurances)/positveRatingAverage);
    return score;
}

+ (float)weightedpositveRatingsMean:(NSArray*)positiveRatings{

    float average= 0;

    for (RestaurantRating *currentRating in  positiveRatings) {
        average+=[StatisticsLibrary weightedSumForRating:currentRating];
    }
    
    average = average/[positiveRatings count];

    return average;
}


+ (double)pearsonCorreleationBetweenArray1:(NSArray*)array1 andArray2:(NSArray*)array2{

    double returnValue;

    double CArray1[[array1 count]];
    double CArray2[[array2 count]];
    
//    double CArray3[]={1,3,5,7,8,9,0,-3,2};
//    double CArray4[]={12321,14.0,421,53,1,11,-12};
    
    
    int i = 0;
    for (NSNumber *currentNumber in array1) {
        CArray1[i] = (double)[currentNumber doubleValue];
        NSLog(@"Array1 %f",CArray1[i]);
        i++;
    }
    
    i = 0;
    for (NSNumber *currentNumber in array2) {
        CArray2[i] = (double)[currentNumber doubleValue];
        NSLog(@"Array2 %f",CArray2[i]);
        i++;
    }
    
    
    returnValue = gsl_stats_correlation(CArray1, 1, CArray2, 1, [array1 count]);
    
    return returnValue;
}


+ (double)cramersVforAttribute{

    
    NSArray *row1 = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:11],
                      [NSNumber numberWithFloat:4], nil];
    
    NSArray *row2 = [NSArray arrayWithObjects:
                           
                           [NSNumber numberWithFloat:3],
                       [NSNumber numberWithFloat:8], nil];
    
    NSArray *contigencyTableArray =[NSArray arrayWithObjects:row1,row2, nil];
    int degree = 1;
    
//    double gsl_ran_chisq = gsl_ran_chisq (const gsl_rng * r, degree);
    
    
    double chiSquare = 0;
    double totalOccurences = 0;
    
    int colomnTotal = 0;
    int rowTotal = 0;
    NSMutableArray *marginalFrequencyRow = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *marginalFrequencyColomn = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int row=0; row < [contigencyTableArray count]; row++) {
        
        for (int i = 0; i <[[contigencyTableArray objectAtIndex:row] count]; i++)
        {
            colomnTotal += [[[contigencyTableArray objectAtIndex:i] objectAtIndex:row] doubleValue];
            rowTotal += [[[contigencyTableArray objectAtIndex:row] objectAtIndex:i] doubleValue];
        }
        totalOccurences += rowTotal;
        [marginalFrequencyColomn addObject:[NSNumber numberWithInt:colomnTotal]];
        [marginalFrequencyRow addObject:[NSNumber numberWithInt:rowTotal]];
        colomnTotal = 0;
        rowTotal  = 0;

    }
    
    for (int row=0; row < [contigencyTableArray count]; row++) {
        
        for (int i = 0; i <[[contigencyTableArray objectAtIndex:row] count]; i++)
        {

            double expected = (double)([[marginalFrequencyColomn objectAtIndex:i] doubleValue] * [[marginalFrequencyRow objectAtIndex:row] doubleValue]/totalOccurences);
            NSLog(@"Expected %f",expected);
            chiSquare += (([[[contigencyTableArray objectAtIndex:row] objectAtIndex:i] doubleValue]-expected)*([[[contigencyTableArray objectAtIndex:row] objectAtIndex:i] doubleValue]-expected))/expected;
            
                        NSLog(@"O %@",[[contigencyTableArray objectAtIndex:row] objectAtIndex:i]);
                        NSLog(@"Chi %f",chiSquare);
            /*
            chiSquare += (double)sqrt([[[contigencyTableArray objectAtIndex:row] objectAtIndex:i] doubleValue] - expected)/expected;*/
        }

        
    }
    
    
//    double gsl_ran_chisq_pdff = gsl_ran_chisq_pdf(0.95, 1);
//    double gsl_cdf_chisq_Pf = gsl_cdf_chisq_P(0.05, 1);

}



+ (NSDictionary*)entopyOfVariable
{
    //find entropies of all features
    
    double hCategory = 0;
    double hCuisine = 0;
    double hLocation = 0;
    double hSmoking = 0;
    double hPriceRange = 0;
    double hGarden = 0;
    double hLiveMusic = 0;
    double hChildFriendly = 0;
    double hVegaterian= 0;
    double hCardPark= 0;

    
    NSArray *allCategories = [[DataFetcher sharedInstance] getRestaurantCategories];
    NSArray *allCuisines = [[DataFetcher sharedInstance] getRestaurantCuisines];
    NSArray *allLocations = [[DataFetcher sharedInstance] getDistinctRestaurantLocations];

    
    NSArray *allRestaurants = [[DataFetcher sharedInstance] getRestaurants];
    NSMutableArray *temporaryArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    @autoreleasepool
    {
        for (NSString *currentCategory in allCategories) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantsofCategory:currentCategory]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hCategory += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        
        NSLog(@"Entropty category %f",hCategory);
        
        for (NSString *currentCuisine in allCuisines) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantsofCuisine:currentCuisine]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hCuisine += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty cuisine %f",hCuisine);
        
        for (NSNumber *currentLocation in allLocations) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantsInLocation:currentLocation]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
        
            hLocation += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty Location %f",hLocation);
        
        for (int i = 0; i < 4 ; i++ ) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantsForPriceRange:[NSNumber numberWithInt:i]]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hPriceRange += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty PriceRange %f",hPriceRange);

        for (int i = 0; i < 3 ; i++ ) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantForSmokingValue:[NSNumber numberWithInt:i]]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hSmoking += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty Smoking %f",hSmoking);

        
        for (int i = 0; i < 2 ; i++ ) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantForGardenVale:[NSNumber numberWithInt:i]]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hGarden += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty Garden %f",hGarden);

        
        for (int i = 0; i < 2 ; i++ ) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantForLiveMusicValue:[NSNumber numberWithInt:i]]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hLiveMusic += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty LiveMusic %f",hLiveMusic);

        for (int i = 0; i < 2 ; i++ ) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantsWithVegaterieanValue:[NSNumber numberWithInt:i]]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hVegaterian += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty Vegeterian %f",hVegaterian);

        for (int i = 0; i < 2 ; i++ ) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantForChildFriendly:[NSNumber numberWithInt:i]]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hChildFriendly += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty ChildFriendly %f",hChildFriendly);

        for (int i = 0; i < 2 ; i++ ) {
            [temporaryArray addObjectsFromArray:[[DataFetcher sharedInstance] getRestaurantForCarParkValue:[NSNumber numberWithInt:i]]];
            
            double log = 0;
            if ([temporaryArray count]) {
                log =log2((double)[temporaryArray count]/[allRestaurants count]);
            }
            
            hCardPark += -(((double)[temporaryArray count]/[allRestaurants count])+log);
            
            [temporaryArray removeAllObjects];
        }
        NSLog(@"Entropty Car Park %f",hCardPark);
        
    }
    
    
    
    NSDictionary * returnDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithDouble:hCategory],
                                                                           [NSNumber numberWithDouble:hCuisine],
                                                                           [NSNumber numberWithDouble:hLocation],
                                                                           [NSNumber numberWithDouble:hPriceRange],
                                                                           [NSNumber numberWithDouble:hSmoking],
                                                                           [NSNumber numberWithDouble:hGarden],
                                                                           [NSNumber numberWithDouble:hLiveMusic],
                                                                           [NSNumber numberWithDouble:hChildFriendly],
                                                                           [NSNumber numberWithDouble:hVegaterian],
                                                                           [NSNumber numberWithDouble:hCardPark],nil]
                                                                  forKeys:[NSArray arrayWithObjects:kCategory,kCuisine,kLocation,kPrice,kSmoking,kGarden,kLiveMusic,kChildfriendly,kVegetarian,kCarPark, nil]];

    return returnDictionary;
}



@end
