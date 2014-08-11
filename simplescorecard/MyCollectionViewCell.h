//
//  MyCollectionViewCell.h
//  SimpleScoreCard
//
//  Created by Robert Figueras on 7/30/14.
//
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *parSegmentedControl;
@property (strong, nonatomic) IBOutlet UIPickerView *scorePickerView;
@property (strong, nonatomic) IBOutlet UIButton *addScoreButton;
@end
