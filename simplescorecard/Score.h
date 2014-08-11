//
//  Score.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 8/10/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player, Round;

@interface Score : NSManagedObject

@property (nonatomic, retain) NSNumber * holeNumber;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) Round *round;
@property (nonatomic, retain) NSSet *player;
@end

@interface Score (CoreDataGeneratedAccessors)

- (void)addPlayerObject:(Player *)value;
- (void)removePlayerObject:(Player *)value;
- (void)addPlayer:(NSSet *)values;
- (void)removePlayer:(NSSet *)values;

@end
