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
        [self getInstanceMethod];
        [self replaceMethod];
        [self getMethodImp];
        [self respondsTo];
        [self getViersion];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = cstr2s(class_getName(object_getClass(self)));
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
    PUTS(cstr2s(ivarLayout));
}

- (void)getProperty
{
    objc_property_t property = class_getProperty([WorkingWithClasses class], "string");
    PUTS(cstr2s(property));
}

- (void)addMethod
{
    // TODO:此处types参数还存在一些疑惑，自定义参数和默认参数的顺序
    class_addMethod([WorkingWithClasses class], @selector(aMethod:), (IMP)aMethodIMPA, "v@:@");

    [self performSelector:@selector(aMethod:) withObject:@"argument"];
}

static void aMethodIMPA(id self, SEL _cmd, NSString *words)
{
    PUTS(words);
}

- (void)getInstanceMethod
{
    Method descriptionMethod = class_getInstanceMethod([WorkingWithClasses class], @selector(description));
}

- (void)replaceMethod
{
    class_replaceMethod([WorkingWithClasses class], @selector(aMethod:), (IMP)aMethodIMPB, "v@:");

    [self performSelector:@selector(aMethod:) withObject:nil];
}

void aMethodIMPB(id self, SEL _cmd)
{
    PUTS(@"");
}

- (void)getMethodImp
{
    IMP imp = class_getMethodImplementation([WorkingWithClasses class], @selector(replaceMethod));
    IMP imp2 = class_getMethodImplementation_stret([WorkingWithClasses class], @selector(replaceMethod));
}

- (void)respondsTo
{
    BOOL respond = class_respondsToSelector([WorkingWithClasses class], @selector(getMethodImp));
}

- (void)getViersion
{
    int version = class_getVersion([WorkingWithClasses class]);
}

@end
