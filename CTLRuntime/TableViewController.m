//
//  TableViewController.m
//  CTLRuntime
//
//  Created by 王一 on 16/7/10.
//  Copyright © 2016年 王一. All rights reserved.
//

#import "TableViewController.h"

#import "WorkingWithClasses.h"
#import "AddingClasses.h"


@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>
@end


@implementation TableViewController

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Runtime";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"] ? : [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"WorkingWithClasses";
            break;
        }
        case 1: {
            cell.textLabel.text = @"AddingClasses";
            break;
        }
        default:
            cell.textLabel.text = @"UITableViewCell";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return;
    }

    switch (indexPath.row) {
        case 0: {
            WorkingWithClasses *workingWithClasses = [[WorkingWithClasses alloc] init];
            [self.navigationController pushViewController:workingWithClasses animated:YES];
            break;
        }
        case 1: {
            AddingClasses *addingClasses = [[AddingClasses alloc] init];
            [self.navigationController pushViewController:addingClasses animated:YES];
            break;
        }
    }
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

@end
