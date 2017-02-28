//
//  JackRequestOperationManager.m
//  JackHttpKitDemo
//
//  Created by Jack_zz on 2017/2/28.
//  Copyright © 2017年 jack_zz. All rights reserved.
//

#import "JackRequestOperationManager.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@implementation JackRequestOperationManager
- (NSString *)apiBaseURL{
    return @"https://www.baidu.com";
}
#define WLWAPISERVER  ([NetworkUtils getServerURL])

-(void)fillRequestHeaderForManager:(AFHTTPSessionManager *)manager ofRequest: (JackAbstractRequest *)request
{
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}

-(void)performWithRequest_exten:(JackAbstractRequest *)request View:(UIView *)view
{
    if (view !=nil) {
        
        MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
        if (hud == nil) {
            MBProgressHUD *hud = [[MBProgressHUD alloc] init];
            [view addSubview:hud];
            hud.labelText = @"正在努力加载...";
            [hud show:YES];
            hud.tag = -10000;
        }
    }
    NSLog(@"%@",request.genRequestParagram);
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",
                                                          @"text/json",
                                                          @"text/javascript",
                                                          @"text/html", nil];
    [self fillRequestHeaderForManager:manager ofRequest:request];
    // list all needed data
    NSString *httpMthod = request.genRequestMethod;
    if ([httpMthod isEqualToString:@"POST"]) {
        if ([request.oper isEqualToString:@"getwxpaystr"]) {
            [manager POST:@"http://wl.qpwa.com/handle/execute.jhtml" parameters:request.genRequestParagram_exten progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask *operation, id responseObject) {
                MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
                if (hud) {
                    [hud hide:YES];
                    [hud removeFromSuperview];
                }
                [request analyseSuccessResponse_exten:responseObject];
                
            }failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
                MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
                if (hud) {
                    [hud hide:YES];
                    [hud removeFromSuperview];
                }
                [request analyseFailtureResponse:error];
            }];
            
            return;
        }
        [manager POST:self.apiBaseURL parameters:request.genRequestParagram_exten progress:^(NSProgress * _Nonnull uploadProgress) {
            
        }  success:^(NSURLSessionDataTask *operation, id responseObject) {
            MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
            if (hud) {
                [hud hide:YES];
                [hud removeFromSuperview];
            }
            [request analyseSuccessResponse_exten:responseObject];
            
        }failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
            MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
            if (hud) {
                [hud hide:YES];
                [hud removeFromSuperview];
            }
            [request analyseFailtureResponse:error];
        }];
    }
    if ([httpMthod isEqualToString:@"GET"]) {
        [manager GET:self.apiBaseURL parameters:request.genRequestParagram progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }  success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
            MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
            if (hud) {
                [hud hide:YES];
                [hud removeFromSuperview];
            }
            
            [request analyseSuccessResponse_exten:responseObject];
        } failure:^(NSURLSessionDataTask * _Nonnull operation, NSError * _Nonnull error) {
            MBProgressHUD *hud =(MBProgressHUD *) [view viewWithTag:-10000];
            if (hud) {
                [hud hide:YES];
                [hud removeFromSuperview];
            }
            [request analyseFailtureResponse:error];
        }];
    }
    
}
@end
