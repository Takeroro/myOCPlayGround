//
//  main.m
//  PlayWithNSCopy
//
//  Created by Caotingjun on 16/10/21.
//  Copyright © 2016年 Caotingjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNPerson.h"
#import <objc/runtime.h>
#import "Compartor.h"
#import "RegrexTest.h"
#import "PlayPointerTest.h"
#import "CharacterSet.h"
#import "DelayTest.h"
#import "NSString+Addtion.h"

const static int schmeaVersionHistory[] = {1};
#define LATEST_VERSION (schmeaVersionHistory[sizeof(schmeaVersionHistory) / sizeof(schmeaVersionHistory[0]) - 1])

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        DNPerson *person = [[DNPerson alloc] init];
        /*
         *测试Dynamic property
         必须手动编写setter和getter,否则必奔！
         person.testDynamic = @"123";
         */
        
        person.age = 1;
        NSMutableString *testName = [NSMutableString stringWithFormat:@"abc"];
        person.name = testName;
        [testName appendString:@"123"];
        
        //通过KVC获取类内部变量。
        DNPerson *copy = [person copy];
        NSLog(@"print inner ivar = %@",[copy valueForKey:@"ivar"]);
        NSLog(@"print inner _ivar = %@",[copy valueForKey:@"_ivar"]);
        
//        NSLog(@"print valueForKey unknown %@",[copy valueForKey:@"unknown"]);//will crash once obj don`t have the key
        
        //diffence between valueForKey: & valuesForKeyPath:
        copy.cp = [[DNPerson alloc] initWithName:@"sarah" age:0];
        NSLog(@"print cp.name = %@",[copy valueForKeyPath:@"cp.name"]);
        copy = nil;
        NSLog(@"%lu",(unsigned long)copy.age);
        
        unsigned int pCount = 0;
        unsigned int iCount = 0;
        unsigned int mCount = 0;
        
        objc_property_t *properties = class_copyPropertyList([DNPerson class], &pCount);
        Ivar *ivars = class_copyIvarList([DNPerson class], &iCount);
        Method *methods = class_copyMethodList([DNPerson class], &mCount);
        
        //class_copyPropertyList 把property全拿出来了，但没拿出内部的_ivar
        NSLog(@"property count = %d", pCount);
        for (NSInteger i = 0; i < pCount; i++) {
            ///
            objc_property_t property = properties[i];
            const char *propName = property_getName(property);
            ///
            NSString *name = @(property_getName(properties[i]));
            NSString *attributes = @(property_getAttributes(properties[i]));
            NSLog(@"property:%@--------attributes:%@", name, attributes);
            unsigned int attrCount = 0;
            objc_property_attribute_t * attrs = property_copyAttributeList(properties[i], &attrCount);
            //遍历property的属性
            for (unsigned int j = 0; j < attrCount; j++) {
                objc_property_attribute_t attr = attrs[j];
                const char *name = attr.name;
                const char *value = attr.value;
                NSLog(@"atr name:%s  value:%s",name,value);
            }
        }
        
        //class_copyIvarList ,被@dynamic修饰的 testDynamic，取不出来，估计不仅没自动生成setter,getter,连ivar也没生成
        NSLog(@"ivar count = %d", iCount);
        for (NSInteger i = 0; i < iCount; i++) {
            NSString *name = @(ivar_getName(ivars[i]));
            NSString *type = @(ivar_getTypeEncoding(ivars[i]));
            //取出来的ivarname 都有_前缀
            NSLog(@"ivar:%@-------type：%@",name, type);
        }
        
        NSLog(@"method count = %d", mCount);
        for (NSInteger i = 0; i < mCount; i++) {
            NSString *methodName = NSStringFromSelector(method_getName(methods[i]));
//            IMP test = method_getImplementation(methods[i]);
            NSLog(@"methodName = %@",methodName);
        }
//        object_getInstanceVariable()
        DNPerson *xiaoming = [[DNPerson alloc] initWithName:@"xiaoming" age:123];
        
        //取出来的ivarname 都有_前缀 ,propertyName 无_前缀
        Ivar ivar = class_getInstanceVariable([DNPerson class],"_name");
        // object_getIvar 用来取值
        NSString *nameByRunTime = object_getIvar(xiaoming, ivar);
        NSLog(@"xiaoming.name (by object_getIVar) = %@",nameByRunTime);

        
        Ivar innerIvar = class_getInstanceVariable([DNPerson class], "_ivar");
        NSString *innerIvarValue = object_getIvar(xiaoming, innerIvar);
        NSLog(@"innerIvarValue (by object_getIVar) = %@",innerIvarValue);
        
        Compartor *comp = [[Compartor alloc]init];
        [RegrexTest go];
        
//        int a = 2;
//        if (a >= 3) {
//            return true;
//        } else {
//            return false;
//        }
        DNPerson *t1 = [[DNPerson alloc] initWithName:@"abc" age:3];
        DNPerson *t2 = t1;
        {
//        DNPerson *t1 = [[DNPerson alloc] initWithName:@"abc" age:3];
        t1.age = 3;
//        DNPerson *t2 = t1;
        NSLog(@"t1.age = %lu", (unsigned long)t1.age);
        NSLog(@"t2.age = %lu", (unsigned long)t2.age);
        
        NSLog(@"p 1= %p", t1);
        t1 = nil;
        NSLog(@"t2.age = %lu", (unsigned long)t2.age);
        t2 = nil;
        
        }
        
        
        [[PlayPointerTest alloc] go];
        
        [[CharacterSet alloc] go];
        
        int a = 330;
        NSLog(@"a = %.2d",a);
        
        [[DelayTest new] go];
        
    int size1 = sizeof(schmeaVersionHistory);
    int size2 = sizeof(schmeaVersionHistory[0]);
    NSLog(@"size1 = %d, size2 = %d",size1, size2);
        {
            
            
            extern int abc;//出去找，可以找到.m里面的
            NSLog(@"abc = %d",abc);
        }
        NSString *sampleStr = @"href=\"www.baidu.com\"balalabllablalbhref=\"www.piaohua.com\"";

//        NSString *sampleStr = @"";
        NSArray *test = [sampleStr getLinksFromHtml];
        
    }
    return 0;
}
