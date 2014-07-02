#import "NQCommonRequest.h"
#import "SVProgressHUD.h"

@implementation NQCommonRequest

#pragma mark -
#pragma mark - Show Methods

+ (instancetype)sharedClient {
    static NQCommonRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[NQCommonRequest alloc] init];
        
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
    
    return [[NQCommonRequest sharedClient] GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
            {
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
    return [[NQCommonRequest sharedClient] POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        if (block)
            block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (block)
            block([NSArray array], error);
        
    }];
}

/**
 *  上传图片
 */
+ (AFHTTPRequestOperation *)uploadImage:(UIImage *)image url:(NSString *)url params:(NSDictionary *)params WithBlock:(void (^)(id result, NSError *error))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
    // 上传图片
    return [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData :imageData
                                     name:@"test"
                                 fileName:@"test.png"
                                 mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if (block)
            block(json, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        if (block)
            block([NSArray array], error);
    }];
}

@end
