//
//  UIColor+HexString.m
//  CategoryCollection
//
//  Created by Jacky on 16/11/8.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)
//十六进制字符串转为UIColor对象
+(UIColor*)colorWithHexString:(NSString*)hexString
{
    return [self colorWithHexString:hexString alpha:1.0];
}

//十六进制字符串转为UIColor对象 alpha：透明度
+(UIColor*)colorWithHexString:(NSString*)hexString alpha:(CGFloat)alpha
{
    //判断颜色字符为空
    if (!hexString) {
        return nil;
    }
    
    //判断格式
    NSString* number=@"^((0X|0x)?[0-9|a-f|A-F]{6})$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    BOOL isHexNum = [numberPre evaluateWithObject:hexString];
    if (isHexNum) {
        //16进制字符串
        if (hexString.length == 8) {
            hexString = [hexString substringFromIndex:2];
        }
    }
    else
    {
        NSLog(@"格式不对，非16进制字符串");
        return nil;
    }
    
    //转换
    const char *chHex = [hexString UTF8String];
    NSInteger rgbValue = strtol(chHex,NULL,16);
    
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

//十六进制数转为UIColor对象
+(UIColor*)colorWithHex:(NSInteger)rgbValue
{
    return [self colorWithHex:rgbValue alpha:1.0f];
}

//十六进制数转为UIColor对象 alpha：透明度
+(UIColor*)colorWithHex:(NSInteger)rgbValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(alpha)];
}


@end
