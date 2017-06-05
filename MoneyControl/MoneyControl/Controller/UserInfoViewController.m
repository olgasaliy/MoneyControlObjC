//
//  UserInfoViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 22.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "UserInfoViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "User.h"



@interface UserInfoViewController ()
@property (strong, nonatomic) User *myUser;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *photo;

@end

@implementation UserInfoViewController

-(IBAction)logOutUser:(id)sender {
//    if (_myUser.key == 1)
//        [FacebookManager logOut];
//    else [GoogleManager logOut];
    [self.myUser  clearInfo];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Выйти"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(logOutUser:)];
    [self.navigationItem setRightBarButtonItem:barButton];

    [self.navigationItem.titleView setHidden:YES];

    _myUser = [User returnSingleton];
    if (_myUser.name){
        [self.photo setImage: _myUser.img];
        [self.name setText: _myUser.name];
    } else {
         [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] animated: NO completion: nil];
    }
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
