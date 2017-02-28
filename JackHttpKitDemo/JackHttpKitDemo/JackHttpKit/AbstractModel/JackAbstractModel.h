//
//  JackAbstractModel.h
//  JackHttpKitDemo
//
//  Created by Jack_zz on 2017/2/28.
//  Copyright © 2017年 jack_zz. All rights reserved.
//

#import "Jastor.h"
#import "JackPageInfoEntity.h"

@interface JackAbstractModel : Jastor
//返回码 200为成功
@property (nonatomic, strong) NSString *code;
//返回消息，用于界面提示
@property (nonatomic, strong) NSString *msg;
//分页信息
@property (nonatomic, strong) JackPageInfoEntity *pagination;
@end
