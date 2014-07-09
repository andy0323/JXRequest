#import "LoginRequest.h"

@implementation LoginRequest

- (id)init {
    
    if (self = [super init]) {
        
//        self.url = @"https://IP/emm_backend/TokenServlet";
        
    }
    
    return self;
}

- (void)start {
    [self.params setObject:@"login" forKey:@"type"];
    
    [self startGetRequest:self.url params:self.params];
}

- (void)statusError {
    NSLog(@"用户名密码错误");
}

- (id)parseResponse:(id)result {
    
    NSLog(@"%@", result);

    return result;
}

- (void)setUsername:(NSString *)username {
    _username = username;
    [self.params setObject:username forKey:@"userName"];
}

- (void)setPassword:(NSString *)password {
    _password = password;
    [self.params setObject:password forKey:@"password"];
}



@end
