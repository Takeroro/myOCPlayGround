//
//  DNPerson.m
//  PlayWithNSCopy
//
//  Created by Caotingjun on 16/10/21.
//  Copyright © 2016年 Caotingjun. All rights reserved.
//

#import "DNPerson.h"

@interface DNPerson()
{
    NSString *_ivar;
}
@end

@implementation DNPerson

@dynamic testDynamic;

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age
{
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
        _ivar = @"I am an _iavar";
    }
    return  self;
}

- (id)copyWithZone:(NSZone *)zone
{
//    DNPerson *copy = [[self class] allocWithZone:zone];
    DNPerson *copy = [[[self class] allocWithZone:zone] initWithName:self.name age:self.age];
//    [self class];
    return copy;
}

+ (void)fuckSth
{
    
}
@end
