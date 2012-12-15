//
//  DataGenerationRules.m
//  Recommendation
//
//  Created by ilker on 08.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerationRulesRestaurant.h"
#import "DataFetcher.h"

#import "Constants.h"

@implementation DataGenerationRulesRestaurant

#pragma mark - assign cusine to cateogry
+(NSString*)cuisineForCategory:(NSString*)aRestaurantCategory{

    int randomNumber = (arc4random() %(100));
    NSString *currentCuisine;
    
    if ([aRestaurantCategory isEqualToString:kBakery]) {
        
        if (randomNumber < 34) {
            currentCuisine = @"Turkish";
        } else if (randomNumber < 67) {
            currentCuisine = @"Austrian";
        }else{
            currentCuisine = @"French";
        }
        
    } else if ([aRestaurantCategory isEqualToString:kBistro]){

        currentCuisine = @"French";

    }else if ([aRestaurantCategory isEqualToString:kBrewPub]){
        
        if (randomNumber < 50) {
            currentCuisine = @"Irish";
        } else {
            currentCuisine = @"Austrian";
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCounterService]){
        
        currentCuisine = @"World";

    }else if ([aRestaurantCategory isEqualToString:kCantina]){
        
        if (randomNumber < 26) {
            currentCuisine = @"Italian";
        } else if (randomNumber < 51) {
            currentCuisine = @"French";
        }else if (randomNumber < 76 ){
            currentCuisine = @"Austrian";
        }else{
            currentCuisine = @"Spanish";
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCoffeehouse]){
        
        if (randomNumber < 30) {
            currentCuisine = @"Turkish";
        } else {
            currentCuisine = @"Austrian";
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFastFoodRest]){

        if (randomNumber < 50) {
            currentCuisine = @"American";
        } else {
            currentCuisine = @"World";
        }
    }else if ([aRestaurantCategory isEqualToString:kFineDining]){

        currentCuisine = @"French";
        
    }else if ([aRestaurantCategory isEqualToString:kFoodCourt]){
        
        currentCuisine = @"World";
        
    }else if ([aRestaurantCategory isEqualToString:kHeuriger]){
        
        currentCuisine = @"Austrian";
        
    }else if ([aRestaurantCategory isEqualToString:kOsteria]){
        
        currentCuisine = @"Italian";
        
    }else if ([aRestaurantCategory isEqualToString:kOuzeriaTavern]){
        
        currentCuisine = @"Greek";
        
    }else if ([aRestaurantCategory isEqualToString:kPizzeria]){
        
        currentCuisine = @"Italian";
        
    }else if ([aRestaurantCategory isEqualToString:kPub]){
        
        if (randomNumber < 34) {
            currentCuisine = @"English";
        } else if (randomNumber < 67) {
            currentCuisine = @"Irish";
        }else{
            currentCuisine = @"Austrian";
        }
        
    }else if ([aRestaurantCategory isEqualToString:kRunningSushi]){
        
        if (randomNumber < 30) {
            currentCuisine = @"Korea";
        } else if (randomNumber < 70){
            currentCuisine = @"Japan";
        }else{
            currentCuisine = @"Chinese";
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSnackBar]){
        
        if (randomNumber < 26) {
            currentCuisine = kThailand;
        } else if (randomNumber < 51) {
            currentCuisine = kChinese;
        }else if (randomNumber < 76 ){
            currentCuisine = kTurkish;
        }else{
            currentCuisine = kAustrian;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSteakHouse]){
        
        if (randomNumber < 50) {
            currentCuisine = @"Mexica";
        } else {
            currentCuisine = @"Argentina";
        }
        
    
    }else if ([aRestaurantCategory isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 26) {
            currentCuisine = @"Italian";
        } else if (randomNumber < 51) {
            currentCuisine = @"Spanish";
        }else if (randomNumber < 76 ){
            currentCuisine = @"Turkish";
        }else{
            currentCuisine = @"Greek";
        }
        
        
    }else if ([aRestaurantCategory isEqualToString:kTakeOut]){
        
        if (randomNumber < 26) {
            currentCuisine  = kItalian;
        } else if (randomNumber < 51) {
            currentCuisine  = kChinese;
        }else if (randomNumber < 76 ){
            currentCuisine = @"Turkish";
        }else{
            currentCuisine = @"Austrian";
        }
    }else{
    
        NSLog(@"Not found category");
    
    }
    
    return currentCuisine;
}


