//
//  AttributeValueConverter.m
//  Recommendation
//
//  Created by ilker on 16.01.13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import "AttributeValueConverter.h"
#import "Constants.h"

#import "FavoriteSmoking.h"
#import "FavoriteCategory.h"
#import "FavoriteCuisine.h"

@implementation AttributeValueConverter

+(NSString*)priceValueRepresentation:(NSNumber*)aNumber{

    int number = [aNumber intValue];
    NSString *returnString;
    if (number == 0) {
        returnString = @"Low";
    }else if (number == 1){
        returnString = @"Normal";
    }else if (number == 2){
        returnString = @"Above Average";
    }else{
        returnString = @"Luxus";
    }
    
    return returnString;
}

+(NSString*)smoingValueRepresentation:(NSNumber*)aNumber{

    int number = [aNumber intValue];
    NSString *returnString;
    if (number == 0) {
        returnString = @"Seperate";
    }else if (number == 1){
        returnString = @"YES";
    }else if (number == 2){
        returnString = @"NO";
    }
    
    return returnString;
}


+(NSString*)smokerValue:(NSNumber*)aNumber{
    
    int number = [aNumber intValue];
    NSString *returnString;
    if (number == 0) {
        returnString = @"non-smoker";
    }else{
        returnString = @"smoker";
    }
    return returnString;
}


+(NSString*)vegaterianVaue:(NSNumber*)aNumber{
    
    int number = [aNumber intValue];
    NSString *returnString;
    if (number == 0) {
        returnString = @"non-vegaterian";
    }else{
        returnString = @"vegaterian";
    }
    return returnString;
}


+(NSString*)userDescription:(User*)anUser{
        
    NSString *description = [NSString stringWithFormat:@"Current user is %@. User lives in %@. district.User is a %@.",anUser.userid,
                             anUser.location,
                             [AttributeValueConverter smokerValue:anUser.smoker]];

    return description;
}

+(NSString*)userPreferencesDescription:(NSDictionary*)prefrencesDictionary{
    
#warning check if remaining elemensts are significant enough
    
    NSMutableString *preferencesDescriptionString  = [[NSMutableString alloc] initWithString:@"User's favorite restaurant categories are ; "];
    
    NSMutableArray *favoriteCategories = [[NSMutableArray alloc] initWithArray:[prefrencesDictionary objectForKey:kCategory]];
    //Remove all elements but first three
    [favoriteCategories removeObjectsInRange: NSMakeRange(3, [favoriteCategories count]-3)];

    
    for (int i = 0; i < [favoriteCategories count]; i++) {
        
    [preferencesDescriptionString appendString:[(FavoriteCategory*)[favoriteCategories objectAtIndex:i] name]];

        if (i+1 == [favoriteCategories count]) {
            [preferencesDescriptionString appendString:@".\n"];
        }else{
            [preferencesDescriptionString appendString:@","];
        }
    }
    
    NSMutableArray *favoriteCuisines = [[NSMutableArray alloc] initWithArray:[prefrencesDictionary objectForKey:kCuisine]];
    //Remove all elements but first three
    [favoriteCuisines removeObjectsInRange: NSMakeRange(3, [favoriteCuisines count]-3)];
    
    [preferencesDescriptionString appendString:@"User likes mostly "];
    for (int i = 0; i < [favoriteCuisines count]; i++) {
        
        [preferencesDescriptionString appendString:[(FavoriteCategory*)[favoriteCuisines objectAtIndex:i] name]];
        
        if (i+1 == [favoriteCuisines count]) {
            [preferencesDescriptionString appendString:@" cuisines.\n"];
        }else{
            [preferencesDescriptionString appendString:@","];
        }
    }

//    FavoriteSmoking *favoriteSoking = [prefrencesDictionary objectForKey:kSmoking];
//    [preferencesDescriptionString appendString:[AttributeValueConverter interpratateSmoking:[prefrencesDictionary objectForKey:kSmoking]]];

    
    double carPark                  = [[prefrencesDictionary objectForKey:kCarPark] doubleValue];
    [preferencesDescriptionString appendString:[AttributeValueConverter carParkInterPretation:carPark]];

    double childFriendly            = [[prefrencesDictionary objectForKey:kChildfriendly] doubleValue];
    [preferencesDescriptionString appendString:[AttributeValueConverter interpretateChildFriendly:childFriendly]];
    
    double garden                   = [[prefrencesDictionary objectForKey:kGarden] doubleValue];
    [preferencesDescriptionString appendString:[AttributeValueConverter interpretateGarden:garden]];
    
    double liveMusic                = [[prefrencesDictionary objectForKey:kLiveMusic] doubleValue];
    [preferencesDescriptionString appendString:[AttributeValueConverter interpretateLiveMusic:liveMusic]];
    
    double price                    = [[prefrencesDictionary objectForKey:kPrice] doubleValue];
    [preferencesDescriptionString appendString:[AttributeValueConverter interpretatePrice:price]];
    
    double vegaterian               = [[prefrencesDictionary objectForKey:kVegaterian] doubleValue];
    [preferencesDescriptionString appendString:[AttributeValueConverter interpretateVegaterian:vegaterian]];
    
//    NSMutableString *decriptionString = [[NSMutableString alloc] initWithString:@""];
    
    return preferencesDescriptionString;
}


