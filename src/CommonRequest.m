#import "CommonRequest.h"
#import "SVProgressHUD.h"

@implementation CommonRequest

#pragma mark -
#pragma mark - 共有函数

/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedClient {
    static CommonRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[CommonRequest alloc] init];
        
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        _sharedClient.securityPolicy.allowInvalidCertificates =YES;

        NSOperationQueue *operationQueue = _sharedClient.operationQueue;
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
    });
    return _sharedClient;
}

/**
 *  网络请求 --- get
 */
+ (AFHTTPRequestOperation *)getRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters WithBlock:(void (^)(id, NSError *))block {
    
    return [[CommonRequest sharedClient] GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (block)
                    block(responseObject, nil);
                
            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                if (block)
                    block([NSArray array], error);
                
            }];
}

/**
 *  网络请求 --- post
 */
+ (AFHTTPRequestOperation *)postRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters WithBlock:(void (^)(id result, NSError *error))block {
    return [[CommonRequest sharedClient] POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        if (block)
            block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (block)
            block([NSArray array], error);
        
    }];
}

/**
 *  上传文件
 */
+ (AFHTTPRequestOperation *)postRequestUrl:(NSString *)url params:(NSDictionary *)params FormData:(void (^)(id<AFMultipartFormData> formData))formBlock WithBlock:(void (^)(id result, NSError *error))block {
    
    return [[CommonRequest sharedClient] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        formBlock(formData);
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (block)
            block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        if (block)
            block([NSArray array], error);
    }];
}

@end
