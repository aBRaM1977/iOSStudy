//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Yuefeng LU on 6/27/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "CalculatorViewController.h"
//#import <Foundation/Foundation.h>


@interface CalculatorViewController()
@property (readonly) CalculatorBrain * brain;
@end



@implementation CalculatorViewController


-(CalculatorBrain *)brain
{
	if (!brain) brain = [ [CalculatorBrain alloc] init ];
	return brain;
}

-(IBAction) digiPress:(UIButton *)sender
{
	NSString *digit = [ [sender titleLabel] text ];
	
	if ( [@"π" isEqual: digit]) {
		display.text = [NSString stringWithFormat:@"%g", 3.141592653];
		userIsInTheMiddleOfTypingANumber = YES;
	}
	else if (userIsInTheMiddleOfTypingANumber) {
		if ( [@"." isEqual: digit]) {
			if ( ! pointHasBeenPressed ) {
				pointHasBeenPressed = YES;
				display.text = [display.text stringByAppendingString: digit];
			}
		}
		else if ([@"<" isEqual:digit]) {
			if ([display.text length] < 2) {
				display.text = [NSString stringWithFormat:@"%d",0];
				userIsInTheMiddleOfTypingANumber = NO;
			}
			else {
				display.text = [display.text substringToIndex:([display.text length]-1)];
			}
		}
		else {
			display.text = [display.text stringByAppendingString: digit];
		}
	}
	else {
		if ([@"<" isEqual:digit]) {
			if ([display.text length] < 2) {
				display.text = [NSString stringWithFormat:@"%d",0];
			}
			else {
				display.text = [display.text substringToIndex:([display.text length]-1)];
			}
		}
		else{
			display.text = digit;
			userIsInTheMiddleOfTypingANumber = YES;
		}
		if ( [@"." isEqual: digit] ) {
			pointHasBeenPressed = YES;
		}
	}
	
	//NSLog(@"Test logging: string: %@, integer: %d", @"pressed once  !! ", 7);

}


-(IBAction) operPress:(UIButton *)sender
{
	NSString *operation = [ [sender titleLabel] text];
	if (userIsInTheMiddleOfTypingANumber) {
		self.brain.operand = [display.text doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
		pointHasBeenPressed = NO;
	}
	
	//double result = [ [self brain] performOperation: operation ];
	display.text = [ NSString stringWithFormat:@"%g", [self.brain  performOperation :operation ]];
	if ([@"store" isEqual: operation] || [ @"M+" isEqual: operation]) {
		storeDisplay.text = @"M";
		storedNumber.text = [NSString stringWithFormat:@"%g", self.brain.storedOperand];
	}
	else if([@"MC" isEqual: operation]) {
		storeDisplay.text = nil;
		storedNumber.text = nil;
	}
}



@end
