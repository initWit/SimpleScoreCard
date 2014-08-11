//
//  ScoreCardViewController.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 7/30/14.
//
//

#import <UIKit/UIKit.h>
#import "Round.h"

@interface ScoreCardViewController : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Round *currentRound;

@end
