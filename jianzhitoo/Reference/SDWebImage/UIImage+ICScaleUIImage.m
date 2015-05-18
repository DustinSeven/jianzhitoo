//
//  UIImage+ICScaleUIImage.m
//  Chemistry
//
//  Created by creasyma on 14-9-22.
//  Copyright (c) 2014年 creasyma. All rights reserved.
//

#import "UIImage+ICScaleUIImage.h"



@implementation UIImage (ICScaleUIImage)

- (UIImage *)scaleToCustomSize
{
    CGSize size = CGSizeMake(CustomScaleImageWidth, CustomScaleImageHeight);
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRatio = size.height*1.0/height;
    
    width = width*verticalRatio;
    height = height*verticalRatio;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
