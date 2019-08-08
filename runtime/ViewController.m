//
//  ViewController.m
//  runtime
//
//  Created by 张旭 on 2017/6/16.
//  Copyright © 2017年 zhangXu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Person.h"
#import "UIImage+Imge.h"
#import "animal.h"
#import "NSObject+Property.h"
#import "NSObject+Log.h"
#import "Status.h"
#import "NSObject+Model.h"
@interface ViewController ()
@property (nonatomic ,strong)NSMutableArray *statuses;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc]init];
    
    [p eat];
   
    //NSClassFromString(@"Person")  类转字符串  动态获取
//    SEL eatSelector = NSSelectorFromString(@"eat");
    
       // 本质：让对象发送消息
//    objc_msgSend(NSClassFromString(@"Person"),eatSelector);
    
     objc_msgSend(p,@selector(eat));
    
    
//     调用类方法的方式：两种
//     第一种通过类名调用
    [Person eat];
    // 第二种通过类对象调用
    [[Person class] eat];
    
    // 用类名调用类方法，底层会自动把类名转换成类对象调用
    // 本质：让类对象发送消息
    objc_msgSend([Person class], @selector(eat));
    
    
    //**************************************************************//
    //使用RunTime交换方法。
    // 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    
    UIImage *image = [UIImage imageNamed:@"12322"];
    
    
 
    
        //**************************************************************//
//    3.动态添加方法
//    
//    使用场景：一个类的方法非常多，加载到内存的时候也非常的耗费资源，这时候就可以给该类动态创建方法来解决。
//    
//    经典面试题：有没有使用performSelector，其实主要想问你有没有动态添加过方法。
    
    
    animal *a  = [[animal alloc]init];
    
    // 默认person，没有实现eat方法，可以通过performSelector调用，但是会报错。
    // 动态添加方法就不会报错
    [a performSelector:@selector(eat)];
    
    
    
        //**************************************************************//
//    4.动态添加属性
//    原理：给一个类声明属性，其实本质就是给这个类添加关联，并不是直接把这个值的内存空间添加到类的内存空间。
    
      // 给系统NSObject类动态添加属性name
    NSObject *objc = [[NSObject alloc]init];
    objc.name = @"大大一大大";
    
     NSLog(@"%@",objc.name);
    
    
    //**************************************************************//

    
//    5.字典转模型
//    
//    设计模型：字典转模型的第一步
//    模型属性，通常需要跟字典中的key一一对应
//    问题：一个一个的生成模型属性，很慢？
//    需求：能不能自动根据一个字典，生成对应的属性。
//    解决：提供一个分类，专门根据字典生成对应的属性字符串。

    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"man",@"sex",@"18",@"age",@"zhangXu",@"name",nil];
    
      NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"man",@"sex",nil];
    
    [NSObject resolveDict:dic];

      
    [Status statusWithDict:dic1];
    
    
    
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"address.plist" ofType:nil];
    NSDictionary *statusDcit = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    
    NSArray *dictArr = statusDcit[@"address"];
    
//    [NSObject resolveDict:dictArr[0][@"address"]];
    _statuses = [NSMutableArray array];
    
    for (NSDictionary * dict in dictArr) {
        Status *status = [Status modelWithDict:dict];
        
        [_statuses addObject:status];
    }
    
    NSLog(@"%@",_statuses);
    
    // 测试数据
    NSLog(@"%@ %@",_statuses,[_statuses[0] name]);
    
    
    

    // Do any additional setup after loading the view, typically from a nib.
}


-(void)eat{
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
