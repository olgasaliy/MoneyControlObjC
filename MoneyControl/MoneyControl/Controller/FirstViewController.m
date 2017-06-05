//
//  FirstViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 22.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "FirstViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <AccountKit/AccountKit.h>


#import "User.h"

@interface FirstViewController ()

//@property IBOutlet FBSDKLoginButton * loginButton;


@end

@implementation FirstViewController

////GOOGLE
//
//- (void)signIn:(GIDSignIn *)signIn
//didSignInForUser:(GIDGoogleUser *)user
//     withError:(NSError *)error {
//    [GoogleManager signIn:signIn didSignInForUser:user withError:error];
//    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated: YES completion: nil];
//
//}
//
//
//// Present a view that prompts the user to sign in with Google
//- (void)signIn:(GIDSignIn *)signIn
//    presentViewController:(UIViewController *)viewController {
//    [self presentViewController:viewController animated:YES completion:nil];
//}
//
//
//- (IBAction)gg:(id)sender {
//    [[GIDSignIn sharedInstance] signIn];
//}
//
////FACEBOOK
//
//- (IBAction)fb:(id)sender {
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    [login logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//        if (error)
//        {
//            NSLog(@"Unexpected login error: %@", error);
//            NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
//            NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
//            UIAlertController*alert = [UIAlertController alertControllerWithTitle:alertTitle
//                                                message:alertMessage
//                                         preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                                  handler:^(UIAlertAction * action) {
//                                                                  }];
//
//            [alert addAction:defaultAction];
//            [self presentViewController:alert animated:YES completion:nil];
//        } else {
//            if(result.token)   // This means if There is current access token.
//            {
//                [FacebookManager getInfo];
//                [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated: YES completion: nil];
//            }
//            NSLog(@"Login Cancel");
//        }
//    }];
//}
//
//

-(IBAction)pressedSkip:(id)sender {
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated: YES completion: nil];
}

- (IBAction)hide:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload");
//    [GIDSignIn sharedInstance].delegate=self;
//    [GIDSignIn sharedInstance].uiDelegate=self;

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
