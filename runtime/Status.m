//
//  Status.m
//  runtime
//
//  Created by 张旭 on 2017/6/19.
//  Copyright © 2017年 zhangXu. All rights reserved.
//

#import "Status.h"

@implementation Status
+(instancetype)statusWithDict:(NSDictionary *)dict{
    
//    字典转模型的方式一：KVC
    
    Status *status = [[self alloc]init];
    
    
    [status setValuesForKeysWithDictionary:dict];
    
    NSLog(@"%@",status);
    
    return status;
    
}


//
//KVC字典转模型弊端：必须保证，模型中的属性和字典中的key一一对应。
//如果不一致，就会调用[<Status 0x7fa74b545d60> setValue:forUndefinedKey:]
//报key找不到的错。
//分析:模型中的属性和字典的key不一一对应，系统就会调用setValue:forUndefinedKey:报错。
//解决:重写对象的setValue:forUndefinedKey:,把系统的方法覆盖，
//就能继续使用KVC，字典转模型了。


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}



@end
