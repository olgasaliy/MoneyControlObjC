//
//  SecureViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 23.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "SecureViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "FirstViewController.h"
#import "AppDelegate.h"


@interface SecureViewController (){
    BOOL logged;
}

@end

@implementation SecureViewController

-(void) viewDidAppear:(BOOL)animated{
    [self touchId];
}

-(void) touchId {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    NSString *reason = @"Авторизуйтесь с помощью TouchID.";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:reason
                          reply:^(BOOL success, NSError *error) {
                              if (success) {
                                  NSLog(@"Авторизация прошла успешно");
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      [self ifLoggedGoTo];
                                  });
                              }
                              else {
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      
                                      UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                                                    message:error.description
                                                                                             preferredStyle:UIAlertControllerStyleAlert];
                                      
                                      UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                            handler:nil];
                                      [alert addAction:defaultAction];
                                      [self presentViewController:alert animated:YES completion:nil];
                                  });
                                  NSLog(@"Error received: %@", error);
                              }
                          }];
    } else {
        //если touchid недоступно
        [self ifLoggedGoTo];
        NSLog(@"Can not evaluate Touch ID");
    }
    
    
}

-(void) ifLoggedGoTo {
    if (logged) {
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated:YES completion:nil];
    } else {
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] animated:NO completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (((User*)[User returnSingleton]).name)
        logged = YES;
    else logged = NO;
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
