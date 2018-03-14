//
//  TKDevLogTableViewCell.h
//  TKDevelopTools
//
//  Created by jaki on 2018/3/6.
//  Copyright © 2018年 jaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHDevLogModel.h"

@interface YHDevLogTableViewCell : UITableViewCell

-(void)updateWith:(YHDevLogModel *)data;

+(CGFloat)getHeight:(YHDevLogModel *)data;


@end
