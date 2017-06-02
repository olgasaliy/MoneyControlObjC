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

//@property (nonatomic,strong) NSMutableArray *recordsIncome;
//@property (nonatomic,strong) NSMutableArray *recordsOutcome;
//@property (nonatomic,strong) NSMutableArray *records;
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
   // label.textColor =[UIColor colorWithRed:0.127 green:0.127 blue: 0.127 alpha:1.0];
    
    NSDateFormatter *f = [NSDateFormatter new];
    [f setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    [f setDateFormat:@"d MMMM yyyy"];
    NSString *date = [f stringFromDate:[NSDate date]];
    
    label.text=date;
    self.navigationItem.titleView = label;
}

-(void) prepareButtons {
    [_fisrt setFrame:CGRectMake(_fisrt.frame.origin.x, _fisrt.frame.origin.y, self.view.frame.size.width/2, _fisrt.frame.size.height)];
    [_second setFrame:CGRectMake(_second.frame.origin.x, _second.frame.origin.y, self.view.frame.size.width/2, _second.frame.size.height)];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.fisrt.bounds byRoundingCorners:(UIRectCornerTopLeft |  UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0, 10.0)];
     UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.second.bounds byRoundingCorners:(UIRectCornerTopLeft |  UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = CGRectMake(0.0, 0.0, self.fisrt.frame.size.width, self.fisrt.frame.size.height-1.0);
   // self.fisrt.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth   = 1.0f;
    borderLayer.strokeColor = [UIColor colorWithRed:110.0/255.0 green:111.0/255.0 blue: 111.0/255.0 alpha:1.0].CGColor;
    borderLayer.fillColor   = [UIColor whiteColor].CGColor;
    
    [self.fisrt.layer addSublayer:borderLayer];
    CAShapeLayer *borderLayer1 = [[CAShapeLayer alloc] init];
    [borderLayer1 setFrame:CGRectMake(0.0, 0.0, self.second.frame.size.width, self.second.frame.size.height-1.0)];
    [borderLayer1 setPath:maskPath1.CGPath];
    borderLayer1.fillColor   = [UIColor whiteColor].CGColor;
    borderLayer1.strokeColor = [UIColor colorWithRed:110.0/255.0 green:111.0/255.0 blue: 111.0/255.0 alpha:1.0].CGColor;
    borderLayer1.lineWidth   = 1.0f;
    [self.second.layer addSublayer:borderLayer1];
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
   // [self prepareButtons];

    
    key = 0;
    
_user = [User returnSingleton];
    
}

-(IBAction)pressed0:(id)sender {
    key = 0;
    [self.table reloadData];
}
-(IBAction)pressed1:(id)sender {
    key = 1;
    [self.table reloadData];
}
-(IBAction)pressed2:(id)sender {
    key = 2;
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
    
    //Record *record = ([[NSArray arrayWithArray:_recordsIncome] arrayByAddingObjectsFromArray:_recordsOutcome])[indexPath.row];
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Record *record = nil;
//    switch (key) {
//        case 1:
//            record = self.recordsIncome[indexPath.row];
//            break;
//        case 2:
//            record = self.recordsOutcome[indexPath.row];
//            break;
//        default:
//            record = self.records[indexPath.row];
//            break;
//    }
//    DetailViewController *detailController = [[DetailViewController alloc] init];
//    detailController.record = record;
//    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [del.navigationController pushViewController:nextViewController animated:YES];
//}


@end
