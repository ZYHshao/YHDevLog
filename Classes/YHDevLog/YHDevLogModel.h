//
//  TKDevLogModel.h
//  TKDevelopTools
//
//  Created by jaki on 2018/3/6.
//  Copyright © 2018年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDevLogModel : NSObject

@property(nonatomic,strong)NSString * content;


/**
 0 warn 1 error 2 plain
 */
@property(nonatomic,assign)int type;

@property(nonatomic,assign)BOOL isOpen;

@end
