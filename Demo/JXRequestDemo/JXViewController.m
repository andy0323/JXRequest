//
//  JXViewController.m
//  JXRequestDemo
//
//  Created by andy on 14-7-2.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "JXViewController.h"

#import "LoginRequest.h"
#import "UploadHeaderRequest.h"

@interface JXViewController ()<UITableViewDelegate,
    UITableViewDataSource>
{
    NSArray *_dataArray;
    UITableView *_tableView;
    
    NSString *_token;
    NSString *_userId;
}
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation JXViewController

- (NSArray *)dataArray {
    _dataArray = @[@"login", @"uploadHeaderIcon"];
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

- (void)login {
    LoginRequest *request = [LoginRequest request];
    request.username = @"11000490";
    request.password = @"123456";
    
    [request successCallback:^(id result) {
        
        NSDictionary *data = [[result objectForKey:@"data"] lastObject];
        _token = [data objectForKey:@"tokenId"];
        _userId = [data objectForKey:@"id"];
        
    }];
    
    [request statusErrorCallback:^(NSInteger code) {
        NSLog(@"%d", code);
    }];
    
    
    [request start];
}

- (void)uploadHeaderIcon {
    
    UploadHeaderRequest *request = [UploadHeaderRequest request];
    request.tokenId = _token;
    request.userId = _userId;
    
    
    [request successCallback:^(id result) {
        NSLog(@"%@", result);
    }];
    
    [request errorCallback:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
    
    [request statusErrorCallback:^(NSInteger code) {
        NSLog(@"%d", code);
    }];
    
    [request start];
}
@end
