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

@property FirstViewController *f;


@end

@implementation SecureViewController

//-(void) launchFromRoot {
//    // grab our storyboard
//    
//    
//    // instantiate our navigation controller
//    UINavigationController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"nav"];
//    
//    // make the nav controller visible
//    [self presentViewController:controller animated:YES completion:nil];
//}

-(void) viewDidAppear:(BOOL)animated{
    [self touchId];
}

-(void) touchId {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
            NSString *reason = @"Please authenticate using TouchID.";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                        localizedReason:reason
                                  reply:^(BOOL success, NSError *error) {
                                      if (success) {
                                          NSLog(@"Auth was OK");
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (logged) {
                                                  
                                                  [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated:YES completion:nil];
                                              } else {
                                                  NSLog(@"Controller");
                                                  [self presentViewController:_f animated:NO completion:nil];
                                              }
                                          });
               
                                          
                                      }
                                      else {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:error.description
                                                                                                 delegate:self
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil, nil];
                                              [alertView show];
                                              
                                          });
                                          NSLog(@"Error received: %@", error);
                                      }
                                  }];
            }
            else {
                if (logged) {
                    
                    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated:YES completion:nil];
                } else {
                    NSLog(@"Controller");
                    [self presentViewController:_f animated:NO completion:nil];
                }
                NSLog(@"Can not evaluate Touch ID");
            }


}

- (void)viewDidLoad {
    [super viewDidLoad];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//    dispatch_async(queue, ^(void) {
        _f =[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        if (((User*)[User returnSingleton]).name)
            logged = YES;
        else logged = NO;
//    });
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
