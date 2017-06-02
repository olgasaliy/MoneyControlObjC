//
//  ArrayOfCategories.h
//  MoneyControl
//
//  Created by Olga Saliy on 10.05.17.
//  Copyright © 2017 home. All rights reserved.
//
// Class was created for always returning the same dictionary with categories

#import <Foundation/Foundation.h>
#import "MyCategory.h"

@interface ArrayOfCategories: NSObject

//@property (nonatomic) NSDictionary *categories;

+(NSArray*) returnArrayOfIncomes;
+(NSArray*) returnArrayOfOutcomes;
+(NSDictionary*)singleton;
+(int) countOfIncomes;
+(int) countOfOutcomes;
@end
