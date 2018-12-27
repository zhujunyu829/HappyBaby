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
    [self confiRightBtn];
    [self getData];
    // Do any additional setup after loading the view.
}

#pragma mark- configView
- (void)confiRightBtn{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(historyAction:)];
    self.navigationItem.rightBarButtonItem = btn;
}
- (void)configTable{
    _dataArr = [NSMutableArray new];
    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.tableFooterView = [UIView new];
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MyMenuObj *obj = [_dataArr objectAtIndex:section];
    return  obj.menuArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MyMenuObj *obj = [_dataArr objectAtIndex:indexPath.section];
    cell.textLabel.text = [obj.menuArr[indexPath.row] name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - buttonAction
- (void)historyAction:(id)sender{
}
#pragma mark - requst
- (void)getData{
    [_dataArr removeAllObjects];
    NSDate *date =  [[NSDate dateStartOfWeek] changeToDay];
    for (int i = 0 ; i < 7 ; i ++) {
        NSDate *dayTime = [date offsetDay:i];
        MyMenuObj *obj =  [[DbManger sharManger] getMyMenuDate:dayTime];
        [_dataArr addObject:obj];
    }
    [_table reloadData];
    
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
