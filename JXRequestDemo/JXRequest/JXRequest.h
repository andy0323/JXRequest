/**
 *
 *  @title:  继承此类, 用于独立封装请求
 *
 *  @author: andy
 *
 *  @time:   2014.07.01
 *
 */

#import <Foundation/Foundation.h>
#import "CommonRequest.h"
#import "JXAppDelegate.h"
#import "SVProgressHUD.h"

typedef void (^ResultBlock)(id result);

@interface JXRequest : NSObject {
    // 下载中的标示符
    BOOL _isLoading;
}

// 请求的链接
@property (nonatomic, copy) NSString *url;
// 请求参数
@property (nonatomic, strong) NSMutableDictionary *params;
// 数据回调
@property (nonatomic, copy) ResultBlock resultBlock;


#pragma mark -
#pragma mark - SVProgressHUD设置参数

// 开始请求 --- 提示内容
@property (nonatomic, copy) NSString *loadingMessage;
// 请求成功 --- 提示内容
@property (nonatomic, copy) NSString *successMessage;
// 请求失败 --- 提示内容
@property (nonatomic, copy) NSString *errorMessage;


// 是否显示progress
@property (nonatomic, assign) BOOL displayable;
// 是否显示状态内容
@property (nonatomic, assign) BOOL hasMessage;
// SVProgressHUD 显示的View上 (默认为UIWindow)
@property (nonatomic, strong) UIView *keyView;


#pragma mark -
#pragma mark - 继承对象调用函数

/**
 *  请求结束 && 状态吗验证成功 (回调函数)
 *
 *  @param block 回调Block
 */
- (void)resultBlock:(void (^)(id result))block;

/**
 *  开始请求数据
 */
- (void)start;


#pragma mark -
#pragma mark - 继承类内部调用

/**
 *  检测数据状态码是否正确
 *
 *  @param result 获取的数据源
 *
 *  @return YES表示正确 / NO表示不正确
 */
- (BOOL)checkResponse:(id)result;

/**
 *  状态码验证失败, 重写调用该函数
 */
- (void)statusError;

/**
 *  解析回调
 *
 *  @param result 对数据源进行解析
 *
 *  @return 将解析好的内容回调回去
 */
- (id)parseResponse:(id)result;

/**
 *  子类调用 -- 用于重写start
 *
 *  @param url    请求链接
 *  @param params 请求参数
 */
- (void)startGetRequest:(NSString *)url params:(NSDictionary *)params;
- (void)startPostRequest:(NSString *)url params:(NSDictionary *)params;
- (void)startUploadImage:(UIImage *)image url:(NSString *)url params:(NSDictionary *)params;

/**
 *  如果需要修改progressHUD的状态, 如offsetY 那么就在子类重写下面的函数
 */
- (void)showLoading;
- (void)showSuccess;
- (void)showError;

@end