#pragma mark - Price for category

+(int)priceForCategory:(NSString*)aRestaurantCategory{


    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    if ([aRestaurantCategory isEqualToString:kBakery]) {
        
        if (randomNumber < 25) {
            returnValue = 0;
        } else  if (randomNumber < 75){
            returnValue = 1;
        }else{
            returnValue = 2;
        }

    
    } else if ([aRestaurantCategory isEqualToString:kBistro]){
        
        if (randomNumber < 25) {
            returnValue = 0;
        } else  if (randomNumber < 75){
            returnValue = 1;
        }else{
            returnValue = 2;
        }

    }else if ([aRestaurantCategory isEqualToString:kBrewPub]){
        
        if (randomNumber < 25) {
            returnValue = 0;
        } else  if (randomNumber < 75){
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCounterService]){
        
        if (randomNumber < 25) {
            returnValue = 0;
        } else  if (randomNumber < 75){
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCantina]){
        
        if (randomNumber < 61) {
            returnValue = 1;
        } else  if (randomNumber < 81){
            returnValue = 2;
        }else{
            returnValue = 3;
        }

    }else if ([aRestaurantCategory isEqualToString:kCoffeehouse]){
        
        if (randomNumber < 61) {
            returnValue = 1;
        } else  if (randomNumber < 81){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFastFoodRest]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 80){
            returnValue = 1;
        }else{
            returnValue = 2;
        }

    }else if ([aRestaurantCategory isEqualToString:kFineDining]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else  if (randomNumber < 65){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFoodCourt]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 70){
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kHeuriger]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 50){
            returnValue = 1;
        }else if (randomNumber < 80){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kOsteria]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 50){
            returnValue = 1;
        }else if (randomNumber < 80){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 50){
            returnValue = 1;
        }else if (randomNumber < 80){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kPizzeria]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 70){
            returnValue = 1;
        }else if (randomNumber < 90){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kPub]){
        
        if (randomNumber < 30) {
            returnValue = 0;
        } else  if (randomNumber < 65){
            returnValue = 1;
        }else if (randomNumber < 88){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kRunningSushi]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 50){
            returnValue = 1;
        }else if (randomNumber < 80){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSnackBar]){
        
        if (randomNumber < 40) {
            returnValue = 0;
        } else {
            returnValue = 1;
        }
       
    }else if ([aRestaurantCategory isEqualToString:kSteakHouse]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else  if (randomNumber < 60){
            returnValue = 2;
        }else {
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSeaFoodRestaurant]){

        if (randomNumber < 20) {
            returnValue = 1;
        } else  if (randomNumber < 50){
            returnValue = 2;
        }else {
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kTakeOut]){
       
        if (randomNumber < 30) {
            returnValue = 0;
        } else  if (randomNumber < 79){
            returnValue = 1;
        }else {
            returnValue = 2;
        }
        
    }else{
        
        NSLog(@"Not found price");
        
    }
    
    return returnValue;
    
}

#pragma mark - Garden for Restaurant

