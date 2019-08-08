//
//  UIImage+Imge.m
//  runtime
//
//  Created by 张旭 on 2017/6/16.
//  Copyright © 2017年 zhangXu. All rights reserved.
//

#import "UIImage+Imge.h"
#import <objc/message.h>
@implementation UIImage (Imge)


+ (instancetype)imageWithName:(NSString *)name{
    
    UIImage *image = [self imageWithName:name];
    
    if (image == nil) {
        NSLog(@"加载空的图片");
    }
    return image;
}


+ (void)load{
    //交换方法
    //获取imageName方法地址
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    
    
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    
    //交换方法地址,相当于交换实现方式
    method_exchangeImplementations(imageWithName, imageName);
    
    // 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.
    
}

@end
