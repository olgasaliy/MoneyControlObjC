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
#import <GoogleSignIn/GoogleSignIn.h>
#import "User.h"

@interface FirstViewController ()<GIDSignInUIDelegate> {
    dispatch_queue_t queue;
}

@property IBOutlet FBSDKLoginButton * loginButton;


@end

@implementation FirstViewController

//GOOGLE

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    User *myUser = [User returnSingleton];
    [myUser clearInfo];
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        myUser.name = user.profile.name;
        myUser.email = user.profile.email;
        if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
        {
            NSUInteger dimension = round(240 * [[UIScreen mainScreen] scale]);
            NSURL *imageURL = [user.profile imageURLWithDimension:dimension];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage *ggImage = [UIImage imageWithData:imageData];
            myUser.img = ggImage;
        }
        myUser.key = 2;
        [myUser saveInfo];
    });
    
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated: YES completion: nil];
    // ...
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)gg:(id)sender {
    [GIDSignIn sharedInstance].delegate=self;
    [GIDSignIn sharedInstance].uiDelegate=self;
    [[GIDSignIn sharedInstance] signIn];
}

//FACEBOOK

- (IBAction)fb:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error)
        {
            NSLog(@"Unexpected login error: %@", error);
            NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
            NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
            UIAlertController*alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                message:alertMessage
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                  }];

            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            if(result.token)   // This means if There is current access token.
            {
                [self getInfo];
                [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated: YES completion: nil];
            }
            NSLog(@"Login Cancel");
        }
    }];
}

-(void) getInfo{
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                       parameters:@{@"fields": @"id, email, picture.width(240).height(240), name"}]
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id userinfo, NSError *error) {
                         if (!error) {
    
    
                             queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                             dispatch_async(queue, ^(void) {
    
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     NSString *name = [userinfo objectForKey:@"name"];
                                     NSString *email = [userinfo objectForKey:@"email"];
                                     NSString *imageStringOfLoginUser = [[[userinfo valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                                     NSURL *url = [NSURL URLWithString: imageStringOfLoginUser];
                                     NSData *imageData = [NSData dataWithContentsOfURL:url];
                                     UIImage *fbImage = [UIImage imageWithData:imageData];
                                     User *user = [User returnSingleton];
                                     [user clearInfo];
                                     user.name = name;
                                     user.email = email;
                                     user.img = fbImage;
                                     user.key = 1;
                                     [user saveInfo];
                                     // you are authorised and can access user data from user info object
    
                                 });
                             });
    
                         }
                         else{
    
                             NSLog(@"%@", [error localizedDescription]);
                         }
                     }];
}
-(IBAction)pressedSkip:(id)sender {
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"nav"] animated: YES completion: nil];
}

- (IBAction)hide:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload");
    _loginButton  = [[FBSDKLoginButton alloc] init];
    _loginButton.hidden = YES;
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
