//
//  RoundsViewController.m
//  SimpleScoreCard
//
//  Created by Robert Figueras on 7/30/14.
//
//

#import "RoundsViewController.h"
#import "AddCourseViewController.h"
#import "ScoreCardViewController.h"
#import "Round.h"
#import "Course.h"

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
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Round"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
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
    NSManagedObject *golfCourse = [currentRound valueForKey:@"course"];
    cell.textLabel.text = [golfCourse valueForKey:@"golfCourseName"];

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

    NSManagedObject *newGolfCourse = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];

    [newGolfCourse setValue:sourceVC.addedGolfCourseName forKey:@"golfCourseName"];

    NSManagedObject *newRound = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:self.managedObjectContext];

    [newRound setValue:[NSDate date] forKey:@"date"];
    [newRound setValue:newGolfCourse forKey:@"course"];

    [self.managedObjectContext save:nil];
    [self loadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StartScoreCardSegue"])
    {
        ScoreCardViewController *destinationVC = segue.destinationViewController;
        destinationVC.managedObjectContext = self.managedObjectContext;

        int selectedRow = [self.roundsTableView indexPathForCell:sender].row;
        Round *selectedRound = [self.roundsArray objectAtIndex:selectedRow];
        destinationVC.currentRound = selectedRound;
    }
}


@end
