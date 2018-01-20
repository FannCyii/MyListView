//
//  UIColor+KIVBaseColor.m
//  Demolibrarys
//
//  Created by Fann on 20/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "UIColor+KIVBaseColor.h"

@implementation UIColor (KIVBaseColor)

//蓝色
+ (UIColor *)Blue
{
    return [KIVColor hex:@"#23D3DE"];
}

//深黄
+ (UIColor *)blackYellow
{
    return [KIVColor hex:@"#F4CA6E"];
}

//浅黄
+ (UIColor *)lightYellow
{
    return [KIVColor hex:@"#F4C04C"];
}

//深灰
+ (UIColor *)blackGray
{
    return [KIVColor hex:@"#585A61"];
}

//浅灰
+ (UIColor *)lightGray
{
    return [KIVColor hex:@"2E313C"];
}

//标题黑
+ (UIColor *)titleBlack
{
    return [KIVColor hex:@"2E313C"];
}

//标题灰
+ (UIColor *)titleGray
{
    return [KIVColor hex:@"#BBBCC0"];
}

+ (UIColor *)kGreen
{
    return [KIVColor hex:@"#64CA32"];
}

@end
