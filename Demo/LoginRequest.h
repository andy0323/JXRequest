#import "RootRequest.h"

@interface LoginRequest : RootRequest

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *userId;

@end
