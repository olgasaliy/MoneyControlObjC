//
//  SettingsTableViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 20.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "SettingsTableViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface SettingsTableViewController () <UINavigationControllerDelegate>

@property IBOutlet UISwitch *switchObject;

@end

@implementation SettingsTableViewController

- (IBAction)btnSwitched:(id)sender {
    if(_switchObject.isOn){
        
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
//        NSString *reason = @"Please authenticate using TouchID.";
//
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                [standardUserDefaults setBool:YES forKey:@"touchID"];
            [standardUserDefaults synchronize];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Невозможно использовать эту функцию!"
                                                                message:@"На даном устройстве не поддерживается TouchID"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
            [_switchObject setOn:NO];
        }
//            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
//                    localizedReason:reason
//                              reply:^(BOOL success, NSError *error) {
//                                  if (success) {
//                                      NSLog(@"Auth was OK");
//                                  }
//                                  else {
//                                      //You should do better handling of error here but I'm being lazy
//                                      NSLog(@"Error received: %@", error);
//                                  }
//                              }];
//        }
//        else {
//            NSLog(@"Can not evaluate Touch ID");
//        }

    }else{
        NSLog(@"Switch State is Enabled");
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if ([standardUserDefaults boolForKey:@"touchID"])
            [standardUserDefaults setBool:NO forKey:@"touchID"];
        [standardUserDefaults synchronize];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = (@"Настройки");
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults boolForKey:@"touchID"])
        [_switchObject setOn:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
