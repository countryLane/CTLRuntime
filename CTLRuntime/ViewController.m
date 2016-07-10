//
//  ViewController.m
//  CTLRuntime
//
//  Created by 王一 on 16/7/10.
//  Copyright © 2016年 王一. All rights reserved.
//

#import "ViewController.h"

#import "WorkingWithClasses.h"


@interface ViewController ()

@property (nonatomic) WorkingWithClasses *workingWithClasses;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    _workingWithClasses = [[WorkingWithClasses alloc] init];
}

@end
