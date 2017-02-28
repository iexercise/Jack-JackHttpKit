//
//  JackAbstractRequest.m
//  JackHttpKitDemo
//
//  Created by Jack_zz on 2017/2/28.
//  Copyright © 2017年 jack_zz. All rights reserved.
//

#import "JackAbstractRequest.h"

@implementation JackAbstractRequest
-(id)initWithModelClass:(Class)className completeRequestBlock:(CompleteRequestBlock)block
{
    self = [super init];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"Version code"];
    self.version = app_Version;
    
    self.source = @"F";
    self.sign = @"";
    self.secret = @"";
    self.model = className;
    if (block) {
        _completeRequestBlock = nil;
        _completeRequestBlock = block;
    }
    return self;
}

-(id)initByMjWithcompleteRequestBlock:(CompleteRequestBlock)block
{
    self = [super init];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"Version code"];
    self.version = app_Version;
    
    self.useMJ = YES;
    self.source = @"F";
    self.sign = @"";
    self.secret = @"";
    if (block) {
        _completeRequestBlock = nil;
        _completeRequestBlock = block;
    }
    return self;
}

-(NSDictionary* )genRequestParagram
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.oper) {
        [dic setObject:self.oper forKey:@"oper"];
    }
    if (self.type) {
        [dic setObject:self.type forKey:@"type"];
    }
    if (self.sign) {
        [dic setObject:self.sign forKey:@"sign"];
    }
    if (self.secret) {
        [dic setObject:self.secret forKey:@"secret"];
    }
    if (self.source) {
        [dic setObject:self.source forKey:@"source"];
    }
    if (self.version) {
        [dic setObject:self.version forKey:@"version"];
    }
    
    return dic;
}

-(NSDictionary* )genRequestParagram_exten
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.oper) {
        [dic setObject:self.oper forKey:@"oper"];
    }
    if (self.type) {
        [dic setObject:self.type forKey:@"type"];
    }
    if (self.sign) {
        [dic setObject:self.sign forKey:@"sign"];
    }
    if (self.secret) {
        [dic setObject:self.secret forKey:@"secret"];
    }
    if (self.source) {
        [dic setObject:self.source forKey:@"source"];
    }
    if (self.version) {
        [dic setObject:self.version forKey:@"version"];
    }
    
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    paraDic = [self createDictionayFromModelProperties];
    
    [resultDic setObject:[JackHelp objToJson:paraDic] forKey:@"para"];
    
    return resultDic;
}


-(NSString *)genRequestUrl
{
    return nil;
}
-(NSString *)genRequestMethod
{
    return @"POST";
}

-(NSString*) getVerName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    //    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleInfoDictionaryVersion"];
    // app build版本
    //    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    //    app_Version = @"6";
    return app_Version;
}
- (NSDictionary *)genRequestHeader
{
    NSMutableDictionary* ret = [[NSMutableDictionary alloc] init];
    return ret;
}



-(void)analyseSuccessResponse:(id)response
{
    if ([response isKindOfClass:[NSDictionary class]]) {
        id result = [JackHelp jsonToObj:[response objectForKey:@"result"]];
        NSLog(@"response:%@",result);
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (self.model) {
                JackAbstractModel *baseModel = [[self.model alloc] initWithDictionary:result];
                if ([baseModel.code integerValue]!=200) {
                    NSError *error = [[NSError alloc] init];
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,error);
                    }
                }else{
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,nil);
                    }
                }
            }
        }
    }
}

-(void)analyseSuccessResponse_exten:(id)response
{
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSDictionary * result = [JackHelp jsonToObj:[response objectForKey:@"result"]];
        NSLog(@"response:%@",result);
        id data = [result objectForKey:@"data"];
        if (data == nil) {
            JackAbstractModel *baseModel = [[self.model alloc] init];
            NSString *code = [result objectForKey:@"code"];
            baseModel.code =code;
            NSString *msg = [result objectForKey:@"msg"];
            baseModel.msg = msg;
            if ([baseModel.code integerValue]!=200) {
                
                NSError *error = [[NSError alloc] init];
                if (_completeRequestBlock) {
                    _completeRequestBlock(baseModel,baseModel.msg,error);
                }
            }else{
                if (_completeRequestBlock) {
                    _completeRequestBlock(baseModel,baseModel.msg,nil);
                }
            }
            return;
            
        }
        if ([data isKindOfClass:[NSDictionary class]])
        {
            
            if (self.model) {
                JackAbstractModel *baseModel = [[self.model alloc] initWithDictionary:data];
                NSString *code = [result objectForKey:@"code"];
                baseModel.code =code;
                NSString *msg = [result objectForKey:@"msg"];
                baseModel.msg = msg;
                id pageInfo = [result objectForKey:@"pagination"];
                if (pageInfo && [pageInfo isKindOfClass:[NSDictionary class]]) {
                    JackPageInfoEntity *page = [[JackPageInfoEntity alloc] initWithDictionary:pageInfo];
                    baseModel.pagination = page;
                }
                
                if ([baseModel.code integerValue]!=200) {
                    
                    NSError *error = [[NSError alloc] init];
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,error);
                    }
                }else{
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,nil);
                    }
                }
            }
        }else if ([data isKindOfClass:[NSArray class]]){
            if (self.model) {
                JackAbstractModel *baseModel = [[self.model alloc] initWithDictionary:result];
                if ([baseModel.code integerValue]!=200) {
                    
                    NSError *error = [[NSError alloc] init];
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,error);
                    }
                }else{
                    if (_completeRequestBlock) {
                        _completeRequestBlock(baseModel,baseModel.msg,nil);
                    }
                }
                
            }
        }
    }
}




-(void)analyseFailtureResponse:(id)response
{
    NSError *error = response;
    //    NSString *errorMessage = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
    if (_completeRequestBlock) {
        _completeRequestBlock(nil,@"网络异常",error);
    }
}

- (NSMutableDictionary *)createDictionayFromModelProperties
{
    NSMutableDictionary *propsDic = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    // class:获取哪个类的成员属性列表
    // count:成员属性总数
    // 拷贝属性列表
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        // 属性名
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        // 属性值
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        // 设置KeyValues
        if (propertyValue) [propsDic setObject:propertyValue forKey:propertyName];
    }
    // 需手动释放 不受ARC约束
    free(properties);
    return propsDic;
}

@end
