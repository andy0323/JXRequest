//
//  NQCommonRequest.h
//  NQAppCenter
//
//  Created by Guo Mingliang on 14-5-7.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface NQCommonRequest : AFHTTPRequestOperationManager

/**
 *  获取单例对象
 *
 *  @return 返回单例
 */
+ (instancetype)sharedClient;

/**
 *	@brief	网络请求方法 (Get)
 *
 *	@param 	url 	请求的url地址
 *	@param 	parameters 	包含有请求参数的字典
 *
 *	@return result
 */
+ (AFHTTPRequestOperation *)getRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters WithBlock:(void (^)(id result, NSError *error))block;

/**
 *  @brief 网络请求方法 (Post)
 *
 *  @param url        请求的url地址
 *  @param parameters 包含有请求参数的字典
 *
 *  @return result
 */
+ (AFHTTPRequestOperation *)postRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters WithBlock:(void (^)(id result, NSError *error))block;

/**
 *  @brief 上传图片
 *
 *  @param image 要上传的图片
 *  @param url   请求的链接
 *
 *  @return result
 */
+ (AFHTTPRequestOperation *)uploadImage:(UIImage *)image url:(NSString *)url params:(NSDictionary *)params WithBlock:(void (^)(id result, NSError *error))block;

@end
