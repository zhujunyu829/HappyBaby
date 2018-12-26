//
//  MenuMainCtr.m
//  BaseProj
//
//  Created by feng on 2018/12/25.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import "MenuMainCtr.h"

@interface MenuMainCtr ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_table;
    NSMutableArray *_dataArr;
}
@end

@implementation MenuMainCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"本周菜单";
    [self configTable];
    // Do any additional setup after loading the view.
}

#pragma mark- configView
- (void)configTable{
    _dataArr = [NSMutableArray new];
    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - buttonAction

#pragma mark - requst

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
