//
//  JXViewController.m
//  JXRequestDemo
//
//  Created by andy on 14-7-2.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "JXViewController.h"

#import "JXWeatherRequest.h"

@interface JXViewController ()<UITableViewDelegate,
    UITableViewDataSource>
{
    NSArray *_dataArray;

    UITableView *_tableView;
}
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation JXViewController

- (NSArray *)dataArray {
    _dataArray = @[@"weatherRequest"];
    return _dataArray;
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellId = @"CellId";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SEL selector = NSSelectorFromString([self.dataArray objectAtIndex:indexPath.row]);
    [self performSelector:selector];
}

#pragma mark -
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"JXRequest";
    
    [self createTableView];
}

- (void)weatherRequest {
    JXWeatherRequest *weatherRequest = [JXWeatherRequest request];
    
    weatherRequest.address = @"西三旗";
    
    [weatherRequest successCallback:^(id result) {
       
        NSLog(@"%@", result);
    
    } errorCallback:^(NSError *error) {
       
        NSLog(@"%@", error);
        
    }];
    
    [weatherRequest statusErrorCallback:^(NSInteger code) {
       
        NSLog(@"%ld", code);
    }];
    
    [weatherRequest start];
}

@end
