//
//  GoogleManager.h
//  MoneyControl
//
//  Created by Olga Saliy on 02.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "User.h"

@interface GoogleManager : NSObject 

+(void) signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error;
+(void) logOut;

@end
