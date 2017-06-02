//
//  ArrayOfCategories.m
//  MoneyControl
//
//  Created by Olga Saliy on 10.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "ArrayOfCategories.h"


@implementation ArrayOfCategories

+(NSArray*) returnArrayOfIncomes{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
     for (MyCategory *c in [[self singleton] allValues])
         if (c.type == income)
             [arr addObject:c];
    
    return arr;
}

+(NSArray*) returnArrayOfOutcomes{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (MyCategory *c in [[self singleton] allValues])
        if (c.type == outcome)
            [arr addObject:c];
    return [NSArray arrayWithArray:arr];
}

+(int)countOfIncomes {
    int res = 0;
    for (MyCategory *c in [self singleton]) {
        if (c.type == income)
            res++;
    }
    return res;
}

+(int)countOfOutcomes {
    int res = 0;
    for (MyCategory *c in [self singleton]) {
        if (c.type == outcome)
            res++;
    }
    return res;
}

+(NSMutableDictionary *)singleton {
    static dispatch_once_t pred;
    static ArrayOfCategories *shared = nil;
    static NSMutableDictionary *categories = nil;
    dispatch_once(&pred, ^{
        shared = [[ArrayOfCategories alloc] init];
        MyCategory *c1 = [[MyCategory alloc] initWithName:@"Кафе" Image:[UIImage imageNamed:@"cafe.png"] Type: outcome];
        MyCategory *c2 = [[MyCategory alloc] initWithName:@"Дивиденты" Image:[UIImage imageNamed:@"dividents.png"] Type: income];
        MyCategory *c3 = [[MyCategory alloc] initWithName:@"Подарки" Image:[UIImage imageNamed:@"gift.png"] Type: outcome];
        MyCategory *c3_1 = [[MyCategory alloc] initWithName:@"Подарки" Image:[UIImage imageNamed:@"gift.png"] Type: income];
        MyCategory *c4 = [[MyCategory alloc] initWithName:@"Продажи" Image:[UIImage imageNamed:@"sales.png"] Type: income];
        MyCategory *c5 = [[MyCategory alloc] initWithName:@"Спорт" Image:[UIImage imageNamed:@"sport.png"] Type: outcome];
        MyCategory *c6 = [[MyCategory alloc] initWithName:@"Обучение" Image:[UIImage imageNamed:@"study.png"] Type: outcome];
        MyCategory *c7 = [[MyCategory alloc] initWithName:@"Транспорт" Image:[UIImage imageNamed:@"transport.png"] Type: outcome];
        MyCategory *c8 = [[MyCategory alloc] initWithName:@"Работа" Image:[UIImage imageNamed:@"work.png"] Type: income];
        MyCategory *c9 = [[MyCategory alloc] initWithName:@"Магазин" Image:[UIImage imageNamed:@"shop.png"] Type: outcome];
        MyCategory *c10 = [[MyCategory alloc] initWithName:@"Жилье" Image:[UIImage imageNamed:@"home.png"] Type: outcome];
        MyCategory *c11 = [[MyCategory alloc] initWithName:@"Связь" Image:[UIImage imageNamed:@"network.png"] Type: outcome];
        
        categories = [[NSMutableDictionary alloc] init];
        [categories setObject:c1 forKey:@"CafeOut"];
        [categories setObject:c2 forKey:@"DividentsIn"];
        [categories setObject:c3 forKey: @"GiftsOut"];
        [categories setObject:c3_1 forKey:@"GiftsIn"];
        [categories setObject:c4 forKey:@"SalesIn"];
        [categories setObject:c5 forKey:@"SportOut"];
        [categories setObject:c6 forKey:@"StudyOut"];
        [categories setObject:c7 forKey:@"TransportOut"];
        [categories setObject:c8 forKey:@"WorkIn"];
        [categories setObject:c9 forKey:@"ShopOut"];
        [categories setObject:c10 forKey:@"HomeOut"];
        [categories setObject:c11 forKey:@"NetworkOut"];
        
    });
    return categories;
}
@end
