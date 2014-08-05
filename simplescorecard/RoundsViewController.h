//
//  RoundsViewController.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 7/30/14.
//
//

#import <UIKit/UIKit.h>

@interface RoundsViewController : UIViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end
