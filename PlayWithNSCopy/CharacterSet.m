//
//  CharacterSet.m
//  PlayWithNSCopy
//
//  Created by Caotingjun on 2017/3/15.
//  Copyright © 2017年 Caotingjun. All rights reserved.
//

#import "CharacterSet.h"

@implementation CharacterSet

- (void)go
{
    //yyfe://mobile/command?argument=argument
    NSString *testStr = @"yyfe://mobile/command?argument=argument|dick = 3";
    NSDictionary *dic = [self dictionaryFromJumpParams:testStr];
    NSLog(@"%@",dic);
}
- (NSDictionary *)dictionaryFromJumpParams:(NSString *)jumpParams
{
    NSArray *params = [jumpParams componentsSeparatedByString:@"|||"];
    NSMutableDictionary *output = [NSMutableDictionary dictionaryWithCapacity:params.count];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"="];
    for (NSString *param in params) {
        NSRange range = [param rangeOfCharacterFromSet:characterSet];
        if (range.location != NSNotFound) {
            NSString *aKey = [param substringToIndex:range.location];
            NSString *aValue = [param substringFromIndex:(range.location + range.length)];
            [output setObject:aValue forKey:aKey];
        }
    }
    return output;
}

@end
