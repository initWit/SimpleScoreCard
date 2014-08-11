//
//  Round.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 8/10/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, Player, Score;

@interface Round : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * teeBox;
@property (nonatomic, retain) NSNumber * totalScore;
@property (nonatomic, retain) NSSet *players;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) NSSet *scores;
@end

@interface Round (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

- (void)addScoresObject:(Score *)value;
- (void)removeScoresObject:(Score *)value;
- (void)addScores:(NSSet *)values;
- (void)removeScores:(NSSet *)values;

@end
