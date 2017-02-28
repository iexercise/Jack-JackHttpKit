//
//  JackPageInfoEntity.h
//  JackHttpKitDemo
//
//  Created by Jack_zz on 2017/2/28.
//  Copyright © 2017年 jack_zz. All rights reserved.
//

#import "Jastor.h"

@interface JackPageInfoEntity : Jastor
@property (nonatomic, strong) NSNumber *pageno;
//每次请求的条数
@property (nonatomic, strong) NSNumber *pagesize;
//总条数
@property (nonatomic, strong) NSNumber *totalcount;
@end
