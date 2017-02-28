//
//  JackHelp.m
//  JackHttpKitDemo
//
//  Created by Jack_zz on 2017/2/28.
//  Copyright © 2017年 jack_zz. All rights reserved.
//

#import "JackHelp.h"
#import "Jastor.h"

@implementation JackHelp

+ (id)jsonToObj:(NSString *)json WithClassName:(Class)className {
    if (IS_NSSTRING_EMPTY(json)) {
        return nil;
    }
    NSData *respData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableLeaves error:&error];
    id entity = nil;
    @try {
        entity = [[className alloc] initWithDictionary:rootDic];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    @finally {
        
    }
    return entity;
}

+ (id)jsonToObj:(NSString *)json{
    if (IS_NSSTRING_EMPTY(json)) {
        return nil;
    }
    NSData *respData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableLeaves error:&error];
    return rootDic;
}

+ (id)objToJson:(id)obj {
    NSString *ret = nil;
    if (nil == obj) {
        return ret;
    }
    if (![obj isKindOfClass:[NSString class]] && ![obj isKindOfClass:[NSNumber class]]) {
        NSError *error = nil;
        if ([obj isKindOfClass:[Jastor class]]) {
            NSDictionary *dic = [obj toDictionary];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
            obj = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        } else {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
            obj = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    ret = [NSString stringWithFormat:@"%@", obj];
    return ret;
}




@end

