//
//  MainCtr.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "MainCtr.h"
#import "MenuMainCtr.h"
#import "BadFoodCtr.h"
#import "GoodFoodCtr.h"

@interface MainCtr ()
{
    UITabBarController *_tab;
    UIView *_tabV;
    UIButton *_lastBtn;
}
@end

@implementation MainCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =ZJYColorHex(@"ffffff");
    self.navigationController.navigationBarHidden = YES;
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    tab.viewControllers =@[[self changeNav:[MenuMainCtr new]],[self changeNav:[GoodFoodCtr new]],[self changeNav:[BadFoodCtr new]]];
    tab.hidesBottomBarWhenPushed = YES;
    [self.view addSubview:tab.view];
    tab.selectedIndex = 1;
    _tab = tab;
    [self configBtn];
    // Do any additional setup after loading the view.
}
- (UIViewController *)changeNav:(UIViewController *)ctr{
    UINavigationController *nave = [[UINavigationController alloc] initWithRootViewController:ctr];
    nave.hidesBottomBarWhenPushed = YES;
    return nave;
}
- (void)configBtn{

    
    NSArray *titleArr = @[@"菜单",@"膳食",@"忌口"];
    NSArray *imgeArr = @[@"fenxitongji_",@"dindan_",@"wode_"];

    for (int i = 0 ; i < titleArr.count; i ++) {
        NSString *imgeName = [NSString stringWithFormat:@"%@1",imgeArr[i]];
        NSString *imgeNameSel = [NSString stringWithFormat:@"%@2",imgeArr[i]];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titleArr[i] image:[UIImage imageNamed:imgeName] selectedImage:[UIImage imageNamed:imgeNameSel]];
        UIViewController *ctr = _tab.viewControllers[i];
        ctr.tabBarItem = item;
        item.tag = i;
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
