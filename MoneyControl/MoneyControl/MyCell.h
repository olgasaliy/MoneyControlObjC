//
//  MyCell.h
//  MoneyControl
//
//  Created by Olga Saliy on 03.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *category;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
