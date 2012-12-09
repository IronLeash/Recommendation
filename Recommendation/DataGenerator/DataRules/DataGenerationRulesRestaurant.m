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
+(Cuisine*)cuisineForCategory:(Category*)aRestaurantCategory{

    int randomNumber = (arc4random() %(100));
    Cuisine *currentCuisine;
    
    if ([aRestaurantCategory.name isEqualToString:kBakery]) {
        
        if (randomNumber < 34) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Turkish"];
        } else if (randomNumber < 67) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Austrian"];
        }else{
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"French"];
        }
        
    } else if ([aRestaurantCategory.name isEqualToString:kBistro]){

        currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"French"];

    }else if ([aRestaurantCategory.name isEqualToString:kBrewPub]){
        
        if (randomNumber < 50) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Irish"];
        } else {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Austrian"];
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCounterService]){
        
        currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"World"];

    }else if ([aRestaurantCategory.name isEqualToString:kCantina]){
        
        if (randomNumber < 26) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Italian"];
        } else if (randomNumber < 51) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"French"];
        }else if (randomNumber < 76 ){
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Austrian"];
        }else{
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Spanish"];
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCoffeehouse]){
        
        if (randomNumber < 30) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Turkish"];
        } else {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Austrian"];
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFastFoodRest]){

        if (randomNumber < 50) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"American"];
        } else {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"World"];
        }
    }else if ([aRestaurantCategory.name isEqualToString:kFineDining]){

        currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"French"];
        
    }else if ([aRestaurantCategory.name isEqualToString:kFoodCourt]){
        
        currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"World"];
        
    }else if ([aRestaurantCategory.name isEqualToString:kHeuriger]){
        
        currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Austrian"];
        
    }else if ([aRestaurantCategory.name isEqualToString:kOsteria]){
        
        currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Italian"];
        
    }else if ([aRestaurantCategory.name isEqualToString:kOuzeriaTavern]){
        
        currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Greek"];
        
    }else if ([aRestaurantCategory.name isEqualToString:kPizzeria]){
        
        currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Italian"];
        
    }else if ([aRestaurantCategory.name isEqualToString:kPub]){
        
        if (randomNumber < 34) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"English"];
        } else if (randomNumber < 67) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Irish"];
        }else{
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Austrian"];
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kRunningSushi]){
        
        if (randomNumber < 30) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Korea"];
        } else if (randomNumber < 70){
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Japan"];
        }else{
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Chinese"];
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSnackBar]){
        
        if (randomNumber < 26) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:kThailand];
        } else if (randomNumber < 51) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:kChinese];
        }else if (randomNumber < 76 ){
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:kTurkish];
        }else{
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:kAustrian];
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSteakHouse]){
        
        if (randomNumber < 50) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Mexica"];
        } else {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Argentina"];
        }
        
    
    }else if ([aRestaurantCategory.name isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 26) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Italian"];
        } else if (randomNumber < 51) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Spanish"];
        }else if (randomNumber < 76 ){
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Turkish"];
        }else{
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Greek"];
        }
        
        
    }else if ([aRestaurantCategory.name isEqualToString:kTakeOut]){
        
        if (randomNumber < 26) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Italian"];
        } else if (randomNumber < 51) {
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Chinese"];
        }else if (randomNumber < 76 ){
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Turkish"];
        }else{
            currentCuisine = [[DataFetcher sharedInstance] getRestaurantCuisineWithName:@"Austrian"];
        }
    }else{
    
        NSLog(@"Not found category");
    
    }
    
    return currentCuisine;
}


#pragma mark - Price for category