+(int)gardenForCategory:(NSString*)aRestaurantCategory{

    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    if ([aRestaurantCategory isEqualToString:kBakery]) {
        
        if (randomNumber < 25) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    } else if ([aRestaurantCategory isEqualToString:kBistro]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kBrewPub]){
        
        if (randomNumber < 25) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCounterService]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCantina]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCoffeehouse]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFastFoodRest]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
    }else if ([aRestaurantCategory isEqualToString:kFineDining]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFoodCourt]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kHeuriger]){
        
        if (randomNumber < 80) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kOsteria]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kPizzeria]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kPub]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kRunningSushi]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSnackBar]){
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory isEqualToString:kSteakHouse]){
        
        if (randomNumber < 20) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 40) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kTakeOut]){
        
        returnValue = 0;
        
    }else{
        

        
    }
    
    return returnValue;
}



#pragma mark - Smoking
+(int)smokingForCategory:(NSString*)aRestaurantCategory
{
    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory isEqualToString:kBakery]) {
        
        if (randomNumber < 40) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
        
    } else if ([aRestaurantCategory isEqualToString:kBistro]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kBrewPub]){
        
        if (randomNumber < 5) {
            returnValue = 0;
        } else  if (randomNumber < 70) {
            returnValue = 1;
        }else{
            returnValue = 2;

        }
        
    }else if ([aRestaurantCategory isEqualToString:kCounterService]){
        
        if (randomNumber < 30) {
            returnValue = 0;
        } else  if (randomNumber < 60) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCantina]){
        
        if (randomNumber < 40) {
            returnValue = 0;
        } else  if (randomNumber < 80) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCoffeehouse]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 80) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFastFoodRest]){
        
        if (randomNumber < 90) {
            returnValue = 0;
        } else  if (randomNumber < 95) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFineDining]){
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory isEqualToString:kFoodCourt]){
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory isEqualToString:kHeuriger]){
        
        if (randomNumber < 50) {
            returnValue = 1;
        } else {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kOsteria]){
        
        if (randomNumber < 70) {
            returnValue = 1;
        } else {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 50) {
            returnValue = 1;
        } else {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kPizzeria]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else  if (randomNumber < 70) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kPub]){
        
        if (randomNumber < 80) {
            returnValue = 1;
        } else {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kRunningSushi]){
        
        if (randomNumber < 70) {
            returnValue = 0;
        } else  {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSnackBar]){
        
        returnValue = 1;
        
    }else if ([aRestaurantCategory isEqualToString:kSteakHouse]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else  {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 60) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kTakeOut]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
    }else{
        
        
    }
    
    return returnValue;


}


+(int)childFriendlyForCategory:(NSString*)aRestaurantCategory{

    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory isEqualToString:kBakery] ||
        [aRestaurantCategory isEqualToString:kBrewPub] ||
        [aRestaurantCategory isEqualToString:kPub] ||
        [aRestaurantCategory isEqualToString:kSnackBar] ||
        [aRestaurantCategory isEqualToString:kBistro] ||
        [aRestaurantCategory isEqualToString:kOuzeriaTavern] ||
        [aRestaurantCategory isEqualToString:kTakeOut]) {
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory isEqualToString:kCounterService] || [aRestaurantCategory isEqualToString:kFastFoodRest] || [aRestaurantCategory isEqualToString:kFoodCourt] || [aRestaurantCategory isEqualToString:kPizzeria] || [aRestaurantCategory isEqualToString:kRunningSushi]){
        
        if (randomNumber < 50) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCantina] || [aRestaurantCategory isEqualToString:kCoffeehouse] || [aRestaurantCategory isEqualToString:kOsteria] || [aRestaurantCategory isEqualToString:kSteakHouse] || [aRestaurantCategory isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kHeuriger]){
        
        if (randomNumber < 80) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else{
        
        
    }
    
    return returnValue;


}

#pragma mark - Car Park

