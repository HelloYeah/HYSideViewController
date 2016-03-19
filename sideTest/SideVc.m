//
//  SideVc.m
//  sideTest
//
//  Created by HelloYeah on 16/3/18.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "SideVc.h"

@implementation SideVc

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sideCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"sideCell" forIndexPath:indexPath];
    NSLog(@"zzzz");
    cell.backgroundColor = [UIColor blueColor];
    cell.detailTextLabel.text = @"111111111";
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行",indexPath.row];
    return cell;
}

@end
