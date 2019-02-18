//
//  MymenuHeadView.h
//  HappyBaby
//
//  Created by feng on 2019/1/7.
//  Copyright © 2019 zhujunyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyMenuObj;

const float kMymenuHeadHeight = 50;
NS_ASSUME_NONNULL_BEGIN

@interface MymenuHeadView : UIView


@property (nonatomic, retain) MyMenuObj *menyObj;
@property (nonatomic, copy) void(^touchuMenyAction)(MyMenuObj *);
@end

NS_ASSUME_NONNULL_END
