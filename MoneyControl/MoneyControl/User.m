//
//  User.m
//  MoneyControl
//
//  Created by Olga Saliy on 15.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "User.h"
#import "ArrayOfCategories.h"
#import "Record.h"

#define ARC4RANDOM_MAX 0x100000000

@interface User()

@property (strong, nonatomic) NSMutableArray *records;


@end

@implementation User

//static NSMutableArray *records = nil;

-(void) clearInfo {
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setValue:nil forKey:@"name"];
    [standardUserDefaults setValue:nil forKey:@"email"];
    [standardUserDefaults setObject:nil forKey:@"image"];
    [standardUserDefaults setInteger:0 forKey:@"key"];
    [standardUserDefaults synchronize];
    self.name = nil;
    self.email = nil;
    self.img = nil;
}

-(void) saveInfo {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if([standardUserDefaults objectForKey:@"name"] == nil){
        [standardUserDefaults setValue:_name forKey:@"name"];
        [standardUserDefaults setValue:_email forKey:@"email"];
        [standardUserDefaults setObject:UIImagePNGRepresentation(_img) forKey:@"image"];
        [standardUserDefaults setInteger:_key forKey:@"key"];
    }
    [standardUserDefaults synchronize];
}

+(NSDate*)getRandomDate{
    NSDate *today = [NSDate date];
    NSDate *first = [self getFirstDateInMonth];
    NSTimeInterval timeBetweenDates = [today timeIntervalSinceDate:first];
    NSTimeInterval randomInterval = ((NSTimeInterval)arc4random() / ARC4RANDOM_MAX) * timeBetweenDates;
    
    return [first dateByAddingTimeInterval:randomInterval];
}

+(id) returnSingleton {
    static dispatch_once_t pred;
    static User *shared = nil;
    
    //static NSMutableDictionary *categories = nil;
    dispatch_once(&pred, ^{
        shared = [[User alloc] init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"d.MM.yyyy"];
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if([standardUserDefaults valueForKey:@"name"]){
            shared.name = (NSString *)[standardUserDefaults valueForKey:@"name"];
            shared.email = (NSString *)[standardUserDefaults valueForKey:@"email"];
            NSData* imageData = [standardUserDefaults objectForKey:@"image"];
            shared.img = [UIImage imageWithData:imageData];
            shared.key = (NSInteger)[standardUserDefaults valueForKey:@"key"];
        }
        
        NSDictionary *d =[ArrayOfCategories singleton];
        shared.records = [[NSMutableArray alloc] init];
        //    self.recordsIncome = [NSMutableArray arrayWithCapacity:2];
        Record *rec = [[Record alloc] init];
        rec.d = [self getRandomDate];
        rec.date = [formatter stringFromDate:rec.d];
        rec.category = [d objectForKey:@"GiftsIn"];
        rec.price =512;
        //rec.color =  [UIColor colorWithRed:0.0/255.0 green:152.0/255.0 blue: 0.1/255.0 alpha:1.0];
        rec.descr = @"От родственников.";
        [shared.records addObject:rec];
        Record *rec1 = [[Record alloc] init];
        rec1.d = [self getRandomDate];
        rec1.date = [formatter stringFromDate:rec1.d];
        rec1.category =[d objectForKey:@"WorkIn"];
        rec1.price =10000;
        //    rec1.color = [UIColor colorWithRed:0.0/255.0 green:152.0/255.0 blue: 0.1/255.0 alpha:1.0];
        rec1.descr = @"Премиальные.";
        [shared.records addObject:rec1];
        
        Record *rec2 = [[Record alloc] init];
        rec2.d = [self getRandomDate];
        rec2.date = [formatter stringFromDate:rec2.d];
        rec2.category =[d objectForKey:@"ShopOut"];
        rec2.price =3000;
        //    rec2.color = [UIColor redColor];
        rec2.descr = @"Продукты.";
        [shared.records addObject:rec2];
        
        Record *rec3 = [[Record alloc] init];
        rec3.d = [self getRandomDate];
        rec3.date = [formatter stringFromDate:rec3.d];
        rec3.category =[d objectForKey:@"CafeOut"];
        rec3.price =210;
        //    rec3.color = [UIColor redColor];
        rec3.descr = @"Обед в кафе.";
        [shared.records addObject:rec3];
//        shared = [[ArrayOfCategories alloc] init];
//        MyCategory *c1 = [[MyCategory alloc] initWithName:@"Кафе" Image:[UIImage imageNamed:@"cafe.png"] Type: outcome];
//        MyCategory *c2 = [[MyCategory alloc] initWithName:@"Дивиденты" Image:[UIImage imageNamed:@"dividents.png"] Type: income];
//        MyCategory *c3 = [[MyCategory alloc] initWithName:@"Подарки" Image:[UIImage imageNamed:@"gift.png"] Type: outcome];
//        MyCategory *c3_1 = [[MyCategory alloc] initWithName:@"Подарки" Image:[UIImage imageNamed:@"gift.png"] Type: income];
//        MyCategory *c4 = [[MyCategory alloc] initWithName:@"Продажи" Image:[UIImage imageNamed:@"sales.png"] Type: income];
//        MyCategory *c5 = [[MyCategory alloc] initWithName:@"Спорт" Image:[UIImage imageNamed:@"sport.png"] Type: outcome];
//        MyCategory *c6 = [[MyCategory alloc] initWithName:@"Обучение" Image:[UIImage imageNamed:@"study.png"] Type: outcome];
//        MyCategory *c7 = [[MyCategory alloc] initWithName:@"Транспорт" Image:[UIImage imageNamed:@"transport.png"] Type: outcome];
//        MyCategory *c8 = [[MyCategory alloc] initWithName:@"Работа" Image:[UIImage imageNamed:@"work.png"] Type: income];
//        MyCategory *c9 = [[MyCategory alloc] initWithName:@"Магазин" Image:[UIImage imageNamed:@"shop.png"] Type: outcome];
//        MyCategory *c10 = [[MyCategory alloc] initWithName:@"Жилье" Image:[UIImage imageNamed:@"home.png"] Type: outcome];
//        MyCategory *c11 = [[MyCategory alloc] initWithName:@"Связь" Image:[UIImage imageNamed:@"network.png"] Type: outcome];
//        
//        categories = [[NSMutableDictionary alloc] init];
//        [categories setObject:c1 forKey:@"CafeOut"];
//        [categories setObject:c2 forKey:@"DividentsIn"];
//        [categories setObject:c3 forKey: @"GiftsOut"];
//        [categories setObject:c3_1 forKey:@"GiftsIn"];
//        [categories setObject:c4 forKey:@"SalesIn"];
//        [categories setObject:c5 forKey:@"SportOut"];
//        [categories setObject:c6 forKey:@"StudyOut"];
//        [categories setObject:c7 forKey:@"TransportOut"];
//        [categories setObject:c8 forKey:@"WorkIn"];
//        [categories setObject:c9 forKey:@"ShopOut"];
//        [categories setObject:c10 forKey:@"HomeOut"];
//        [categories setObject:c11 forKey:@"NetworkOut"];
        
    });
    return shared;

}

