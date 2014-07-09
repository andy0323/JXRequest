//
//  UploadHeaderRequest.h
//  JXRequestDemo
//
//  Created by andy on 14-7-9.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "RootRequest.h"

#define CREATE_PROPERTY(name) @property (nonatomic, copy) NSString* name;

#define OVERTHROW_SETTING(name) \
    _##name = name;\
    if (name)\
        [self.params setObject:name forKey:@"name"];\


/**
 
 
 - (void)setTokenId:(NSString *)tokenId {
    _tokenId = tokenId;
    [self.params setObject:tokenId forKey:@"tokenId"];
 }
 
 */
@interface UploadHeaderRequest : RootRequest
//
//@property (nonatomic, copy) NSString *token;
//@property (nonatomic, copy) NSString *userId;

CREATE_PROPERTY(tokenId);
CREATE_PROPERTY(userId);

@end
