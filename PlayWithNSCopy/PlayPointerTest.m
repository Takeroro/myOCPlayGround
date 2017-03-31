//
//  PlayPointerTest.m
//  PlayWithNSCopy
//
//  Created by Caotingjun on 2017/3/8.
//  Copyright © 2017年 Caotingjun. All rights reserved.
//
 
#import "PlayPointerTest.h"

typedef struct Node{
    int data;
    struct Node *next;
} Node;

typedef struct Node *List;

@interface TestData : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic, assign) NSInteger value;
@end

@implementation TestData
@end

const int abc = 3;
@implementation PlayPointerTest


- (void)go {
    TestData *data = [[TestData alloc] init];
    data.value = 3;
    [self doSthAndReturn:&data];
    NSLog(@"data.value = %ld",(long)data.value);
    
    [self doOtherThing:data];
    NSLog(@"data.key = %@", data.key);
    
    int a = 0;
    [self doSucking:a];
    NSLog(@"a = %d",a);
}

- (void)doSthAndReturn:(TestData **) dataAdrs
{
    TestData *data = [TestData new];
    data.value = 5;
    
    // dataAdrs 指针的指针
    // *dataAdrs （解一下）-》指针  *dataAdrs = data 即对指针赋值
    *dataAdrs = data;
}

//当参数是指针时，传参传的直接是地址了，形参与实参实际上是同一个东西了
- (void)doOtherThing:(TestData *) data
{
    data.key = @"asd";
}

//当参数是基本数据类型时，形参与实参并无实质关系
- (void)doSucking:(int) a
{
    a = 3;
}

@end
