# JXRequest

JXRequest是一个简单封装的类, 它引用了AFNetworking, SVProgress, 可以通过几个参数来控制SVProgressHUD的状态(显示/不显示/自定义文字).


## 如何使用JXRequest (详情参考Demo)


### 1. 准备工作

* 创建一个工程, 将src引入项目, 将lib引入项目
* 进入Build Phases --> Compile Sources 配置混编环境

### 2. 配置基类BaseRequest

首先, 创建一个继承于JXRequest的基类BaseRequest, 然后在BaseRequest内重写init, 配置Loading时的相关信息

|         参数         |           参数内容         |
| ---------------------| -------------------------|
| self.displayable			| 请求过程中是否显示SVProgress|
| self.hasMessage 			| 请求过程中是否显示文字内容  |
| self.loadingMessage	| 请求过程中 -- 提示信息      |
| self.successMessage 	| 完成请求时 -- 提示信息      |
| self.errorMessage		| 请求失败后 -- 提示信息      |

然后, 重写 @selector(checkResponse:) 

例如:

```
- (BOOL)checkResponse:(id)result {
    
    if (![result isKindOfClass:[NSDictionary class]])
    return NO;
     
    NSString *status = [result objectForKey:@"status"];
    
    if (![status isEqualToString:@"OK"])
        return NO;
     
    return YES;
}
```

然后重写 @selector(statusError);

```
- (void)statusError {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"其他用户登入" delegate:nil cancelButtonTitle:@"修改密码" otherButtonTitles:@"重新登入", nil];
    [alertView show];
}
```

### 2. 创建请求

创建继承于BaseRequest的请求类, 必须实现函数@selector(start)

如果某些参数固定不变, 写在在@selector(start)

例如:

```
- (void)start {
    [self.params setObject:@"false" forKey:@"sensor"];

    [self startGetRequest:self.url params:self.params];
}
```

参数正常的传入方法是写set函数

```
@property (nonatomic, copy) NSString *address;
```

重写set函数, 这样外部就可以用点语法设置参数

```
- (void)setAddress:(NSString *)address {
    self.address = address;
    [self.params setObject:address forKeyedSubscript:@"address"];
}
```

**子类内部重写注意**

1. 如果需要独立的提示内容, 重写init
2. 如果验证码错误回调有其他内容, 可以重写statusError

### 3 完成以后可以使用, 使用方法如下

```
- (void)weatherRequest {
	
	JXWeatherRequest *weatherRequest =[[JXWeatherRequest alloc] init];
    
    weatherRequest.address = @"金融街";
    
    [weatherRequest resultBlock:^(id result) {
       
        NSLog(@"%@", result);
    
    }];
    
    [weatherRequest start];
}

```
在Block中处理回调内容, result为数据源.


## Contact
**Email:** andy_ios@163.com


##Licenses

All source code is licensed under the [MIT License](https://github.com/andy0323/JXRequest/blob/master/LICENSE).