+(NSString*)interpratateSmoking:(NSArray*)smokingArray
{
    /*
    NSMutableString *returnString = [[NSMutableString alloc] initWithString:@"User preferes "];
    
    for (int i = 0; i < [smokingArray count]; i++) {
        
        FavoriteSmoking *currentSmoking = [smokingArray objectAtIndex:i];
        
        if ([currentSmoking.value intValue] ==0) {
            
        }else if ([currentSmoking.value intValue] == 1){
        
        }else{
        
        }


    }
     
     */
}



+(NSString*)carParkInterPretation:(double)carPark{
    NSString *returnString;
    
    if (carPark<0.3) {
        returnString= @"Car park is not needed or desired by the user.\n";
    }else if (carPark > 0.3 && carPark < 0.6){
        returnString= @"Carpark is nice to have.\n";
    }else{
        returnString= @"User prefers restrautns with park opportunately.\n";
    }
    return returnString;
    
}

+(NSString*)interpretateChildFriendly:(double)childFiendly{
    NSString *returnString;
    
    if (childFiendly<0.3) {
        returnString= @"User does not prefer childFriendly places.\n";
    }else if (childFiendly > 0.3 && childFiendly < 0.6){
        returnString= @"Childfriendship is not a significant factor.\n";
    }else{
        returnString= @"User prefers childfriednly locales.\n";
    }
    return returnString;
    
}

+(NSString*)interpretateGarden:(double)gardenValue{
    NSString *returnString;
    
    if (gardenValue<0.3) {
        returnString= @"User does not prefer locales with garden.\n";
    }else if (gardenValue > 0.3 && gardenValue < 0.6){
        returnString= @"User does not take garden into consideration.\n";
    }else{
        returnString= @"User likes locases with garden.\n";
    }
    return returnString;

}


+(NSString*)interpretateLiveMusic:(double)liveMusic{

    NSString *returnString;

    if (liveMusic<3) {
        returnString= @"User does not prefer locales with live music.\n";
    }else if (liveMusic > 3 && liveMusic < 6){
        returnString= @"Live music is not significat for the user.\n";
    }else{
        returnString= @"User likes restaurants with live music performance.\n";
    }
    return returnString;
}

+(NSString*)interpretateVegaterian:(double)vegValue{
#warning refactor this
    NSString *returnString;
    
    if (vegValue < 0.1)
    {
        returnString = @"User dislikes vegaterian restautants.\n";
    }else if (vegValue > 0.7){
    
        returnString = @"User prefers vegaterian restautants.\n";
    }else if (vegValue > 0.4 && vegValue < 0.7)
    {
        returnString = @"Vegaterian or not is not a significant distinguishing factor.\n";
    }else if (vegValue < 0.4)
    {
        returnString = @"User has tendency to non vegaterian restaurants\n";
    }
    return returnString;
}

+(NSString*)interpretatePrice:(double)priceValue{
    
    NSString *returnString;
    
    if (priceValue < 0)
    {
        returnString = [NSString stringWithFormat:@"User is cheap restaurant oriented.(%f)\n",priceValue];
    }else if (priceValue < 1){
        returnString = [NSString stringWithFormat:@"User is cheap/normal priced restaurant oriented.(%f)\n",priceValue];
    }else if (priceValue < 2)
    {
        returnString = [NSString stringWithFormat:@"User is normal/above average priced restaurant oriented.(%f)\n",priceValue];
    }else if (priceValue < 3)
    {
        returnString = [NSString stringWithFormat:@"Userhas tendency to luxury restaurants.(%f)\n",priceValue];
    }
    return returnString;
}



+(NSString*)genderName:(NSNumber*)aNumber{

    NSString *sexString;
    int number = [aNumber intValue];
    
    if (number==0)
    {
        sexString = @"Female";
    }else{
        sexString = @"Male";
    }
    return sexString;
}

@end
