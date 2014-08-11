//
//  Hole.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 8/10/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course;

@interface Hole : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * par;
@property (nonatomic, retain) NSNumber * yardage;
@property (nonatomic, retain) NSString * teeBox;
@property (nonatomic, retain) Course *course;

@end
