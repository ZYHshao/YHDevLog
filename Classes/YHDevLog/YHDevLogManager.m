//
//  TKDevManager.m
//  TKDevelopTools
//
//  Created by jaki on 2018/3/1.
//  Copyright © 2018年 jaki. All rights reserved.
//

#import "YHDevLogManager.h"



@interface YHDevLogManager()



@end

@implementation YHDevLogManager



+(YHDevLogManager *)shared{
    static YHDevLogManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[YHDevLogManager alloc]init];
        }
    });
    return manager;

}

+(void)installDevLogView{
    if ([self shared].logView) {
        return;
    }
    [self shared].logView = [[YHDevLogView alloc]init];
    
    [self shared].logView.frame = [self shared].logView.window.bounds;
    [[self shared].logView.window makeKeyAndVisible];
}

+(void)pushLog:(int)type format:(NSString *)format,...{
    va_list list;
    va_start(list, format);
    NSString * string = [[NSString alloc]initWithFormat:format arguments:list];
    va_end(list);
    [[self shared].logView logWithType:type msg:string];
}

@end
