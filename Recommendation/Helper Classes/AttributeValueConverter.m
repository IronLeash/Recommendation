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
        
    NSString *description = [NSString stringWithFormat:@"Current user is %@ (%@). User is %@ years old and lives in %@. district.User is a %@ and %@.",anUser.userid,
                             [AttributeValueConverter genderName:anUser.gender]
                             ,anUser.age,
                             anUser.location,
                             [AttributeValueConverter smokerValue:anUser.smoker],
                             [AttributeValueConverter vegaterianVaue:anUser.vegaterian]];

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
    [favoriteCuisines removeObjectsInRange: NSMakeRange(3, [favoriteCategories count]-3)];
    
    for (int i = 0; i < [favoriteCuisines count]; i++) {
        
        [preferencesDescriptionString appendString:[(FavoriteCategory*)[favoriteCuisines objectAtIndex:i] name]];
        
        if (i+1 == [favoriteCuisines count]) {
            [preferencesDescriptionString appendString:@".\n"];
        }else{
            [preferencesDescriptionString appendString:@","];
        }
    }


    FavoriteSmoking *favoriteSoking = [prefrencesDictionary objectForKey:kSmoking];
    double childFriendly            = [[prefrencesDictionary objectForKey:kChildfriendly] doubleValue];
    double garden                   = [[prefrencesDictionary objectForKey:kGarden] doubleValue];
    double liveMusic                = [[prefrencesDictionary objectForKey:kLiveMusic] doubleValue];
    double price                    = [[prefrencesDictionary objectForKey:kPrice] doubleValue];
    double vegaterian               = [[prefrencesDictionary objectForKey:kVegaterian] doubleValue];

    
    NSMutableString *decriptionString = [[NSMutableString alloc] initWithString:@""];
    
    return decriptionString;
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
