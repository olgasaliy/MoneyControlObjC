//
//  User.h
//  MoneyControl
//
//  Created by Olga Saliy on 15.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"

@interface User : NSObject

@property  NSInteger key;//1-fb, 2-google
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *img;


-(NSUInteger)returnSum;
-(NSUInteger)returnSumOfLastIncomes;
-(NSUInteger)returnSumOfLastOutcomes;
-(void)clearInfo;
-(void) saveInfo;
+(id)returnSingleton;
-(NSArray *) returnIncomes;
-(NSArray *) returnOutcomes;
-(void) addRecord: (Record*) record;
-(void) removeRecord: (Record*) record;
-(NSArray *) returnAll;

@end
