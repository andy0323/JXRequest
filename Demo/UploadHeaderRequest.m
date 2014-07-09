//
//  UploadHeaderRequest.m
//  JXRequestDemo
//
//  Created by andy on 14-7-9.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "UploadHeaderRequest.h"

@implementation UploadHeaderRequest

- (id)init {
    
    if (self = [super init]) {
        //  self.url = @"https://IP/emm_backend/TokenServlet";
    }
    
    return self;
}

- (void)start {
    
    self.url = [NSString stringWithFormat:@"%@?tokenId=%@&userId=%@",self.url, self.tokenId, self.userId];
    
    UIImage *image = [UIImage imageNamed:@"headView.png"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    [self startPostRequest:self.url params:nil FormData:^(id<AFMultipartFormData> formData) {
         [formData appendPartWithFileData :data
                                      name:@"img"
                                  fileName:@"img.png"
                                  mimeType:@"image/jpeg"];
    }];
}

- (id)parseResponse:(id)result {
    return result;
}

- (void)setTokenId:(NSString *)tokenId {
    OVERTHROW_SETTING(tokenId);
}
- (void)setUserId:(NSString *)userId {
    OVERTHROW_SETTING(userId);
}

@end
