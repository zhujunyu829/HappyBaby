
//
//  AddFoodCtr.m
//  HappyBaby
//
//  Created by feng on 2018/12/27.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import "AddFoodCtr.h"

@interface AddFoodCtr ()
{
    UITextField *_name;
}
@end

@implementation AddFoodCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加食材";
    [self configView];
    [self confiRightBtn];
    // Do any additional setup after loading the view.
}

#pragma mark - configView

- (void)configView{
    self.view.backgroundColor = [UIColor whiteColor];
    _name = [UITextField new];
    [self.view addSubview:_name];
    _name.textColor = [UIColor blackColor];
    _name.font = ZJYSYFont(15);
    _name.layer.masksToBounds = YES;
    _name.layer.borderWidth = 0.5f;
    _name.layer.borderColor = [UIColor grayColor].CGColor;
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.6);
        make.centerX.offset(0);
        make.top.offset(140);
        make.height.mas_equalTo(50);
    }];
    
}

- (void)confiRightBtn{
    UIBarButtonItem *btn = [self getBarButtonItemName:@"保存" addTarget:self sel:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = btn;
}

#pragma mark - action
- (void)saveAction:(id)sender{
    FoodObj *food = [FoodObj new];
    food.name = _name.text?:@"";
    if ([[DbManger sharManger] insertFood:food]) {
        [self.navigationController popViewControllerAnimated:YES];
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
