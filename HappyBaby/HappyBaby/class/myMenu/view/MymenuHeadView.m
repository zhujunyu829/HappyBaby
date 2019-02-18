//
//  MymenuHeadView.m
//  HappyBaby
//
//  Created by feng on 2019/1/7.
//  Copyright © 2019 zhujunyu. All rights reserved.
//

#import "MymenuHeadView.h"
#import "MyMenuObj.h"
@interface MymenuHeadView ()
{
    UILabel *_nameLable;
    UIButton *_addBtn;
}
@end

@implementation MymenuHeadView

- (instancetype)init{
    self  = [super initWithFrame:CGRectMake(0, 0, ZJYDeviceWidth, kMymenuHeadHeight)];
    if (self) {
        _nameLable = [UILabel new];
        [self addSubview:_nameLable];
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_addBtn];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setMenyObj:(MyMenuObj *)menyObj{
    _menyObj = menyObj;
    
}

@end
