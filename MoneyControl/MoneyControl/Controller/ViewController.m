//
//  ViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 11.04.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MyCell.h"
#import "Record.h"
#import "AppDelegate.h"
#import "User.h"
#import "AddViewController.h"



@interface ViewController () <UITableViewDelegate,UITableViewDataSource> {
    int key;
    
}

@property (strong,nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong) IBOutlet UIButton *fisrt;
@property (nonatomic,strong) IBOutlet UIButton *second;
@property (nonatomic,strong) IBOutlet UIButton *all;

@end

@implementation ViewController

- (void)prepareNavigationTitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 40.0)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentLeft;
    
    NSDateFormatter *f = [NSDateFormatter new];
    [f setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    [f setDateFormat:@"d MMMM yyyy"];
    NSString *date = [f stringFromDate:[NSDate date]];
    
    label.text=date;
    self.navigationItem.titleView = label;
}



-(void) viewWillAppear:(BOOL)animated{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"LLLL"];
    [_fisrt setTitle:[NSString stringWithFormat: @"%lu за %@", _user.returnSumOfLastIncomes, [formatter stringFromDate:now]] forState:UIControlStateNormal];
    [_second setTitle:[NSString stringWithFormat: @"%lu за %@", _user.returnSumOfLastOutcomes, [formatter stringFromDate:now]] forState:UIControlStateNormal];
    [_all setTitle:[NSString stringWithFormat: @"%lu", _user.returnSum] forState:UIControlStateNormal];
    [self.table reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareNavigationTitle];
    key = 0;
    _user = [User returnSingleton];
    
}
- (IBAction)touch:(UIButton *)sender {
    key = (int)sender.tag;
    [self.table reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MyCell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Record *record = nil;
    switch (key) {
        case 1:
            record = _user.returnIncomes[indexPath.row];
            break;
        case 2:
            record = _user.returnOutcomes[indexPath.row];
            break;
        default:
            record = _user.returnAll[indexPath.row];
            break;
    }
    
    cell.date.text = record.date;
    
    [cell.category setImage:record.category.image];
    cell.price.text = [NSString stringWithFormat:@"%lu",record.price];
    [cell.price setTextColor: record.category.isIncoming? [UIColor colorWithRed:0.0/255.0 green:152.0/255.0 blue: 0.1/255.0 alpha:1.0] : [UIColor redColor]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (key) {
        case 1:
            return [_user.returnIncomes count];
        case 2:
            return [_user.returnOutcomes count];
        default:
            return [_user.returnAll count];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segue"]) {
        NSIndexPath *indexPath = [self.table indexPathForCell:sender];
        Record *record = nil;
        switch (key) {
            case 1:
                record = _user.returnIncomes[indexPath.row];
                break;
            case 2:
                record = _user.returnOutcomes[indexPath.row];
                break;
            default:
                record = _user.returnAll[indexPath.row];
                break;
        }
        DetailViewController *detailController = (DetailViewController*)segue.destinationViewController;
        detailController.record = record;
        detailController.user = _user;
    }
    
    AddViewController *avc = (AddViewController*)segue.destinationViewController;
    avc.user = _user;
    if ([segue.identifier isEqualToString:@"segueIncome"]) {
        avc.key = 1;
    }
    if ([segue.identifier isEqualToString:@"segueOutcome"]) {
        avc.key = 2;
    }
    
    
    
}



@end
