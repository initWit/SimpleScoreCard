//
//  Course.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 8/10/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hole, Round;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * golfCourseName;
@property (nonatomic, retain) NSSet *round;
@property (nonatomic, retain) NSSet *holes;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addRoundObject:(Round *)value;
- (void)removeRoundObject:(Round *)value;
- (void)addRound:(NSSet *)values;
- (void)removeRound:(NSSet *)values;

- (void)addHolesObject:(Hole *)value;
- (void)removeHolesObject:(Hole *)value;
- (void)addHoles:(NSSet *)values;
- (void)removeHoles:(NSSet *)values;

@end
