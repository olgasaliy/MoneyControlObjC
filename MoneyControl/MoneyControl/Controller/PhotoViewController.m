//
//  PhotoViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 20.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *photo;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem.titleView setHidden:YES];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Назад";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    self.photo.contentMode = UIViewContentModeScaleAspectFit;
    [_photo setImage:_record.img];
    // Do any additional setup after loading the view.
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
