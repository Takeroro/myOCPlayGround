//
//  NSString+Addtion.m
//  PlayWithNSCopy
//
//  Created by Terrence on 2017/4/10.
//  Copyright © 2017年 Caotingjun. All rights reserved.
//

#import "NSString+Addtion.h"

@implementation NSString (Addtion)

- (NSArray *)getLinksFromHtml
{
    NSMutableArray *links = [NSMutableArray new];
    
//    NSString *self = @"href=\"www.baidu.com\"";
    
    NSString *regexStr = @"href=\"(.*?)\"";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        for (int i = 0; i < obj.numberOfRanges; i++) {
//            NSLog(@"result = %@",[self substringWithRange:[obj rangeAtIndex:i]]);
//            [links addObject:[self substringWithRange:[obj rangeAtIndex:1]]];
//        }
        if (obj.numberOfRanges > 1) {
//            NSLog(@"result = %@",[self substringWithRange:[obj rangeAtIndex:1]]);
            [links addObject:[self substringWithRange:[obj rangeAtIndex:1]]];
        }

    }];

    return links;
}
@end
