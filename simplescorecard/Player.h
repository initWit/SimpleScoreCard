//
//  Player.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 8/10/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Round, Score;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * playerName;
@property (nonatomic, retain) NSSet *rounds;
@property (nonatomic, retain) NSSet *scores;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addRoundsObject:(Round *)value;
- (void)removeRoundsObject:(Round *)value;
- (void)addRounds:(NSSet *)values;
- (void)removeRounds:(NSSet *)values;

- (void)addScoresObject:(Score *)value;
- (void)removeScoresObject:(Score *)value;
- (void)addScores:(NSSet *)values;
- (void)removeScores:(NSSet *)values;

@end
