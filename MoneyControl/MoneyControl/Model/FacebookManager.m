//
//  FacebookManager.m
//  MoneyControl
//
//  Created by Olga Saliy on 02.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "FacebookManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"

@implementation FacebookManager


+(void)getInfo {
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{@"fields": @"id, email, picture.width(240).height(240), name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id userinfo, NSError *error) {
         if (!error) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
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

                 });
             });
             
         }
         else{
             
             NSLog(@"%@", [error localizedDescription]);
         }
     }];

}
+(void) logOut{
     [FBSDKAccessToken setCurrentAccessToken:nil];
}

@end
