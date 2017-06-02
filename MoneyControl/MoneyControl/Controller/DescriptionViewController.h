//
//  DescriptionViewController.h
//  MoneyControl
//
//  Created by Olga Saliy on 11.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"

@interface DescriptionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *text;
@property (strong, nonatomic) Record* record;

@end
