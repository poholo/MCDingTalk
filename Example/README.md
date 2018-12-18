# 用法
1. Info.plist配置查询钉钉授权登录scheme权限。LSApplicationQueriesSchemes中添加dingtalk, dingtalk-open, dingtalk-sso。dingtalk用于查询是否安装钉钉。dingtalk-open用于查询是否支持开放平台接口调用（不需要查询开放平台接口可不填）。dingtalk-sso用于查询是否支持授权登录。注：iOS系统限制LSApplicationQueriesSchemes最多只能有50个，超出的话会有一部分不生效。
如图:
![undefined](https://cdn.yuque.com/lark/0/2018/png/757/1526955990014-083e71ec-aa07-417e-956d-4b6d71d0b5e7.png) 
2. Info.plist的URL Types中增加appId，用于钉钉App返回回调。
![undefined](https://cdn.yuque.com/lark/0/2018/png/757/1526956148184-f3fa7d2d-7e9a-4a73-8a7e-0e5e856b7b28.png) 

3. app启动时注册appId。示例代码:

```objc
// 在app启动时注册appId
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 注册AppId;
    [DTOpenAPI registerApp:#该应用的appId#];
    return YES;
}
```

3. 发起授权登录。示例代码:

```objc
DTAuthorizeReq *authReq = [DTAuthorizeReq new];
authReq.bundleId = #该应用的bundleId#;
```

4. 处理回调。示例代码:

```objc
// 在app delegate链接处理回调中调用钉钉回调链接处理方法
- (BOOL)application:(UIApplication *)application
            openURL:(nonnull NSURL *)url
  sourceApplication:(nullable NSString *)sourceApplication
         annotation:(nonnull id)annotation
{
    if ([DTOpenAPI handleOpenURL:url delegate:self]) {
        return YES;
    }
 
    return NO;
}
```

```objc
// delegate实现回调处理方法 onResp:
- (void)onResp:(DTBaseResp *)resp
{
  //授权登录回调参数为DTAuthorizeResp，accessCode为授权码
    if ([resp isKindOfClass:[DTAuthorizeResp class]]) {
        DTAuthorizeResp *authResp = (DTAuthorizeResp *)resp;
        NSString *accessCode = authResp.accessCode;
		// 将授权码交给服务端做SSO
    }
}
```