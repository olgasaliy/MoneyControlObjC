//
//  Category.h
//  MoneyControl
//
//  Created by Olga Saliy on 09.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum { income = 0, outcome = 1
} typeOfRecord;


@interface MyCategory : NSObject <NSCopying>

@property (nonatomic) typeOfRecord type;
@property (nonatomic,copy) UIImage *image;
@property (nonatomic,copy) NSString *name;

-(instancetype)initWithName:(NSString *)name Image:(UIImage*)img Type:(typeOfRecord)t;
-(BOOL) isIncoming;
-(BOOL)isEqual:(id)object;

@end
