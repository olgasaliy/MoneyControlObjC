//
//  DetailViewController.h
//  MoneyControl
//
//  Created by Olga Saliy on 06.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"
#import "User.h"


@interface DetailViewController : UIViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Record *record;
@property (nonatomic, strong) NSString *key;

@end