#warning extend this with location parameter city centeler locales less park place ant outer ones more.
+(int)carParkForCategory:(NSString*)aRestaurantCategory{

    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory isEqualToString:kBakery]) {
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    } else if ([aRestaurantCategory isEqualToString:kCantina]|| [aRestaurantCategory isEqualToString:kBistro] || [aRestaurantCategory isEqualToString:kBrewPub] || [aRestaurantCategory isEqualToString:kCounterService] || [aRestaurantCategory isEqualToString:kFastFoodRest] || [aRestaurantCategory isEqualToString:kOsteria] ||
               [aRestaurantCategory isEqualToString:kPizzeria] || [aRestaurantCategory isEqualToString:kPub] || [aRestaurantCategory isEqualToString:kTakeOut]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCoffeehouse] || [aRestaurantCategory isEqualToString:kOuzeriaTavern] || [aRestaurantCategory isEqualToString:kRunningSushi]){
        
        if (randomNumber < 20) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFineDining] || [aRestaurantCategory isEqualToString:kFoodCourt] || [aRestaurantCategory isEqualToString:kSteakHouse]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFoodCourt] || [aRestaurantCategory isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 40) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kHeuriger]){
        
        if (randomNumber < 70) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSnackBar]){
        
        returnValue = 0;
        
    }else{
        
        
    }
    
    return returnValue;
    
}

#pragma mark - Live Music

+(int)liveMusicForCategory:(NSString*)aRestaurantCategory{


    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory isEqualToString:kBakery] ||
        [aRestaurantCategory isEqualToString:kBistro] ||
        [aRestaurantCategory isEqualToString:kCounterService] ||
        [aRestaurantCategory isEqualToString:kFastFoodRest] ||
        [aRestaurantCategory isEqualToString:kFoodCourt] ||
        [aRestaurantCategory isEqualToString:kPizzeria] ||
        [aRestaurantCategory isEqualToString:kSnackBar] ||
        [aRestaurantCategory isEqualToString:kTakeOut]) {
        
            returnValue = 0;
        
    }else if ([aRestaurantCategory isEqualToString:kBrewPub] || [aRestaurantCategory isEqualToString:kPub]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCantina] || [aRestaurantCategory isEqualToString:kOsteria] || [aRestaurantCategory isEqualToString:kSteakHouse]){
        
        if (randomNumber < 15) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCoffeehouse] || [aRestaurantCategory isEqualToString:kRunningSushi]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFineDining]){
        
        if (randomNumber < 35) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kHeuriger] || [aRestaurantCategory isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 70) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 20) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else{
        
        
    }
    
    return returnValue;
    

}

+(int)vegetarianForCategory:(NSString*)aRestaurantCategory{


    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory isEqualToString:kBakery]) {
        
        if (randomNumber < 80) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    } else if ([aRestaurantCategory isEqualToString:kBistro] || [aRestaurantCategory isEqualToString:kBrewPub]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCounterService] ||
              [aRestaurantCategory isEqualToString:kCantina]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kCoffeehouse] || [aRestaurantCategory isEqualToString:kOsteria] || [aRestaurantCategory isEqualToString:kPub]){
        
        if (randomNumber < 20) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFastFoodRest] ||
              [aRestaurantCategory isEqualToString:kHeuriger] ||
              [aRestaurantCategory isEqualToString:kOuzeriaTavern] || [aRestaurantCategory isEqualToString:kSnackBar]||
              [aRestaurantCategory isEqualToString:kSteakHouse] || [aRestaurantCategory isEqualToString:kSeaFoodRestaurant]){
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory isEqualToString:kFineDining]){
        
        if (randomNumber < 40) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kFoodCourt] || [aRestaurantCategory isEqualToString:kTakeOut]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else {
            returnValue = 1;
        }
        
    }else if ([aRestaurantCategory isEqualToString:kPizzeria]){
        
        returnValue = 1;
        
    }else if ([aRestaurantCategory isEqualToString:kRunningSushi]){
        
        if (randomNumber < 70) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
        
    }else{
        
        
    }
    
    return returnValue;
    

}

+(int)locationForCategory:(NSString*)aRestaurantCategory{

    return 0;
}


@end
