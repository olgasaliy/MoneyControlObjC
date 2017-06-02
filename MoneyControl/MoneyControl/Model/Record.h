//
//  Record.h
//  MoneyControl
//
//  Created by Olga Saliy on 03.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyCategory.h"

@interface Record : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSDate *d;
@property (nonatomic, copy) MyCategory *category;
@property (nonatomic) NSUInteger price;
//@property (copy, nonatomic) UIColor *color;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, copy) UIImage *img;

-(BOOL) ifImageIsNil;
-(NSString *) isIncome;

@end
