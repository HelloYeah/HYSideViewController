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
    cell.backgroundColor = [UIColor blueColor];
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"被点击了第%ld行",indexPath.row);
    if(self.sideblock) self.sideblock();
}

@end
