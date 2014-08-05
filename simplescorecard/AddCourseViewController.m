//
//  AddCourseViewController.m
//  SimpleScoreCard
//
//  Created by Robert Figueras on 8/4/14.
//
//

#import "AddCourseViewController.h"

@interface AddCourseViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *addCourseTextField;
@property (strong, nonatomic) IBOutlet UIButton *addCourseAddButton;

@end

@implementation AddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)addButtonTapped:(id)sender
{
    
    [self.addCourseTextField resignFirstResponder];

    if (self.addCourseTextField.text.length>0) {
        self.addedGolfCourseName = self.addCourseTextField.text;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.addCourseTextField resignFirstResponder];
}

@end
