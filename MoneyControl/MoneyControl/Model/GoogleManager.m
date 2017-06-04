//
//  GoogleManager.m
//  MoneyControl
//
//  Created by Olga Saliy on 02.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "GoogleManager.h"

@implementation GoogleManager

+(void)logOut {
    [[GIDSignIn sharedInstance] signOut];
}

+ (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    User *myUser = [User returnSingleton];
    [myUser clearInfo];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
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

}



@end
