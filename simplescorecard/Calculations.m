//
//  Calculations.m
//  SimpleScoreCard
//
//  Created by Robert Figueras on 8/5/14.
//
//

#import "Calculations.h"

@implementation Calculations

-(int) calculateTotal:(NSArray *)array
{
    int total = 0;
    for (NSNumber *eachNumber in array) {
        total = total + [eachNumber intValue];
    }
    return total;
}

-(NSString *) calculatePar:(int)par minusScore:(int)score
{
    NSString *returnString = @"E";

    int plusMinus = score - par;

    if (plusMinus<0)
    {
        returnString = [NSString stringWithFormat:@"%i", plusMinus];
    }
    else if (plusMinus>0)
    {
        returnString = [NSString stringWithFormat:@"+%i", plusMinus];
    }

    return returnString;
}


-(NSString *) scoreNameForScore:(int)score andPar:(int)par
{

    NSString *scorePickerLabel = @"Select score";

    int delta = score - par;

    if (!par)
    {
        scorePickerLabel = [NSString stringWithFormat:@"%i",score];
    }
    else if (score>0)
    {
        scorePickerLabel = [NSString stringWithFormat:@"%i   %i",score, delta];

        if (delta == -3)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Double Eagle",score];
        }
        else if (delta == -2)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Eagle",score];
        }
        else if (delta == -1)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Birdie",score];
        }
        else if (delta == 0)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Par",score];
        }
        else if (delta == 1)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Bogie",score];
        }
        else if (delta == 2)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Double Bogie",score];
        }
    }

    return scorePickerLabel;
}


@end
