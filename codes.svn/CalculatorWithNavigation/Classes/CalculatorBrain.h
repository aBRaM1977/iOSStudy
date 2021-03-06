//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Yuefeng LU on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
	
@private
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	double storedOperand;
}

//-(void)setOperand: (double)aDboule;
@property double operand;
@property double storedOperand;

-(double)performOperation: (NSString *)operation;
-(double)performWaitingOperation;

@end
