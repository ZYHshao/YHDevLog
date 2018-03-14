//
//  TKDevLogTableViewCell.m
//  TKDevelopTools
//
//  Created by jaki on 2018/3/6.
//  Copyright © 2018年 jaki. All rights reserved.
//

#import "YHDevLogTableViewCell.h"
#import "YHDevLogManager.h"

@interface YHDevLogTableViewCell()

@property(nonatomic,strong)UILabel * tLabel;

@property(nonatomic,strong)UILongPressGestureRecognizer *press;

@property(nonatomic,strong)NSArray * constraintArray;

@end

@implementation YHDevLogTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self installUI];
    }
    return self;
}

-(void)installUI{
    [self.contentView addSubview:self.tLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   
    [self.contentView addConstraints:self.constraintArray];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self addGestureRecognizer:self.press];
}

-(void)updateWith:(YHDevLogModel *)data{
    self.tLabel.text = data.content;
    CGSize size = [self getTextSize:data.content];
    if (size.height<16) {
        size.height = 16;
    }else{
        size.height++;
    }
    if (data.isOpen) {
        self.tLabel.numberOfLines = 0;
        NSLayoutConstraint * h = self.constraintArray.lastObject;
        h.constant = size.height;
    }else{
        self.tLabel.numberOfLines = 1;
        NSLayoutConstraint * h = self.constraintArray.lastObject;
        h.constant = 16;
    }
    switch (data.type) {
        case 0:
        {
            self.tLabel.textColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
        }
            break;
        case 1:
        {
            self.tLabel.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.7];
        }
            break;
        case 2:
        {
            self.tLabel.textColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.7];
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView layoutIfNeeded];
    }];
   
}

-(void)longPress:(UILongPressGestureRecognizer *)ges{
    if (ges.state==UIGestureRecognizerStateEnded) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.tLabel.text;
        [UIView animateWithDuration:0.3 animations:^{
            [YHDevLogManager shared].logView.tipLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.5 animations:^{
                [YHDevLogManager shared].logView.tipLabel.alpha = 0;
            }];
        }];
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)getHeight:(YHDevLogModel *)data{
    if (data.isOpen) {
        CGSize size = [[self new] getTextSize:data.content];
        if (size.height<16) {
            size.height = 16;
        }else{
            size.height++;
        }
        return size.height+4;
       
    }else{
        return 20;
    }
    
}

-(UILabel *)tLabel{
    if (!_tLabel) {
        _tLabel = [[UILabel alloc]init];
        _tLabel.numberOfLines = 1;
        _tLabel.font = [UIFont systemFontOfSize:11];
        _tLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tLabel;
}

-(CGSize)getTextSize:(NSString *)text{
    return  [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-70,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.tLabel.font} context:nil].size;
}

-(UILongPressGestureRecognizer *)press{
    if (!_press) {
        _press =  [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    }
    return _press;
}

-(NSArray *)constraintArray{
    if (!_constraintArray) {
        NSLayoutConstraint * l = [NSLayoutConstraint constraintWithItem:self.tLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
        NSLayoutConstraint * r = [NSLayoutConstraint constraintWithItem:self.tLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-20];
        NSLayoutConstraint * cY = [NSLayoutConstraint constraintWithItem:self.tLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint * cX = [NSLayoutConstraint constraintWithItem:self.tLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint * h = [NSLayoutConstraint constraintWithItem:self.tLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:16];
        _constraintArray =@[l,r,cY,cX,h];
    }
    return _constraintArray;
}

@end
