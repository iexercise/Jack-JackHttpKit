//
//  JackAbstractRequest.h
//  JackHttpKitDemo
//
//  Created by Jack_zz on 2017/2/28.
//  Copyright © 2017年 jack_zz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JackPageInfoEntity.h"
#import "JackHelp.h"
#import "JackAbstractModel.h"
#import <objc/message.h>
@interface JackAbstractRequest : NSObject
typedef void(^CompleteRequestBlock)(id sender, NSString *msg, NSError *error);

//是否使用MJExtension
@property (nonatomic , assign)BOOL useMJ;

//操作类型
@property (nonatomic, strong) NSString *oper;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *version;

/**
 *  接口预留字段，封装在基类
 */
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *secret;
/**
 *  网页(W)、外勤360-android(O)、POS(P)、WAP(A)、B2CAPP-android(C) 、B2BAPP-android(B)、B2BAPP-IOS(F)、B2CAPP-IOS(G)、外勤360-IOS(H)、移动POS-android(I)
 */
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) JackPageInfoEntity *pagination;

/**
 *  用来接收控制层传入的对象模型
 */
@property (nonatomic, strong) Class model;
/**
 *  http／https请求回调
 */
@property (nonatomic, copy) CompleteRequestBlock completeRequestBlock;
/**
 *  http／https情趣参数
 *
 *  @return 1
 */
-(NSDictionary* )genRequestParagram;

-(NSDictionary* )genRequestParagram_exten;

-(NSString *)genRequestUrl;
/**
 *  http/https请求方法，PUT GET POST DELETE
 *
 *  @return 请求方法
 */
-(NSString *)genRequestMethod;
/**
 *  封装http请求头
 *
 *  @return 1
 */
-(NSDictionary *)genRequestHeader;
/**
 * 网络请求成功回调函数
 *
 *  @param response 后台返回的数据流或者解析出来的字典
 */
-(void)analyseSuccessResponse:(id)response;

-(void)analyseSuccessResponse_exten:(id)response;
/**
 *  网络异常回调函数
 *
 *  @param response 1
 */
-(void)analyseFailtureResponse:(id)response;
/**
 *  初始化一个request
 *
 *  @param className Model层的model
 *  @param block 1
 *
 *  @return 1
 */
-(id)initWithModelClass:(Class)className completeRequestBlock:(CompleteRequestBlock)block;
@end
