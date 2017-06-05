//
//  AppDelegate.m
//  MoneyControl
//
//  Created by Olga Saliy on 11.04.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "AppDelegate.h"
#import "AddViewController.h"
#import "SecureViewController.h"
#import "User.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)createItemsWithIcons {

    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType: UIApplicationShortcutIconTypeAdd];

    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.add.income" localizedTitle:@"Новый доход" localizedSubtitle:nil icon: icon1 userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.add.outcome" localizedTitle:@"Новый расход" localizedSubtitle:nil icon:icon1 userInfo:nil];

    
    NSArray *items = @[item1, item2];
    [UIApplication sharedApplication].shortcutItems = items;
    
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    NSLog(@"A shortcut item was pressed. It was %@.", shortcutItem.localizedTitle);
    
    if ([shortcutItem.type isEqualToString:@"com.add.income"]) {
        [self launchViewController1];
    }
    
    if ([shortcutItem.type isEqualToString:@"com.add.outcome"]) {
        [self launchViewController2];
    }
    
}

- (void)launchViewController1 {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"nav"];
    AddViewController *one = [storyboard instantiateViewControllerWithIdentifier:@"add"];
    one.key = 1;
    
    [controller pushViewController:one animated:NO];
    
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}

- (void)launchViewController2 {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"nav"];
    
    AddViewController *two = [storyboard instantiateViewControllerWithIdentifier:@"add"];
    two.key = 2;
    
    [controller pushViewController:two animated:NO];
    
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}

-(void) launchFromTouchID {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    SecureViewController *s = [storyboard instantiateViewControllerWithIdentifier:@"secure"];
    
    self.window.rootViewController = s;
    [self.window makeKeyAndVisible];
}

-(void) launchFromRoot {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"nav"];
    
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    //google
//    NSError* configureError;
//    [GIDSignIn sharedInstance].clientID = @"521958499656-vti6b4069k1afeoa7ucu8ipgo2ntb2ob.apps.googleusercontent.com";
//    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
//    
//    
//    //FB
//    [[FBSDKApplicationDelegate sharedInstance] application:application
//                             didFinishLaunchingWithOptions:launchOptions];

    [self createItemsWithIcons];
    
    // determine whether we've launched from a shortcut item or not
    UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (item) {
        NSLog(@"We've launched from shortcut item: %@", item.localizedTitle);
    } else {
        NSLog(@"We've launched properly.");
    }
    
    // have we launched Deep Link Level 1
    if ([item.type isEqualToString:@"com.add.income"]) {
        [self launchViewController1];
    }
    
    // have we launched Deep Link Level 2
    if ([item.type isEqualToString:@"com.add.outcome"]) {
        [self launchViewController2];
    }
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if([standardUserDefaults boolForKey:@"touchID"]){
        [self launchFromTouchID];
    } else if (((User*)[User returnSingleton]).name) {
        [self launchFromRoot];
    }
    
    return YES;
}



//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
//    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                                  openURL:url
//                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
//                    ];
//    BOOL handled1 = [[GIDSignIn sharedInstance] handleURL:url
//                                                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                                           annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//    return handled || handled1;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   // [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
