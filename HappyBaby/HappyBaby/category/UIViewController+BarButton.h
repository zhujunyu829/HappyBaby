//
//  UIViewController+BarButton.h
//  HappyBaby
//
//  Created by feng on 2019/2/18.
//  Copyright © 2019 zhujunyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BarButton)
- (UIBarButtonItem *)getBarButtonItemName:(NSString *)title addTarget:(id)target sel:(SEL)action;
@end

NS_ASSUME_NONNULL_END
