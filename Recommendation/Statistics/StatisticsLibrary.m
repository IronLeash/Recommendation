//
//  StatisticsLibrary.m
//  Recommendation
//
//  Created by ilker on 24.11.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerator.h"
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




@end
