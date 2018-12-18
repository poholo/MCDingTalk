//
//  AppDelegate.m
//  DTShareKitDemo
//
//  Created by 青山 on 15/12/23.
//  Copyright © 2015年 QingShan. All rights reserved.
//

#import "AppDelegate.h"
#import <DTShareKit/DTOpenKit.h>

@interface AppDelegate () <DTOpenAPIDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 注册AppId;
    [DTOpenAPI registerApp:@"dingoak5hqhuvmpfhpnjvt"];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(nonnull NSURL *)url
  sourceApplication:(nullable NSString *)sourceApplication
         annotation:(nonnull id)annotation {
    if ([DTOpenAPI handleOpenURL:url delegate:self]) {
        return YES;
    }
    return NO;
}

- (void)onReq:(DTBaseReq *)req {
    
}

- (void)onResp:(DTBaseResp *)resp {
    if ([resp isKindOfClass:[DTAuthorizeResp class]]) {
        DTAuthorizeResp *authResp = (DTAuthorizeResp *)resp;
        NSString *accessCode = authResp.accessCode;
        [self showAlertTitle:@"授权登录"
                     message:[NSString stringWithFormat:@"accessCode: %@, errorCode: %@, errorMsg: %@", accessCode, @(resp.errorCode), resp.errorMessage]];
    }
    else {
        [self showAlertTitle:[NSString stringWithFormat:@"ErrorCode: %@", @(resp.errorCode)]
                     message:[NSString stringWithFormat:@"ErrorMsg: %@", resp.errorMessage]];
    }
}

- (void)showAlertTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    
    [self.window.rootViewController presentViewController:alertVC
                                                 animated:YES
                                               completion:nil];
}

@end
