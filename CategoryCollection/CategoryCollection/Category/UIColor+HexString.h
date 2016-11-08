//
//  UIColor+HexString.h
//  CategoryCollection
//
//  Created by Jacky on 16/11/8.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
//十六进制字符串转为UIColor对象
+(UIColor*)colorWithHexString:(NSString*)hexString;

//十六进制字符串转为UIColor对象 alpha：透明度
+(UIColor*)colorWithHexString:(NSString*)hexString alpha:(CGFloat)alpha;

//十六进制数转为UIColor对象
+(UIColor*)colorWithHex:(NSInteger)rgbValue;

//十六进制数转为UIColor对象 alpha：透明度
+(UIColor*)colorWithHex:(NSInteger)rgbValue alpha:(CGFloat)alpha;

@end
