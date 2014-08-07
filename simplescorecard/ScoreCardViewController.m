//
//  ScoreCardViewController.m
//  SimpleScoreCard
//
//  Created by Robert Figueras on 7/30/14.
//
//

#import "ScoreCardViewController.h"
#import "MyCollectionViewCell.h"
#import "GolfRound.h"
#import "Calculations.h"

@interface ScoreCardViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property GolfRound *currentGolfRound;
@property NSNumber *totalScore;
@property (strong, nonatomic) IBOutlet UICollectionView *currentHoleCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *plusMinusLabel;
@property (strong, nonatomic) IBOutlet UIView *keyboardUIView;
@property Calculations *calculator;
@end

#define GOLF_ROUND_NUM_OF_HOLES 18
#define MIN_PAR 3


@implementation ScoreCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentGolfRound = [[GolfRound alloc] init];
    self.currentGolfRound.holePars = [[NSMutableArray alloc] initWithCapacity:GOLF_ROUND_NUM_OF_HOLES];
    self.currentGolfRound.holeScores = [[NSMutableArray alloc] initWithCapacity:GOLF_ROUND_NUM_OF_HOLES];

    for (int i=0; i<GOLF_ROUND_NUM_OF_HOLES; i++) {
        [self.currentGolfRound.holePars addObject:[NSNumber numberWithInt:0]];
        [self.currentGolfRound.holeScores addObject:[NSNumber numberWithInt:0]];
    }

    self.totalScore = [NSNumber numberWithInt:0];
    self.calculator = [[Calculations alloc] init];

    self.keyboardUIView.frame = CGRectMake(self.keyboardUIView.frame.origin.x, 900.0, self.keyboardUIView.frame.size.width, self.keyboardUIView.frame.size.height);
}

#pragma mark UICollectionViewDelegate Methods

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return GOLF_ROUND_NUM_OF_HOLES;
}


-(MyCollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];

    cell.myLabel.text = [NSString stringWithFormat:@"HOLE #%i", (indexPath.row+1)];

    NSNumber *selectedParNumberObject = [self.currentGolfRound.holePars objectAtIndex:indexPath.row];

    if ([selectedParNumberObject intValue]>0)
    {
        cell.parSegmentedControl.selectedSegmentIndex = ([selectedParNumberObject intValue]-MIN_PAR);
    }
    else
    {
        cell.parSegmentedControl.selectedSegmentIndex = -1;
    }

    NSNumber *selectedScoreNumberObject = [self.currentGolfRound.holeScores objectAtIndex:indexPath.row];

    if ([selectedScoreNumberObject intValue]>0)
    {
        cell.addScoreButton.titleLabel.text = selectedScoreNumberObject.description;
    }
    else
    {
        cell.addScoreButton.titleLabel.text = @"ADD";
    }

    return cell;

}


- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320.0, 400);
}


#pragma mark Helper Methods


- (IBAction)parValueSelected:(UISegmentedControl *)sender
{
    // get the current hole
    NSIndexPath *currentHoleIndexPath = self.currentHoleCollectionView.indexPathsForVisibleItems.firstObject;

    // get the selected par
    NSNumber *selectedHolePar = [NSNumber numberWithInt:sender.selectedSegmentIndex+3];

    // save the selected par in the array
    [self.currentGolfRound.holePars replaceObjectAtIndex:currentHoleIndexPath.row withObject:selectedHolePar];

    // reload cell data
    [self.currentHoleCollectionView reloadData];
}


- (IBAction)UIViewButtonTapped:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.keyboardUIView.frame = CGRectMake(self.keyboardUIView.frame.origin.x, 0.0, self.keyboardUIView.frame.size.width, self.keyboardUIView.frame.size.height);
    }];
}


- (IBAction)closeButtonTapped:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.keyboardUIView.frame = CGRectMake(self.keyboardUIView.frame.origin.x, 900.0, self.keyboardUIView.frame.size.width, self.keyboardUIView.frame.size.height);
    }];
}


- (IBAction)numberButtonTapped:(UIButton *)sender
{
    // get the current hole
    NSIndexPath *currentHoleIndexPath = self.currentHoleCollectionView.indexPathsForVisibleItems.firstObject;

    // get the selected score
    NSNumber *selectedHoleScoreNumber = [NSNumber numberWithInt:[sender.titleLabel.text intValue]];

    // save the selected score in the array
    [self.currentGolfRound.holeScores replaceObjectAtIndex:currentHoleIndexPath.row withObject:selectedHoleScoreNumber];

    // reload cell data
    [self.currentHoleCollectionView reloadData];

    // set total score label
    int totalScore = [self.calculator calculateTotal:self.currentGolfRound.holeScores];
    self.totalScoreLabel.text = [NSString stringWithFormat:@"%i",totalScore];

    // add up the pars
    int totalPar = [self.calculator calculateTotal:self.currentGolfRound.holePars];

    // set plus minus label
    self.plusMinusLabel.text = [self.calculator calculatePar:totalPar minusScore:totalScore];

    [self closeButtonTapped:nil];
}


@end