-(NSArray *) returnAll {
    return [self sort:_records];
}

-(NSArray *) sort :(NSArray *) arr{
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"d"
                                        ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    return[arr sortedArrayUsingDescriptors:sortDescriptors];
}


- (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}

+(NSDate*) getFirstDateInMonth {
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:today];
    components.day = 1;
    
    return[gregorian dateFromComponents:components];
}

-(NSArray *) returnIncomes {
    NSDate *today = [NSDate date];
    NSDate *first = [User getFirstDateInMonth];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (Record *r in _records) {
        if (r.category.type == income && [self date:r.d isBetweenDate:first andDate:today])
            [arr addObject:r];
    }
    return [self sort:arr];
}

-(NSUInteger)returnSum {
    NSUInteger sum = 0;
    for (Record *r in _records) {
        sum+=r.price;
    }
    return sum;
}

-(NSUInteger)returnSumOfLastIncomes {
    NSUInteger sum = 0;
    for (Record *r in [self returnIncomes]) {
        sum+=r.price;
    }
    return sum;
}

-(NSUInteger)returnSumOfLastOutcomes {
    NSUInteger sum = 0;
    for (Record *r in [self returnOutcomes]) {
        sum+=r.price;
    }
    return sum;
}

-(NSArray *) returnOutcomes{
    NSDate *today = [NSDate date];
    NSDate *first = [User getFirstDateInMonth];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (Record *r in _records) {
        if (r.category.type == outcome && [self date:r.d isBetweenDate:first andDate:today])
            [arr addObject:r];
    }
    return [self sort:arr];
}

-(void) addRecord: (Record*) record {
    [_records addObject:record];
}
-(void) removeRecord: (Record*) record{
    [_records removeObject:record];
    
}


@end
