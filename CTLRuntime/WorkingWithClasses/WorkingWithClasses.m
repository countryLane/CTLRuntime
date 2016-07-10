//
//  WorkingWithClasses.m
//  CTLRuntime
//
//  Created by 王一 on 16/7/10.
//  Copyright © 2016年 王一. All rights reserved.
//

#import "WorkingWithClasses.h"

@interface WorkingWithClasses ()

@end


@implementation WorkingWithClasses

- (instancetype)init
{
    if (self = [super init]) {
        [self getClassName];
        [self getSuperClass];
        [self setSuperClass];
    }
    return self;
}

- (void)getClassName
{
    NSString *className = cstr2s(class_getName([WorkingWithClasses class]));
    NSLog(@"class_getName : %@", className);
}

- (void)getSuperClass
{
    // You should usually use NSObject's superclass method instead of this function.
    Class superClass = class_getSuperclass([WorkingWithClasses class]);
    NSLog(@"class_getSuperclass : %@", superClass);
}

- (void)setSuperClass
{
    // 文档说明了class_setSuperclass这个函数不应该用，而且在iOS 2.0就废弃了
    class_setSuperclass([WorkingWithClasses class], [UIView class]);
    [self getSuperClass];
}

@end
