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


-(IBAction)calculateEvaluation:(id)sender{

    [NSThread detachNewThreadSelector:@selector(calculateEvaluationBackThread:) toTarget:self withObject:nil];
}

-(void)calculateEvaluationBackThread:(id)sender{

    double mse = [[EvaluationManager sharedInstance] calculateMSE];
    
    [self performSelectorOnMainThread:@selector(calculateEvaluationBackThreadHandler:) withObject:[NSNumber numberWithDouble:mse] waitUntilDone:NO];
}

-(void)calculateEvaluationBackThreadHandler:(NSNumber*)aNumber{
    
    NSLog(@"MSE : %@",aNumber);
}

@end
