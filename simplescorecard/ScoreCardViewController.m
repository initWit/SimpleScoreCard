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

@interface ScoreCardViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIPickerViewDataSource, UIPickerViewDelegate>

@property GolfRound *currentGolfRound;
@property (strong, nonatomic) IBOutlet UICollectionView *currentHoleCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *plusMinusLabel;
@property NSNumber *totalScore;
@property (strong, nonatomic) IBOutlet UIView *keyboardUIView;
@end


@implementation ScoreCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentGolfRound = [[GolfRound alloc] init];
    self.currentGolfRound.holePars = [[NSMutableArray alloc] initWithCapacity:18];
    self.currentGolfRound.holeScores = [[NSMutableArray alloc] initWithCapacity:18];

    for (int i=0; i<18; i++) {
        [self.currentGolfRound.holePars addObject:[NSNumber numberWithInt:0]];
        [self.currentGolfRound.holeScores addObject:[NSNumber numberWithInt:0]];
    }

    self.totalScore = [NSNumber numberWithInt:0];
    self.totalScoreLabel.text = self.totalScore.description;
}

#pragma mark UICollectionViewDelegate Methods

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 18;
}


-(MyCollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];

    cell.myLabel.text = [NSString stringWithFormat:@"Hole #%i", (indexPath.row+1)];

    NSNumber *selectedParNumberObject = [self.currentGolfRound.holePars objectAtIndex:indexPath.row];

    if ([selectedParNumberObject intValue]>0)
    {
        switch ([selectedParNumberObject intValue]) {
            case 3:
                cell.parSegmentedControl.selectedSegmentIndex = 0;
                break;
            case 4:
                cell.parSegmentedControl.selectedSegmentIndex = 1;
                break;
            case 5:
                cell.parSegmentedControl.selectedSegmentIndex = 2;
                break;
            default:
                break;
        }
    }
    else
    {
        cell.parSegmentedControl.selectedSegmentIndex = -1;
    }

    NSNumber *selectedScoreNumberObject = [self.currentGolfRound.holeScores objectAtIndex:indexPath.row];

    if ([selectedScoreNumberObject intValue]>0)
    {
        [cell.scorePickerView selectRow:[selectedScoreNumberObject intValue] inComponent:0 animated:NO];
    }
    else
    {
        [cell.scorePickerView selectRow:0 inComponent:0 animated:NO];
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

    // reload data
    //[self.currentHoleCollectionView reloadData];

    // reload data so score selections are updated
    //NSArray *arrayOfIndexPaths = @[currentHoleIndexPath];
    //[self.currentHoleCollectionView reloadItemsAtIndexPaths:arrayOfIndexPaths];

    // reload data for scorePickerView
    MyCollectionViewCell *currentCell = (MyCollectionViewCell *)[self.currentHoleCollectionView cellForItemAtIndexPath:currentHoleIndexPath];
    [currentCell.scorePickerView reloadAllComponents];

}


#pragma mark PickerVIew Delegate Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    NSIndexPath *currentHoleIndexPath = self.currentHoleCollectionView.indexPathsForVisibleItems.firstObject;
    NSNumber *selectedHolePar = [self.currentGolfRound.holePars objectAtIndex:currentHoleIndexPath.row];
    //NSLog(@"picker title for row: self.currentGolfRound.holePars is %@",self.currentGolfRound.holePars);

    NSString *scorePickerLabel = @"Select score";

    int parScore = [selectedHolePar intValue];
    int delta = row - parScore;

    if (!parScore)
    {
        scorePickerLabel = [NSString stringWithFormat:@"%i",row];
    }
    else if (row>0)
    {
        scorePickerLabel = [NSString stringWithFormat:@"%i   %i",row, delta];

        if (delta == -3)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Double Eagle",row];
        }
        else if (delta == -2)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Eagle",row];
        }
        else if (delta == -1)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Birdie",row];
        }
        else if (delta == 0)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Par",row];
        }
        else if (delta == 1)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Bogie",row];
        }
        else if (delta == 2)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Double Bogie",row];
        }
    }

    return scorePickerLabel;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 64)];
    //label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    //label.text = [NSString stringWithFormat:@"  %d", row+1];

    NSIndexPath *currentHoleIndexPath = self.currentHoleCollectionView.indexPathsForVisibleItems.firstObject;
    NSNumber *selectedHolePar = [self.currentGolfRound.holePars objectAtIndex:currentHoleIndexPath.row];

    NSString *scorePickerLabel = @"Select score";

    int parScore = [selectedHolePar intValue];
    int delta = row - parScore;

    if (!parScore)
    {
        scorePickerLabel = [NSString stringWithFormat:@"%i",row];
    }
    else if (row>0)
    {
        scorePickerLabel = [NSString stringWithFormat:@"%i   %i",row, delta];

        if (delta == -3)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Double Eagle",row];
        }
        else if (delta == -2)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Eagle",row];
        }
        else if (delta == -1)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Birdie",row];
        }
        else if (delta == 0)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Par",row];
        }
        else if (delta == 1)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Bogie",row];
        }
        else if (delta == 2)
        {
            scorePickerLabel = [NSString stringWithFormat:@"%i Double Bogie",row];
        }
    }

    label.text = scorePickerLabel;

    return label;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"score selected is %li",(long)(row));


    // get the current hole
    NSIndexPath *currentHoleIndexPath = self.currentHoleCollectionView.indexPathsForVisibleItems.firstObject;

    // get the selected score
    NSNumber *selectedHoleScoreNumber = [NSNumber numberWithInt:row];

    // save the selected par in the array
    [self.currentGolfRound.holeScores replaceObjectAtIndex:currentHoleIndexPath.row withObject:selectedHoleScoreNumber];

    // add up the scores
    int totalScore = 0;
    for (NSNumber *eachNumber in self.currentGolfRound.holeScores) {
        totalScore = totalScore + [eachNumber intValue];
    }

    // calculate the plus minus
    int totalPar = 0;
    NSString *totalPlusMinus = @"0";
    
    for (NSNumber *eachPar in self.currentGolfRound.holePars)
    {
        totalPar = totalPar + [eachPar intValue];
    }
    
    int plusMinus = totalScore - totalPar;
    
    if (plusMinus<0)
    {
        totalPlusMinus = [NSString stringWithFormat:@"%i", plusMinus];
    }
    else if (plusMinus>0)
    {
        totalPlusMinus = [NSString stringWithFormat:@"+%i", plusMinus];
    }
    
    // set total score label
    self.totalScoreLabel.text = [NSString stringWithFormat:@"%i",totalScore];
    
    // set plus minus label
    self.plusMinusLabel.text = totalPlusMinus;
}

- (IBAction)UIViewButtonTapped:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.keyboardUIView.frame = CGRectMake(self.keyboardUIView.frame.origin.x, 0.0, self.keyboardUIView.frame.size.width, self.keyboardUIView.frame.size.height);
    }];
}
@end
