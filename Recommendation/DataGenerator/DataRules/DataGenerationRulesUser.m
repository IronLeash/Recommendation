//
//  DataGenerationRulesUser.m
//  Recommendation
//
//  Created by ilker on 10.12.12.
//  Copyright (c) 2012 ilker. All rights reserved.
//

#import "DataGenerationRulesUser.h"

#import "Constants.h"


@implementation DataGenerationRulesUser

+(int)userAgePredictionFor:(NSString*)userStereotype{

    int age = arc4random() %(2);
    
    if ([userStereotype isEqualToString:kStudent])
    {
        //18-30
        age = (arc4random() %(12))+18;
    }else if([userStereotype isEqualToString:kAmbianceLover]){
        age = (arc4random() %(30))+30;
    }else if([userStereotype isEqualToString:kGourmet]){
        //30-60
        age = (arc4random() %(30))+30;
    }else if([userStereotype isEqualToString:kFamily]){
        age = (arc4random() %(30))+30;
    }else if([userStereotype isEqualToString:kVegaterian]){
        age = (arc4random() %(50))+15;
    }else{
    //Tourist
        age = (arc4random() %(50))+20;
    }
    return age;
}

/*
+(int)userLocationPredictionFor:(NSString*)userStereotype{


}
*/

+(int)userSmokingPredictionFor:(NSString*)userStereotype{

    int smoking = arc4random() %(100);
    
    if ([userStereotype isEqualToString:kStudent])
    {
        if (smoking > 51) {
            smoking = 1;
        } else {
            smoking = 0;
        }
        
    }else if([userStereotype isEqualToString:kAmbianceLover]){

        if (smoking > 70) {
            smoking = 1;
        } else {
            smoking = 0;
        }
    }else if([userStereotype isEqualToString:kGourmet]){
        
        if (smoking > 85) {
            smoking = 1;
        } else {
            smoking = 0;
        }

    }else if([userStereotype isEqualToString:kFamily]){

        if (smoking > 75) {
            smoking = 1;
        } else {
            smoking = 0;
        }
        
    }else if([userStereotype isEqualToString:kVegaterian]){

        if (smoking > 65) {
            smoking = 1;
        } else {
            smoking = 0;
        }
        
    }else{
        
        if (smoking > 65) {
            smoking = 1;
        } else {
            smoking = 0;
        }
    }
    
    return smoking;
}

+(int)userVegetarianPredictionFor:(NSString*)userStereotype{

    int vegateriean = arc4random() % 100;

    if ([userStereotype isEqualToString:kVegaterian])
    {
        vegateriean = 1;
    }else if (vegateriean > 90) {
        vegateriean = 1;
    } else {
        vegateriean = 0;
    }
    return vegateriean;
}

@end
