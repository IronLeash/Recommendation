//
//  Evaluation.h
//  Recommendation
//
//  Created by Ilker Baltaci on 1/9/13.
//  Copyright (c) 2013 ilker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Evaluation : NSObject <NSTextFieldDelegate>
{
    NSString *positiveRatingThresholdString;
    IBOutlet NSTextField *positiveRatingThreshold;

}



-(IBAction)calculateEvaluation:(id)sender;

@property (weak) IBOutlet NSTabView *evaluationButton;

@end
