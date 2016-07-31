//
//  AddingClasses.m
//  CTLRuntime
//
//  Created by 王一 on 16/7/31.
//  Copyright © 2016年 王一. All rights reserved.
//

#import "AddingClasses.h"

@implementation AddingClasses

- (instancetype)init
{
    if (self = [super init]) {
        [self addingClass];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = cstr2s(class_getName(object_getClass(self)));
}

- (void)addingClass
{
    Class AddedClass = objc_allocateClassPair([NSObject class], "AddedClass", 0);
    if (!AddedClass) {
        return;
    }
    class_addMethod(AddedClass, @selector(aSelectorA), (IMP)aMethodIMPA, "v@:");
    objc_registerClassPair(AddedClass);

    id addedClassObject = [[AddedClass alloc] init];
    [addedClassObject performSelector:@selector(aSelectorA)];
}

static void aMethodIMPA(id self, SEL _cmd)
{
    PUTS(@"添加了一个方法");
}

@end
