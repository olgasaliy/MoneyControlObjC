//
//  RootViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 08.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import "StatisticViewController.h"
#import "FirstViewController.h"

@interface RootViewController () {
    double height, width;
}

@property NSArray* controllers;

@end

@implementation RootViewController

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




- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self prepareNavigationTitle];
    
    //[self addBackButtonWithTitle:@"Назад"];
    
    height = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect frame =self.view.frame;
    frame.size.height = height;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: self.view.frame];
    [self.view addSubview:scrollView];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    
    
    [scrollView setBounces:NO];
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, height);
    
    // _controllers = [[NSArray alloc] initWithObjects:[[ViewController alloc] init], [[DetailViewController alloc] init], nil];
    
    ViewController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"First"];
    [scrollView addSubview:first.view];
    first.view.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, height) ;
    
    
    StatisticViewController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"Second"];
    [scrollView addSubview:second.view];
    second.view.frame = CGRectMake(self.view.frame.size.width, 0.0, self.view.frame.size.width, height) ;
    _controllers = [[NSArray alloc] initWithObjects:first, second, nil];
    [self addChildViewController: first];
    [self addChildViewController: second];
    

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
