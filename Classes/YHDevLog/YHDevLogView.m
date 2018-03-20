//
//  YHDevLogView.m
//  YHDevelopTools
//
//  Created by jaki on 2018/3/1.
//  Copyright © 2018年 jaki. All rights reserved.
//

#import "YHDevLogView.h"
#import "YHDevLogTableViewCell.h"
#define YHDevLogTableViewCellID @"YHDevLogTableViewCell"


#define YHDevIphoneX_Area_Height (([UIScreen mainScreen].bounds.size.height==812)?[[UIApplication sharedApplication] statusBarFrame].size.height:0)
@interface YHDevLogView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray<YHDevLogModel *> * dataArray;

@property(nonatomic,strong)UIButton * openButton;

@property(nonatomic,strong)UIButton * miniButton;

@property(nonatomic,strong)UIButton * typeButton;

@property(nonatomic,strong)UIButton * clearButton;

//0 warn 1 error 2 plain 3 all
@property(nonatomic,assign)int type;

@property(nonatomic,strong)NSMutableArray * tempArray;

@end

@implementation YHDevLogView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self installUI];
    }
    return self;
}

-(void)installUI{
     self.type = 3;
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.windowLevel = UIWindowLevelAlert+100;
    self.window.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20+YHDevIphoneX_Area_Height);
    UIViewController * controller = [UIViewController new];
    controller.view=self;
    self.window.rootViewController =controller;
    controller.automaticallyAdjustsScrollViewInsets = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:self.openButton];
    [self layoutOpenButton];
    [self addSubview:self.miniButton];
    [self layoutMiniButton];
    [self addSubview:self.typeButton];
    [self layoutTypeButton];
    [self addSubview:self.clearButton];
    [self layoutClearButton];
    [self addSubview:self.tipLabel];
    [self layoutTipLabel];
    [self addSubview:self.tableView];
    NSLayoutConstraint * l = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    NSLayoutConstraint * r = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint * t = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:YHDevIphoneX_Area_Height];
    NSLayoutConstraint * b = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];

    [self addConstraints:@[l,r,t,b]];
}

-(void)layoutOpenButton{
    NSLayoutConstraint * l = [NSLayoutConstraint constraintWithItem:self.openButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:3];
    NSLayoutConstraint * w = [NSLayoutConstraint constraintWithItem:self.openButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:27];
    NSLayoutConstraint * t = [NSLayoutConstraint constraintWithItem:self.openButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:YHDevIphoneX_Area_Height+3];
    NSLayoutConstraint * h = [NSLayoutConstraint constraintWithItem:self.openButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:14];
    [self addConstraints:@[l,w,t,h]];
}

