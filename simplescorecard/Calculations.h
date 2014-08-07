//
//  Calculations.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 8/5/14.
//
//

#import <Foundation/Foundation.h>

@interface Calculations : NSObject

-(int) calculateTotal:(NSArray *)array;
-(NSString *) calculatePar:(int)par minusScore:(int)score;
-(NSString *) scoreNameForScore:(int) score andPar:(int)par;
@end
