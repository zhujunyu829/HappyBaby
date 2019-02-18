//
//  UIViewController+BarButton.m
//  HappyBaby
//
//  Created by feng on 2019/2/18.
//  Copyright © 2019 zhujunyu. All rights reserved.
//

#import "UIViewController+BarButton.h"

@implementation UIViewController (BarButton)

- (UIBarButtonItem *)getBarButtonItemName:(NSString *)title addTarget:(id)target sel:(SEL)action{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setTitle:title?:@"" forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    barButton.titleLabel.font = ZJYSYFont(18);
    barButton.backgroundColor = [UIColor clearColor];
    barButton.width = 40;
    barButton.height = 44;
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    return barItem;
}
@end