-(void)layoutMiniButton{
    NSLayoutConstraint * l = [NSLayoutConstraint constraintWithItem:self.miniButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:3];
    NSLayoutConstraint * w = [NSLayoutConstraint constraintWithItem:self.miniButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:27];
    NSLayoutConstraint * t = [NSLayoutConstraint constraintWithItem:self.miniButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.openButton attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint * h = [NSLayoutConstraint constraintWithItem:self.miniButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:14];
    
    [self addConstraints:@[l,w,t,h]];
}

-(void)layoutTypeButton{
    NSLayoutConstraint * l = [NSLayoutConstraint constraintWithItem:self.typeButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:3];
    NSLayoutConstraint * w = [NSLayoutConstraint constraintWithItem:self.typeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:27];
    NSLayoutConstraint * t = [NSLayoutConstraint constraintWithItem:self.typeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.miniButton attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint * h = [NSLayoutConstraint constraintWithItem:self.typeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:14];
    
    [self addConstraints:@[l,w,t,h]];
}

-(void)layoutClearButton{
    NSLayoutConstraint * l = [NSLayoutConstraint constraintWithItem:self.clearButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:3];
    NSLayoutConstraint * w = [NSLayoutConstraint constraintWithItem:self.clearButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:27];
    NSLayoutConstraint * t = [NSLayoutConstraint constraintWithItem:self.clearButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.typeButton attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint * h = [NSLayoutConstraint constraintWithItem:self.clearButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:14];
    
    [self addConstraints:@[l,w,t,h]];
}

-(void)layoutTipLabel{
    NSLayoutConstraint * l = [NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:3];
    NSLayoutConstraint * w = [NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:27];
    NSLayoutConstraint * t = [NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.clearButton attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    NSLayoutConstraint * h = [NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    [self addConstraints:@[l,w,t,h]];
}

-(void)logWithType:(int)type msg:(NSString *)msg{
    YHDevLogModel * model = [[YHDevLogModel alloc]init];
    model.isOpen = NO;
    model.content = msg;
    model.type = type;
    [self.dataArray insertObject:model atIndex:0];
    if (self.type==type||self.type==3) {
        [self.tempArray insertObject:model atIndex:0];
    }
    [self.tableView reloadData];
    switch (type) {
        case 0:
        {
            NSLog(@"warn:%@",msg);
        }
            break;
        case 1:
        {
             NSLog(@"error:%@",msg);
        }
            break;
        case 2:
        {
             NSLog(@"%@",msg);
        }
            break;
        default:
            break;
    }
}

#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YHDevLogTableViewCell getHeight:self.tempArray[indexPath.row]];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHDevLogTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YHDevLogTableViewCellID forIndexPath:indexPath];
    [cell updateWith:self.tempArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHDevLogModel * model = self.tempArray[indexPath.row];
    model.isOpen = !model.isOpen;
    [tableView beginUpdates];
    [(YHDevLogTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] updateWith:model];
    [tableView endUpdates];  
}

-(void)openWindow{
    self.openButton.selected = !self.openButton.isSelected;
    if (self.openButton.isSelected) {
        CGRect frame = self.window.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height;
        self.window.frame = frame;
    }else{
        CGRect frame = self.window.frame;
        frame.size.height = 20+YHDevIphoneX_Area_Height;
        self.window.frame = frame;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)miniWindow{
    self.miniButton.selected = !self.miniButton.isSelected;
    if (!self.miniButton.isSelected) {
        CGRect frame = self.window.frame;
        frame.size.width = [UIScreen mainScreen].bounds.size.width;
        self.window.frame = frame;
    }else{
        CGRect frame = self.window.frame;
        frame.size.width = 40;
        self.window.frame = frame;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)clearButtonClick{
    [self.dataArray removeObjectsInArray:self.tempArray];
    [self.tempArray removeAllObjects];
    [self.tableView reloadData];
}

-(void)typeButtonClick{
    [self.tempArray removeAllObjects];
    switch (self.type) {
        case 0:
        {
            self.type++;
            [self.typeButton setTitle:@"错误" forState:UIControlStateNormal];
             [self.typeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            self.type++;
            [self.typeButton setTitle:@"正常" forState:UIControlStateNormal];
            [self.typeButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.type++;
            [self.typeButton setTitle:@"全部" forState:UIControlStateNormal];
             [self.typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            self.type = 0;
            [self.typeButton setTitle:@"警告" forState:UIControlStateNormal];
             [self.typeButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    if (self.type==3) {
        [self.tempArray addObjectsFromArray:self.dataArray];
    }else{
        for (int i = 0; i<self.dataArray.count; i++) {
            if([(YHDevLogModel *)self.dataArray[i] type]==self.type){
                [self.tempArray addObject:self.dataArray[i]];
            }
        }
    }
    [self.tableView reloadData];
}
#pragma mark - Setter and Getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:NSClassFromString(YHDevLogTableViewCellID) forCellReuseIdentifier:YHDevLogTableViewCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UIButton *)openButton{
    if (!_openButton) {
        _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openButton setTitle:@"展开" forState:UIControlStateNormal];
          [_openButton setTitle:@"关闭" forState:UIControlStateSelected];
        _openButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_openButton addTarget:self action:@selector(openWindow) forControlEvents:UIControlEventTouchUpInside];
        _openButton.translatesAutoresizingMaskIntoConstraints = NO;
      
    }
    return _openButton;
}

-(UIButton *)miniButton{
    if (!_miniButton) {
        _miniButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_miniButton setTitle:@"收起" forState:UIControlStateNormal];
        [_miniButton setTitle:@"打开" forState:UIControlStateSelected];
        _miniButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_miniButton addTarget:self action:@selector(miniWindow) forControlEvents:UIControlEventTouchUpInside];
        _miniButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _miniButton;
}

-(UIButton *)typeButton{
    if (!_typeButton) {
        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton setTitle:@"全部" forState:UIControlStateNormal];
        [_typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_typeButton addTarget:self action:@selector(typeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _typeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _typeButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _typeButton;
}


-(UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setTitle:@"清除" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _clearButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _clearButton.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _clearButton;
}

-(NSMutableArray *)tempArray{
    if (!_tempArray) {
        _tempArray = [NSMutableArray array];
    }
    return _tempArray;
}

-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = [UIColor orangeColor];
        _tipLabel.text = @"复制成功";
        _tipLabel.numberOfLines = 2;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.alpha = 0;
        _tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tipLabel;
}

@end
