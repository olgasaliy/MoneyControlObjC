//
//  Record.m
//  MoneyControl
//
//  Created by Olga Saliy on 03.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "Record.h"

@implementation Record

-(BOOL) ifImageIsNil {
    return _img? NO: YES;
}

-(NSString *) isIncome {
    return _category.isIncoming? @"Доход" : @"Расход";
}

@end
