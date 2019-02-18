//
//  MenuCtr.m
//  HappyBaby
//
//  Created by feng on 2019/2/18.
//  Copyright © 2019 zhujunyu. All rights reserved.
//

#import "MenuCtr.h"
#import "FoodCtr.h"
@interface MenuCtr ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_table;
    NSMutableArray *_dataArr;
}

@end

@implementation MenuCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜单";
    [self configTable];
    [self confiRightBtn];
    [self getData];
    // Do any additional setup after loading the view.
}
#pragma mark- configView
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
- (void)confiRightBtn{
    UIBarButtonItem *btn = [self getBarButtonItemName:@"食材" addTarget:self sel:@selector(foodAction:)];
    self.navigationItem.rightBarButtonItem = btn;
}
#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MenuObj *obj = [_dataArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = obj.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - action
- (void)foodAction:(id)sender{
    FoodCtr *ctr = [FoodCtr new];
    [self.navigationController pushViewController:ctr animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - requst
- (void)getData{
    [_dataArr removeAllObjects];
    [_dataArr addObjectsFromArray:[[DbManger sharManger] getAllMenu]];
    [_table reloadData];
    
}
@end
