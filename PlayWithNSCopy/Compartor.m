//
//  Compartor.m
//  PlayWithNSCopy
//
//  Created by Caotingjun on 16/11/25.
//  Copyright © 2016年 Caotingjun. All rights reserved.
//

#import "Compartor.h"

@implementation Compartor

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self doCompare];
    }
    return self;
}

- (void)doCompare
{
    NSString *str1 = @"abc";
    NSString *str2 = @"abc";
    NSString *str3 = @"ABC";
    
    int i1 = 0;
    int i2 = 4;
    
    NSComparisonResult result = [str1 caseInsensitiveCompare:str2];
    NSComparisonResult result1 = [str2 compare:str3];
}
@end