+(int)priceForCategory:(Category*)aRestaurantCategory{


    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    if ([aRestaurantCategory.name isEqualToString:kBakery]) {
        
        if (randomNumber < 25) {
            returnValue = 0;
        } else  if (randomNumber < 75){
            returnValue = 1;
        }else{
            returnValue = 2;
        }

    
    } else if ([aRestaurantCategory.name isEqualToString:kBistro]){
        
        if (randomNumber < 25) {
            returnValue = 0;
        } else  if (randomNumber < 75){
            returnValue = 1;
        }else{
            returnValue = 2;
        }

    }else if ([aRestaurantCategory.name isEqualToString:kBrewPub]){
        
        if (randomNumber < 25) {
            returnValue = 0;
        } else  if (randomNumber < 75){
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCounterService]){
        
        if (randomNumber < 25) {
            returnValue = 0;
        } else  if (randomNumber < 75){
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCantina]){
        
        if (randomNumber < 61) {
            returnValue = 1;
        } else  if (randomNumber < 81){
            returnValue = 2;
        }else{
            returnValue = 3;
        }

    }else if ([aRestaurantCategory.name isEqualToString:kCoffeehouse]){
        
        if (randomNumber < 61) {
            returnValue = 1;
        } else  if (randomNumber < 81){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFastFoodRest]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 80){
            returnValue = 1;
        }else{
            returnValue = 2;
        }

    }else if ([aRestaurantCategory.name isEqualToString:kFineDining]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else  if (randomNumber < 65){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFoodCourt]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 70){
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kHeuriger]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 50){
            returnValue = 1;
        }else if (randomNumber < 80){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kOsteria]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 50){
            returnValue = 1;
        }else if (randomNumber < 80){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 50){
            returnValue = 1;
        }else if (randomNumber < 80){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kPizzeria]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 70){
            returnValue = 1;
        }else if (randomNumber < 90){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kPub]){
        
        if (randomNumber < 30) {
            returnValue = 0;
        } else  if (randomNumber < 65){
            returnValue = 1;
        }else if (randomNumber < 88){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kRunningSushi]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 50){
            returnValue = 1;
        }else if (randomNumber < 80){
            returnValue = 2;
        }else{
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSnackBar]){
        
        if (randomNumber < 40) {
            returnValue = 0;
        } else {
            returnValue = 1;
        }
       
    }else if ([aRestaurantCategory.name isEqualToString:kSteakHouse]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else  if (randomNumber < 60){
            returnValue = 2;
        }else {
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSeaFoodRestaurant]){

        if (randomNumber < 20) {
            returnValue = 1;
        } else  if (randomNumber < 50){
            returnValue = 2;
        }else {
            returnValue = 3;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kTakeOut]){
       
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

+(int)gardenForCategory:(Category*)aRestaurantCategory{

    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    if ([aRestaurantCategory.name isEqualToString:kBakery]) {
        
        if (randomNumber < 25) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    } else if ([aRestaurantCategory.name isEqualToString:kBistro]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kBrewPub]){
        
        if (randomNumber < 25) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCounterService]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCantina]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCoffeehouse]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFastFoodRest]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
    }else if ([aRestaurantCategory.name isEqualToString:kFineDining]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFoodCourt]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kHeuriger]){
        
        if (randomNumber < 80) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kOsteria]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kPizzeria]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kPub]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kRunningSushi]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSnackBar]){
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory.name isEqualToString:kSteakHouse]){
        
        if (randomNumber < 20) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 40) {
            returnValue = 1;
        }else{
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kTakeOut]){
        
        returnValue = 0;
        
    }else{
        

        
    }
    
    return returnValue;
}



#pragma mark - Smoking
+(int)smokingForCategory:(Category*)aRestaurantCategory
{
    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory.name isEqualToString:kBakery]) {
        
        if (randomNumber < 40) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
        
    } else if ([aRestaurantCategory.name isEqualToString:kBistro]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kBrewPub]){
        
        if (randomNumber < 5) {
            returnValue = 0;
        } else  if (randomNumber < 70) {
            returnValue = 1;
        }else{
            returnValue = 2;

        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCounterService]){
        
        if (randomNumber < 30) {
            returnValue = 0;
        } else  if (randomNumber < 60) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCantina]){
        
        if (randomNumber < 40) {
            returnValue = 0;
        } else  if (randomNumber < 80) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCoffeehouse]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 80) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFastFoodRest]){
        
        if (randomNumber < 90) {
            returnValue = 0;
        } else  if (randomNumber < 95) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFineDining]){
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory.name isEqualToString:kFoodCourt]){
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory.name isEqualToString:kHeuriger]){
        
        if (randomNumber < 50) {
            returnValue = 1;
        } else {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kOsteria]){
        
        if (randomNumber < 70) {
            returnValue = 1;
        } else {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 50) {
            returnValue = 1;
        } else {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kPizzeria]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else  if (randomNumber < 70) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kPub]){
        
        if (randomNumber < 80) {
            returnValue = 1;
        } else {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kRunningSushi]){
        
        if (randomNumber < 70) {
            returnValue = 0;
        } else  {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSnackBar]){
        
        returnValue = 1;
        
    }else if ([aRestaurantCategory.name isEqualToString:kSteakHouse]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else  {
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  if (randomNumber < 60) {
            returnValue = 1;
        }else{
            returnValue = 2;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kTakeOut]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
    }else{
        
        
    }
    
    return returnValue;


}


