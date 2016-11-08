//
//  UIImage+Compression.m
//  CategoryCollection
//
//  Created by Jacky on 16/11/8.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "UIImage+Compression.h"

@implementation UIImage (Compression)

// 按质量压缩
-(UIImage *)reduceScale:(float)scale
{
    NSData *imageData = UIImageJPEGRepresentation(self, scale);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}

//按质量压缩小于300K
-(UIImage *)reduceLess300K
{
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
    int dataSize = (int)imageData.length/1024;
    if (dataSize > 300) {
        //压缩
        CGFloat scale = ((float)300)/((float)dataSize);
        NSData *newImageData = UIImageJPEGRepresentation(self, scale);
        UIImage *newImage = [UIImage imageWithData:newImageData];
        return newImage;
    }
    
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}

//按尺寸压缩
- (UIImage*)imageScaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//rect:要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
- (UIImage*)cutImageWithRect:(CGRect)rect
{
    NSLog(@"image width = %f,height = %f",self.size.width,self.size.height);
    CGImageRef cgimg = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    
    return newImg;
}


//图片缩放剪切, size,目标图片尺寸
- (UIImage*)scaledCutImageToSize:(CGSize)size
{
    float tagScale = size.width/size.height;
    float imageScale = self.size.width/self.size.height;
    
    if ((self.imageOrientation == UIImageOrientationUp) ||(self.imageOrientation == UIImageOrientationDown)) {
        if (imageScale < tagScale) {
            //以高为基准缩放，截宽
            float height = size.height;
            float width = height * imageScale;
            
            UIImage* newImage = [self imageScaledToSize:CGSizeMake(width, height)];
            CGRect newRc = CGRectMake((width-size.width)/2, 0, size.width, size.height);
            
            return [newImage cutImageWithRect:newRc];
            
        }
        else
        {
            //以宽为基准缩放，截高
            float height = size.width/imageScale;
            float width = size.width;
            
            UIImage* newImage = [self imageScaledToSize:CGSizeMake(width, height)];
            CGRect newRc = CGRectMake(0, (height-size.height)/2, size.width, size.height);
            
            return [newImage cutImageWithRect:newRc];
        }
        
    }
    else
    {
        if (imageScale >= tagScale) {
            //以高为基准缩放，截宽
            float height = size.height;
            float width = height * imageScale;
            
            UIImage* newImage = [self imageScaledToSize:CGSizeMake(width, height)];
            CGRect newRc = CGRectMake((width-size.width)/2, 0, size.width, size.height);
            
            return [newImage cutImageWithRect:newRc];
            
        }
        else
        {
            //以宽为基准缩放，截高
            float height = size.width/imageScale;
            float width = size.width;
            
            UIImage* newImage = [self imageScaledToSize:CGSizeMake(width, height)];
            CGRect newRc = CGRectMake(0, (height-size.height)/2, size.width, size.height);
            
            return [newImage cutImageWithRect:newRc];
        }
    }
}


-(UIImage *)cutImageWithRectSize:(CGSize)size necessryPoint:(CGPoint)point{
    //CGPoint newPoint;
    
    //传参判断 必要点错误
    if(point.x > self.size.width || point.y > self.size.height ){
        return nil;
    }
    
    CGFloat finalWidth,finalHeight,finalX,finalY;
    
    CGFloat ratioOrigin = self.size.width/self.size.height;//目标图片的横纵比
    CGFloat ratioTarget = size.width/size.height;//目标图片的横纵比
    
    if (ratioOrigin > ratioTarget) {
        //将原图截成目标图   截取原图的宽
        CGFloat cutWidth = self.size.width - self.size.height * ratioTarget;
        if(self.size.width/2 > point.x){//偏左
            //截取右边
            if((self.size.width - point.x) - point.x > cutWidth){//直接进行右边的截取
                finalX = 0;
            }else{
                finalX = (0 - (self.size.width - point.x) - point.x - cutWidth)/2;
            }
        }else{//偏右
            //截取左边
            if(point.x - (self.size.width - point.x)>cutWidth){//直接在左边进行截取
                finalX = cutWidth;
            }else{
                finalX = cutWidth - (0- (point.x - (self.size.width - point.x) - cutWidth))/2;
            }
        }
        finalY = 0;
        finalHeight = self.size.height;
        finalWidth  = self.size.width - cutWidth;
        
    }else{
        CGFloat cutHeight = self.size.height - self.size.width / ratioTarget;
        //将原图截成目标图   截取原图的高
        if (point.y > (self.size.height - point.y)) {//偏下
            if((point.y - (self.size.height - point.y) - cutHeight) > 0){//直接截取上面
                finalY = cutHeight;
            }else{
                finalY = cutHeight - (0-(point.y - (self.size.height - point.y) - cutHeight))/2;
            }
        }else{//偏上
            if ((self.size.height - point.y) - point.y - cutHeight >0) {//直接截取下面
                finalY = 0;
            }else{
                finalY = (0-(point.y - (self.size.height - point.y) - cutHeight))/2;
            }
        }
        finalX = 0;
        finalHeight = self.size.height - cutHeight;
        finalWidth  = self.size.width;
        
    }
    //这里返回的是比要点在新图的坐标 以下点未进行放缩
    //newPoint = CGPointMake(fabs(point.x - finalX), fabs(point.y - finalY));
    
    CGRect cutRect = CGRectMake(finalX, finalY, finalWidth, finalHeight);
    
    CGImageRef cgimg = CGImageCreateWithImageInRect([self CGImage], cutRect);
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    
    return newImg;
}



@end
