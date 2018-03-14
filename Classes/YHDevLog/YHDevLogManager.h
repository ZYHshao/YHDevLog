//
//  TKDevManager.h
//  TKDevelopTools
//
//  Created by jaki on 2018/3/1.
//  Copyright © 2018年 jaki. All rights reserved.
//

#ifndef YHDevLog
#define YHDevlOG



#ifdef DEBUG
#define START_DEBUG_MODE() [YHDevLogManager installDevLogView];
#define WARN_LOG(msg,...) [YHDevLogManager pushLog:0 format:msg,##__VA_ARGS__,nil];
#define ERROR_LOG(msg,...) [YHDevLogManager pushLog:1 format:msg,##__VA_ARGS__,nil];
#define LOG(msg,...) [YHDevLogManager pushLog:2 format:msg,##__VA_ARGS__,nil];
#else
#define START_DEBUG_MODE()
#define WARN_LOG(msg,...)
#define ERROR_LOG(msg,...)
#define LOG(msg,...)
#endif

#endif
#import <Foundation/Foundation.h>
#import "YHDevLogView.h"
@interface YHDevLogManager : NSObject

+(void)installDevLogView;

@property(nonatomic,strong)YHDevLogView * logView;

+(YHDevLogManager *)shared;

+(void)pushLog:(int)type format:(NSString *)format,...NS_REQUIRES_NIL_TERMINATION;

@end
