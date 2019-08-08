//
//  animal.m
//  runtime
//
//  Created by 张旭 on 2017/6/19.
//  Copyright © 2017年 zhangXu. All rights reserved.
//

#import "animal.h"
#import <objc/message.h>
@implementation animal

void eat(id self ,SEL sel){
    
    
    NSLog(@"%@  %@",self,NSStringFromSelector(sel));
    
    
}


// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法

+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(eat)) {
      //动态添加eat方法
        
        //第一个参数:给哪个类添加方法
        //第二个参数:添加方法的方法编号
        //第三个参数:添加方法的函数现实(函数地址)
        //第四个参数:函数的类型,(返回值+参数类型)v:void @:对象->self :SEL ->_cmd
        
        class_addMethod(self, @selector(eat), eat, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}


@end
