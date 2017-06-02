//
//  Category.m
//  MoneyControl
//
//  Created by Olga Saliy on 09.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "MyCategory.h"
#import <Foundation/Foundation.h>


@interface MyCategory()


@end

@implementation MyCategory

-(BOOL)isEqual:(id)object {
    if (((MyCategory*)object).name == _name && ((MyCategory*)object).type == _type)
        return YES;
    else return NO;
}

- (id)copyWithZone:(NSZone *)zone {
    MyCategory* copy = [[[self class] alloc] init];
    if (copy)
    {
        [copy setImage:self.image];
        [copy setName:self.name];
        [copy setType:self.type];
        
        
    }
    
    return copy;
}

-(instancetype)initWithName:(NSString *)name Image:(UIImage*)img Type:(typeOfRecord)t{
    self = [super init];
    
    if (self){
        self.name = name;
        self.image = img;
        self.type = t;
    }
    return self;
}

-(BOOL)isIncoming{
    return (!_type)? YES : NO;
}
@end