+(int)childFriendlyForCategory:(Category*)aRestaurantCategory{

    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory.name isEqualToString:kBakery] ||
        [aRestaurantCategory.name isEqualToString:kBrewPub] ||
        [aRestaurantCategory.name isEqualToString:kPub] ||
        [aRestaurantCategory.name isEqualToString:kSnackBar] ||
        [aRestaurantCategory.name isEqualToString:kBistro] ||
        [aRestaurantCategory.name isEqualToString:kOuzeriaTavern] ||
        [aRestaurantCategory.name isEqualToString:kTakeOut]) {
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory.name isEqualToString:kCounterService] || [aRestaurantCategory.name isEqualToString:kFastFoodRest] || [aRestaurantCategory.name isEqualToString:kFoodCourt] || [aRestaurantCategory.name isEqualToString:kPizzeria] || [aRestaurantCategory.name isEqualToString:kRunningSushi]){
        
        if (randomNumber < 50) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCantina] || [aRestaurantCategory.name isEqualToString:kCoffeehouse] || [aRestaurantCategory.name isEqualToString:kOsteria] || [aRestaurantCategory.name isEqualToString:kSteakHouse] || [aRestaurantCategory.name isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kHeuriger]){
        
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
+(int)carParkForCategory:(Category*)aRestaurantCategory{

    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory.name isEqualToString:kBakery]) {
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    } else if ([aRestaurantCategory.name isEqualToString:kCantina]|| [aRestaurantCategory.name isEqualToString:kBistro] || [aRestaurantCategory.name isEqualToString:kBrewPub] || [aRestaurantCategory.name isEqualToString:kCounterService] || [aRestaurantCategory.name isEqualToString:kFastFoodRest] || [aRestaurantCategory.name isEqualToString:kOsteria] ||
               [aRestaurantCategory.name isEqualToString:kPizzeria] || [aRestaurantCategory.name isEqualToString:kPub] || [aRestaurantCategory.name isEqualToString:kTakeOut]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCoffeehouse] || [aRestaurantCategory.name isEqualToString:kOuzeriaTavern] || [aRestaurantCategory.name isEqualToString:kRunningSushi]){
        
        if (randomNumber < 20) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFineDining] || [aRestaurantCategory.name isEqualToString:kFoodCourt] || [aRestaurantCategory.name isEqualToString:kSteakHouse]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFoodCourt] || [aRestaurantCategory.name isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 40) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kHeuriger]){
        
        if (randomNumber < 70) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSnackBar]){
        
        returnValue = 0;
        
    }else{
        
        
    }
    
    return returnValue;
    
}

#pragma mark - Live Music

+(int)liveMusicForCategory:(Category*)aRestaurantCategory{


    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory.name isEqualToString:kBakery] ||
        [aRestaurantCategory.name isEqualToString:kBistro] ||
        [aRestaurantCategory.name isEqualToString:kCounterService] ||
        [aRestaurantCategory.name isEqualToString:kFastFoodRest] ||
        [aRestaurantCategory.name isEqualToString:kFoodCourt] ||
        [aRestaurantCategory.name isEqualToString:kPizzeria] ||
        [aRestaurantCategory.name isEqualToString:kSnackBar] ||
        [aRestaurantCategory.name isEqualToString:kTakeOut]) {
        
            returnValue = 0;
        
    }else if ([aRestaurantCategory.name isEqualToString:kBrewPub] || [aRestaurantCategory.name isEqualToString:kPub]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCantina] || [aRestaurantCategory.name isEqualToString:kOsteria] || [aRestaurantCategory.name isEqualToString:kSteakHouse]){
        
        if (randomNumber < 15) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCoffeehouse] || [aRestaurantCategory.name isEqualToString:kRunningSushi]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFineDining]){
        
        if (randomNumber < 35) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kHeuriger] || [aRestaurantCategory.name isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 70) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kSeaFoodRestaurant]){
        
        if (randomNumber < 20) {
            returnValue = 1;
        } else {
            returnValue = 0;
        }
        
    }else{
        
        
    }
    
    return returnValue;
    



}


+(int)vegetarianForCategory:(Category*)aRestaurantCategory{


    int randomNumber = (arc4random() %(100));
    int returnValue = 0;
    
    
    if ([aRestaurantCategory.name isEqualToString:kBakery]) {
        
        if (randomNumber < 80) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    } else if ([aRestaurantCategory.name isEqualToString:kBistro] || [aRestaurantCategory.name isEqualToString:kBrewPub]){
        
        if (randomNumber < 10) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCounterService] ||
              [aRestaurantCategory.name isEqualToString:kCantina]){
        
        if (randomNumber < 20) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kCoffeehouse] || [aRestaurantCategory.name isEqualToString:kOsteria] || [aRestaurantCategory.name isEqualToString:kPub]){
        
        if (randomNumber < 20) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFastFoodRest] ||
              [aRestaurantCategory.name isEqualToString:kHeuriger] ||
              [aRestaurantCategory.name isEqualToString:kOuzeriaTavern] || [aRestaurantCategory.name isEqualToString:kSnackBar]||
              [aRestaurantCategory.name isEqualToString:kSteakHouse] || [aRestaurantCategory.name isEqualToString:kSeaFoodRestaurant]){
        
        returnValue = 0;
        
    }else if ([aRestaurantCategory.name isEqualToString:kFineDining]){
        
        if (randomNumber < 40) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kFoodCourt] || [aRestaurantCategory.name isEqualToString:kTakeOut]){
        
        if (randomNumber < 30) {
            returnValue = 1;
        } else  {
            returnValue = 0;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kOuzeriaTavern]){
        
        if (randomNumber < 50) {
            returnValue = 0;
        } else {
            returnValue = 1;
        }
        
    }else if ([aRestaurantCategory.name isEqualToString:kPizzeria]){
        
        returnValue = 1;
        
    }else if ([aRestaurantCategory.name isEqualToString:kRunningSushi]){
        
        if (randomNumber < 70) {
            returnValue = 0;
        } else  {
            returnValue = 1;
        }
        
    }else{
        
        
    }
    
    return returnValue;
    

}

+(int)locationForCategory:(Category*)aRestaurantCategory{

    return 0;
}





@end
