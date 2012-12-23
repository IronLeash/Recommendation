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
#import "ActionGeneric.h"

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


+ (double)cramersVforAttribute:(NSArray*)anArray{

    
    [ActionGeneric printContigencyMatrix:anArray];
    /*
    NSArray *row1 = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:11],
                      [NSNumber numberWithFloat:4], nil];
    
    NSArray *row2 = [NSArray arrayWithObjects:
                           
                           [NSNumber numberWithFloat:3],
                       [NSNumber numberWithFloat:8], nil];
    
    NSArray *contigencyTableArray =[NSArray arrayWithObjects:row1,row2, nil];
    int degree = 1;
    */
//    double gsl_ran_chisq = gsl_ran_chisq (const gsl_rng * r, degree);
    
    long degree = MIN([anArray count]-1, [[anArray objectAtIndex:0] count]-1);
    float chiSquare = 0;
    double totalOccurences = 0;
    
    int colomnTotal = 0;
    int rowTotal = 0;
    NSMutableArray *marginalFrequencyRow = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *marginalFrequencyColomn = [[NSMutableArray alloc] initWithCapacity:0];

    
    NSUInteger numberOfColomns = [anArray count];
    NSUInteger numberOfRows = [[anArray objectAtIndex:0] count];
    
        //Iterate over the colomns
    for (int colomn=0; colomn < numberOfColomns; colomn++) {

        for (int row = 0; row <numberOfRows; row++)
        {
            colomnTotal +=[[[anArray objectAtIndex:colomn] objectAtIndex:row] intValue];
        }
        totalOccurences += colomnTotal;
        [marginalFrequencyColomn addObject:[NSNumber numberWithInt:colomnTotal]];
        colomnTotal = 0;
    }
    
    
    //Iterate over the rows
    for (int row=0; row < numberOfRows; row++) {
        
        for (int colomn = 0; colomn <numberOfColomns; colomn++)
        {
            rowTotal += [[[anArray objectAtIndex:colomn] objectAtIndex:row] intValue];
        }
        [marginalFrequencyRow addObject:[NSNumber numberWithInt:rowTotal]];
        rowTotal  = 0;
    }
    
    for (int colomn=0; colomn < numberOfColomns; colomn++) {
        
        for (int row = 0; row < numberOfRows; row++)
        {
            double expected = (double)(([[marginalFrequencyColomn objectAtIndex:colomn] doubleValue] * [[marginalFrequencyRow objectAtIndex:row] doubleValue])/totalOccurences);
            NSLog(@"Expected %f",expected);
            /*
            chiSquare += (([[[anArray objectAtIndex:colomn] objectAtIndex:row] doubleValue]-expected)*([[[anArray objectAtIndex:colomn] objectAtIndex:row] doubleValue]-expected))/expected;
            */
            
            if (expected>0) {
                chiSquare += pow([[[anArray objectAtIndex:colomn] objectAtIndex:row] floatValue]-expected, 2.0)/expected;
                
                
                
                NSLog(@"O %@",[[anArray objectAtIndex:colomn] objectAtIndex:row]);
                NSLog(@"O %f",[[[anArray objectAtIndex:colomn] objectAtIndex:row] doubleValue]-expected);
                
                NSLog(@"Chi %f",chiSquare);
            }
            
        }
    }
    
    double cramersV = sqrt(chiSquare / (totalOccurences*degree));
    NSLog(@"Cramer %f",cramersV);
    return cramersV;
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
        NSLog(@"Entropty Vegaterian %f",hVegaterian);

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
                                                                  forKeys:[NSArray arrayWithObjects:kCategory,kCuisine,kLocation,kPrice,kSmoking,kGarden,kLiveMusic,kChildfriendly,kVegaterian,kCarPark, nil]];

    return returnDictionary;
}



@end
