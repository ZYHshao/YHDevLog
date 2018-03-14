//
//  YHDevLogView.h
//  YHDevelopTools
//
//  Created by jaki on 2018/3/1.
//  Copyright © 2018年 jaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHDevLogView : UIView

@property(nonatomic,strong)UILabel * tipLabel;
-(void)logWithType:(int)type msg:(NSString *)msg;
@property(nonatomic,strong)UIWindow * window;
@end
