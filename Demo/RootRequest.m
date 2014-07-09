//
//  RootRequest.m
//  JXRequestDemo
//
//  Created by andy on 14-7-2.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "RootRequest.h"

#define MESSAGE_LOAD    @"加载中.."
#define MESSAGE_SUCCESS @"加载成功"
#define MESSAGE_ERROR   @"加载失败"

@implementation RootRequest

- (id)init {

    if (self = [super init]) {
        
        // 初始化SVProgressHUD相关参数
        
        self.displayable = YES; // 显示控件
        self.hasMessage  = YES; // 显示内容
        
        self.loadingMessage = MESSAGE_LOAD;
        self.successMessage = MESSAGE_SUCCESS;
        self.errorMessage   = MESSAGE_ERROR;
    }
    
    return self;
}

- (BOOL)checkResponse:(id)result {
    if (![result isKindOfClass:[NSDictionary class]])
        return NO;
     
    NSDictionary *status = [result objectForKey:@"status"];
    NSInteger code = [[status objectForKey:@"code"] integerValue];
    
    if (code != 0) {
        if (self.statusErrorBlock) {
            self.statusErrorBlock(code);
        }
        return NO;
    }
     
    return YES;
}
- (void)statusError {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"其他用户登入" delegate:nil cancelButtonTitle:@"修改密码" otherButtonTitles:@"重新登入", nil];
    [alertView show];
}

@end
