//
//  StatisticViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 08.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "StatisticViewController.h"
#import "User.h"

@interface StatisticViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *perMonth;
@property (weak, nonatomic) IBOutlet UILabel *common;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) User *user;
@property NSArray *arr;//months
@property NSString *titleBut;
@property (strong,nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) UITextField *pickerViewTextField;
@end

@implementation StatisticViewController

-(void) viewWillAppear:(BOOL)animated {
    [_common setText:[NSString stringWithFormat:@"%lu грн.", _user.returnSum]];
}

- (IBAction)pressed:(id)sender {
    ((UIScrollView*)[self.parentViewController.view.subviews objectAtIndex:2]).scrollEnabled = NO;
    [self.pickerViewTextField becomeFirstResponder];
}

- (IBAction)hide:(id)sender {
    ((UIScrollView*)[self.parentViewController.view.subviews objectAtIndex:2]).scrollEnabled = YES;
    [self.pickerViewTextField resignFirstResponder];
    if (_titleBut) {
        [_label1 setHidden:NO];
        [_label2 setHidden:NO];
        [_perMonth setHidden:NO];
        [_common setHidden:NO];
        [_table setHidden:NO];
    }
//        [_button setTitle: _titleBut forState: UIControlStateNormal];
//        [_button setImage:nil forState:UIControlStateNormal];
    
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_arr count];
}
#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *item = [_arr objectAtIndex:row];
    
    return item;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    // perform some action
    _titleBut = [_arr objectAtIndex:row];
    [_button setImage:nil forState:UIControlStateNormal];
    [_button setTitle: _titleBut forState: UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _user = [User returnSingleton];
    
    [_button setTitle: @"Месяц" forState: UIControlStateNormal];
    [_table setHidden:YES];
    _arr = [[NSArray alloc] initWithObjects:@"Январь", @"Февраль", @"Март", @"Апрель", @"Май", @"Июнь", @"Июль", @"Август", @"Сентябрь", @"Октябрь", @"Ноябрь", @"Декабрь", nil];
    
    self.pickerViewTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.pickerViewTextField];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 150)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.pickerViewTextField.inputView = pickerView;
    

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 40.0)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentLeft;
        // label.textColor =[UIColor colorWithRed:0.127 green:0.127 blue: 0.127 alpha:1.0];
    
        
    label.text=@"Второй";
    self.navigationItem.titleView = label;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
