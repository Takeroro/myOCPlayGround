//
//  DNPerson.h
//  PlayWithNSCopy
//
//  Created by Caotingjun on 16/10/21.
//  Copyright © 2016年 Caotingjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNPerson : NSObject<NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, strong) DNPerson *cp;
@property (nonatomic, strong) NSString *testDynamic;

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age;
@end
