//
//  RoundsViewController.m
//  SimpleScoreCard
//
//  Created by Robert Figueras on 7/30/14.
//
//

#import "RoundsViewController.h"
#import "GolfRound.h"
#import "AddCourseViewController.h"

@interface RoundsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *roundsTableView;
@property NSMutableArray *roundsArray;
@end

@implementation RoundsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.roundsArray = [NSMutableArray array];
    [self loadData];
}


- (void) loadData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"GolfRound"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"golfCourseName" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.roundsArray = (NSMutableArray *)[self.managedObjectContext executeFetchRequest:request error:nil];
    [self.roundsTableView reloadData];
}


#pragma mark TableView Delegate Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.roundsArray.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"roundsCell"];

    NSManagedObject *currentRound = [self.roundsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [currentRound valueForKey:@"golfCourseName"];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"ccc, MMMM d, YYYY @ h:mma"];
    cell.detailTextLabel.text = [dateFormat stringFromDate:[currentRound valueForKey:@"date"]];

    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.managedObjectContext deleteObject:[self.roundsArray objectAtIndex:indexPath.row]];
    [self.managedObjectContext save:nil];
    [self loadData];
}


#pragma segue methods

- (IBAction)unwindSegue:(UIStoryboardSegue *) segue
{
    AddCourseViewController *sourceVC = segue.sourceViewController;

    NSManagedObject *newGolfRound = [NSEntityDescription insertNewObjectForEntityForName:@"GolfRound" inManagedObjectContext:self.managedObjectContext];

    

    [newGolfRound setValue:sourceVC.addedGolfCourseName forKey:@"golfCourseName"];
    [newGolfRound setValue:[NSDate date] forKey:@"date"];
    [self.managedObjectContext save:nil];
    [self loadData];

}


@end
