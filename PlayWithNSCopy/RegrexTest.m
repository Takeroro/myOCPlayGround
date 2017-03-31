//
//  RegrexTest.m
//  PlayWithNSCopy
//
//  Created by Caotingjun on 2017/2/7.
//  Copyright © 2017年 Caotingjun. All rights reserved.
//

#import "RegrexTest.h"

@implementation RegrexTest


+(void)go {
    NSString *orginalString = @",0,f,m,b";
    NSString *regExpString  = @"f";
    NSString *template      = @"";
    
    
    NSString *result =
        [orginalString stringByReplacingOccurrencesOfString:regExpString
                                                 withString:template
                                                    options:NSRegularExpressionSearch // 注意里要选择这个枚举项,这个是用来匹配正则表达式的
                                                      range:NSMakeRange (0, orginalString.length)];
    NSLog (@"\nsearchStr = %@\nresultStr = %@", orginalString, result);
    
    NSString *html = @"abcder<img src=\"www.abc.com\"/>abc";
    NSString *regexPattern = @"^<img (?!.*baidu).*$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    
    NSArray *resultArray = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    for (NSTextCheckingResult *result in resultArray) {
        NSLog(@"result = %@",[html substringWithRange:result.range]);
    }
}
@end
