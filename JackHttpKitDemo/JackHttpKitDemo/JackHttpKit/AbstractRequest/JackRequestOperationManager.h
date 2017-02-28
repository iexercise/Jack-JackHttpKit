//
//  JackRequestOperationManager.h
//  JackHttpKitDemo
//
//  Created by Jack_zz on 2017/2/28.
//  Copyright © 2017年 jack_zz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JackAbstractRequest.h"

@interface JackRequestOperationManager : NSObject
-(void)performWithRequest:(JackAbstractRequest *)request View:(UIView *)view;
-(void)performWithRequest_exten:(JackAbstractRequest *)request View:(UIView *)view;
@end
