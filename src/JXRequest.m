#import "JXRequest.h"

@implementation JXRequest

- (id)init {
    
    if (self = [super init]) {
        _params = [NSMutableDictionary dictionary];
        
        _keyView = [UIApplication sharedApplication].delegate.window;
    }
    
    return self;
}

/**
 *  类方法创建对象
 *
 *  @return 初始化对象
 */
+ (id)request {
    JXRequest *request = [[[self class] alloc] init];
    return request;
}

#pragma mark -
#pragma mark - 继承类对象调用

/**
 *  外部调用该函数, 获取解析完成的数据源
 */
- (void)successCallback:(void (^)(id))successBlock {
    self.successBlock = successBlock;
}

- (void)errorCallback:(void (^)(NSError *error))errorBlock {
    self.errorBlock = errorBlock;
}

- (void)successCallback:(void (^)(id))successBlock
          errorCallback:(void (^)(NSError *error))errorBlock {
    self.successBlock = successBlock;
    self.errorBlock = errorBlock;
}
- (void)statusErrorCallback:(void (^)(NSInteger code))statusErrorBlock {
    self.statusErrorBlock = statusErrorBlock;
}

/**
 *  开始请求
 */
- (void)start{
}

#pragma mark -
#pragma mark - 开始请求数据函数, 用于重写start时调用

- (void)startGetRequest:(NSString *)url params:(NSDictionary *)params {
    [self prepareConnection];
    [CommonRequest getRequestUrl:url
                        parameters:params
                         WithBlock:^(id result, NSError *error) {
                             [self callback:result error:error];
                         }];
}

- (void)startPostRequest:(NSString *)url params:(NSDictionary *)params {
    [self prepareConnection];
    [CommonRequest postRequestUrl:url
                         parameters:params
                          WithBlock:^(id result, NSError *error) {
                              [self callback:result error:error];
                          }];
}

- (void)startUploadImage:(UIImage *)image url:(NSString *)url params:(NSDictionary *)params {
    [self prepareConnection];
    [CommonRequest uploadImage:image
                             url:url
                          params:params
                       WithBlock:^(id result, NSError *error) {
                           [self callback:result error:error];
                          }];
}

/**
 *  请求开始前调用
 */
- (void)prepareConnection {
    // 防止重复下载
    if (_isLoading == YES)
        return;
    
    _isLoading = YES;
    
    // 开始loading..
    [self showLoadingProgress];
}

/**
 *  请求完成, 开始回调该函数
 */
- (void)callback:(id)result error:(NSError *)error {
    _isLoading = NO;
    
    if (error) {
        [self showErrorProgress];
        self.errorBlock(error);
        return;
    }
    
    // 检测状态码
    BOOL res = [self checkResponse:result];
    
    if (res) {
        // 验证成功, 显示成功提示, 回调状态码正确 --> 开始解析数据源并回调
        [self showSuccessProgress];
        [self statusSuccess:result];
    }else {
        // 验证失败, 将提示框收回, 回调状态码错误 --> 开始处理验证码错误的情况
        [SVProgressHUD dismiss];
        [self statusError];
    }
}

#pragma mark -
#pragma mark - 检测是否出现状态码错误

/**
 *  检测数据状态码是否正确
 *
 *  @param result 获取的数据源
 *
 *  @return YES表示正确 / NO表示不正确
 */
- (BOOL)checkResponse:(id)result {
    return NO;
}

/**
 *  状态码出现错误
 */
- (void)statusError {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"验证码不通过" delegate:nil
                                          cancelButtonTitle:@"需要重写子类"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
}

/**
 *  状态码验证通过, 解析回调
 */
- (void)statusSuccess:(id)result {
    self.successBlock([self parseResponse:result]);
}

/**
 *  解析数据源, 子类需重写该函数
 */
- (id)parseResponse:(id)result {
    return result;
}

#pragma mark -
#pragma mark - 默认的显示方式, 如果需要可重写

- (void)showLoading {
    [SVProgressHUD showInView:self.keyView status:_loadingMessage networkIndicator:YES];
}
- (void)showSuccess {
    [SVProgressHUD dismissWithSuccess:self.successMessage];
}
- (void)showError {
    [SVProgressHUD dismissWithError:self.errorMessage];
}

#pragma mark -
#pragma mark - 显示/不显示 SVProgress Message

- (void)showLoadingProgress {
    if (!_displayable)
        return;
    
    if (!_hasMessage)
        [SVProgressHUD showInView:self.keyView];
    else
        [self showLoading];
}
- (void)showSuccessProgress {
    if (!_displayable)
        return;
    
    if (!_hasMessage)
        [SVProgressHUD dismiss];
    else
        [self showSuccess];
}
- (void)showErrorProgress {
    if (!_displayable)
        return;
    
    if (!_hasMessage)
        [SVProgressHUD dismiss];
    else
        [self showError];
}

@end
