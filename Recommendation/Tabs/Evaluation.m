//
//  Evaluation.m
//  Recommendation
//
//  Created by Ilker Baltaci on 1/9/13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import "Evaluation.h"
#import "EvaluationManager.h"
@implementation Evaluation
@synthesize evaluationButton;


-(void)awakeFromNib{
    positiveRatingThreshold.delegate = self;
}


-(IBAction)calculateEvaluation:(id)sender{

    NSLog(@"Stated Evaluation Calculation......");
    [NSThread detachNewThreadSelector:@selector(calculateEvaluationBackThread:) toTarget:self withObject:nil];
}

-(void)calculateEvaluationBackThread:(id)sender{

    double rmse = [[EvaluationManager sharedInstance] calculateRMSE];
    
    [self performSelectorOnMainThread:@selector(calculateEvaluationBackThreadHandler:) withObject:[NSNumber numberWithDouble:rmse] waitUntilDone:NO];
}

-(void)calculateEvaluationBackThreadHandler:(NSNumber*)aNumber{
    
#warning write to a file

    NSLog(@"RMSE : %@",aNumber);
    NSLog(@"MSE : %f",[[EvaluationManager sharedInstance] calculateMSE]);

    NSLog(@"Presicion : %f",[[EvaluationManager sharedInstance] calculatePresicion]);
    NSLog(@"Recall : %f",[[EvaluationManager sharedInstance] calculateRecall]);

}



- (void) controlTextDidChange: (NSNotification *) notification
{
    double currentNumner = [[positiveRatingThreshold stringValue] doubleValue];
    
    [[EvaluationManager sharedInstance] setPositiveRatingThreshold:currentNumner];
}

@end
