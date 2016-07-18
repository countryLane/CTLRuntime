//
//  WorkingWithClasses.m
//  CTLRuntime
//
//  Created by 王一 on 16/7/10.
//  Copyright © 2016年 王一. All rights reserved.
//

#import "WorkingWithClasses.h"


@interface WorkingWithClasses ()

@property (nonatomic) int index1;
@property (nonatomic) NSString *string;
@property (nonatomic, weak) NSString *weakString;

@end


@implementation WorkingWithClasses

static NSInteger count = 1;

- (instancetype)init
{
    if (self = [super init]) {
        [self getClassName];
        [self getSuperClass];
        [self setSuperClass];
        [self isMetaClass];
        [self getInstanceSize];
        [self getInstanceIvar];
        [self getClassIvar];
        [self getCopyIvarList];
        [self getIvarLayout];
        [self getProperty];
        [self addMethod];
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
    Class originClass = class_setSuperclass([WorkingWithClasses class], [UIView class]);
    [self getSuperClass];
    class_setSuperclass([WorkingWithClasses class], originClass);
}

- (void)isMetaClass
{
    BOOL workingwithclassesIsMetaClass = class_isMetaClass([WorkingWithClasses class]);
    NSLog(@"workingwithclassesIsMetaClass : %d", workingwithclassesIsMetaClass);
}

- (void)getInstanceSize
{
    size_t instanceSize = class_getInstanceSize([WorkingWithClasses class]);
    NSLog(@"%ld", (long)instanceSize);
}

- (void)getInstanceIvar
{
    Ivar instanceIvar = class_getInstanceVariable([WorkingWithClasses class], "_index1");
}

- (void)getClassIvar
{
    // 对这个方法感到很奇怪，类变量？难道是static全局变量?
    Ivar classIvar = class_getClassVariable([WorkingWithClasses class], "");
}

- (void)getCopyIvarList
{
    unsigned count = 0;
    Ivar *ivarList = class_copyIvarList([WorkingWithClasses class], &count);
    free(ivarList);
}

- (void)getIvarLayout
{
    const char *ivarLayout = class_getIvarLayout([WorkingWithClasses class]);
    puts(ivarLayout);
}

- (void)getProperty
{
    objc_property_t property = class_getProperty([WorkingWithClasses class], "string");
    puts(property);
}

- (void)addMethod
{
    class_addMethod([WorkingWithClasses class], @selector(aMethod), (IMP)aMethodIMP, "v@:");
}

void aMethodIMP(id self, SEL _cmd)
{
    puts(__FUNCTION__);
}

@end
