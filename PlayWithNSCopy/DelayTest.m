//
//  DelayTest.m
//  PlayWithNSCopy
//
//  Created by Caotingjun on 2017/3/24.
//  Copyright © 2017年 Caotingjun. All rights reserved.
//

#import "DelayTest.h"

//static 修饰全局变量
static const int abc = 1; //凡是const皆为全局变量，用static 修饰来限制作用域--防重名。

//static 修饰方法 --》 生命周期不会改变？
//在函数的返回类型前加上关键字static，函数就被定义成为静态函数。
//函数的定义和声明默认情况下是extern的，但静态函数只是在声明他的文件当中可见，不能被其他文件所用。只能被本文件中的函数调用，而不能被同一程序其它文件中的函数调用
//好处：1）其他文件中可以定义相同名字的函数，不会发生冲突
//2） 静态函数不能被其他文件所用。

NSMutableDictionary *dateFormatterMap() {
    static NSMutableDictionary *map = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        map = [NSMutableDictionary new];
    });
    return map;
}


@implementation DelayTest

- (void)go
{
    //not work
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"delay 3s");
    });
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [dateFormatterMap() setObject:@"" forKey:@""];
}

@end
