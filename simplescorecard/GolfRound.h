//
//  GolfRound.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 7/30/14.
//
//

#import <Foundation/Foundation.h>

@interface GolfRound : NSObject

@property (nonatomic, strong) NSString *golfCourseName;
@property (nonatomic, strong) NSDate *roundDate;

@property (nonatomic, strong) NSString *teeBox;

@property (nonatomic, strong) NSMutableArray *holeScores; // array of NSNumbers
@property (nonatomic, strong) NSMutableArray *holePars; // array of NSNumbers

@property NSInteger *totalScore;

@end
