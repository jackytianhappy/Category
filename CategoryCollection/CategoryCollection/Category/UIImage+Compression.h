//
//  UIImage+Compression.h
//  CategoryCollection
//
//  Created by Jacky on 16/11/8.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compression)

// 按质量压缩
-(UIImage *)reduceScale:(float)scale;

//按质量压缩小于300K
-(UIImage *)reduceLess300K;

//按尺寸压缩
- (UIImage*)imageScaledToSize:(CGSize)newSize;

//rect:要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
- (UIImage*)cutImageWithRect:(CGRect)rect;

//图片缩放剪切,size,目标图片尺寸
- (UIImage*)scaledCutImageToSize:(CGSize)size;

//size 目标尺寸
//point 所截取图片之后必须存在的点 这个点尽量在中间，但不是必须
-(UIImage *)cutImageWithRectSize:(CGSize)size necessryPoint:(CGPoint)point;


@end
