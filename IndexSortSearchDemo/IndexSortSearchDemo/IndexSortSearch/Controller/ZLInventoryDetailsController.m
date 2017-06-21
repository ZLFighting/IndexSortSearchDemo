//
//  ZLInventoryDetailsController.m
//  IndexSortSearchDemo
//
//  Created by ZL on 2017/6/21.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ZLInventoryDetailsController.h"
#import "ZLInventoryDetailsCell.h"
#import "ZLGoodsModel.h"
#import "ZLChineseToPinyin.h"


@interface ZLInventoryDetailsController () <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *myTableView;

// 库存详情列表数组
@property (nonatomic, strong) NSMutableArray *inventoryList;

// 索引标题数组(排序后的出现过的拼音首字母数组)
@property(nonatomic, strong) NSMutableArray *indexArr;

// 排序好的结果数组
@property(nonatomic, strong) NSMutableArray *resultArr;


@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (weak, nonatomic) UISearchBar *searchBar;

// 保存搜索状态下的搜索数组
@property (strong, nonatomic) NSMutableArray *searchList;

// 用于判断是否显示搜索结果
@property (assign, nonatomic) BOOL showSearch;

@end

@implementation ZLInventoryDetailsController

#pragma mark - 懒加载

- (NSMutableArray *)inventoryList {
    if (!_inventoryList) {
        _inventoryList = [NSMutableArray array];
    }
    return _inventoryList;
}

- (NSMutableArray *)searchList {
    if (_searchList == nil) {
        _searchList = [NSMutableArray array];
    }
    return _searchList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZLBackgroundColor;
    self.navigationItem.title = @"库存详情";
    
    // 添加设置子视图
    [self setupSubView];
    
    // 添加myTableView相关
    [self setupMyTableView];
    
    // 模拟数据加载 inventoryList中得到model的数组
    [self loadInventoryData];
    
    // 根据ZLGoodsModel对象的 name 属性 按中文 对 ZLGoodsModel数组 排序
    self.indexArr = [ZLChineseToPinyin indexWithArray:self.inventoryList Key:@"name"];
    self.resultArr = [ZLChineseToPinyin sortObjectArray:self.inventoryList Key:@"name"];
}

#pragma mark - setupView视图相关

- (void)setupSubView {
    
    UIView *subView = [[UIView alloc] init];
    subView.frame = CGRectMake(0, UI_navBar_Height, UI_View_Width, 50);
    subView.backgroundColor = ZLBackgroundColor;
    [self.view addSubview:subView];
    
    // 搜索工具条
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, subView.width - 50, subView.height);
    searchBar.placeholder = @"输入名称进行搜索";
    searchBar.delegate = self;
    [subView addSubview:searchBar];
    self.searchBar = searchBar;
    
    // 扫码按钮
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(CGRectGetMaxX(self.searchBar.frame), 0, 50, subView.height);
    scanBtn.backgroundColor = ZLColor(201, 201, 201);
    [scanBtn setImage:[UIImage imageNamed:@"saoyisao1"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:scanBtn];
}

- (void)setupMyTableView {
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, UI_navBar_Height + 50, UI_View_Width, UI_View_Height - UI_navBar_Height - 50)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    self.myTableView.bounces = NO; // 取消弹簧效果
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置右侧索引字体颜色
    self.myTableView.sectionIndexColor = ZLColor(102, 102, 102);
    // 设置右侧索引背景色
    self.myTableView.sectionIndexBackgroundColor = [UIColor whiteColor];
}

#pragma mark - 扫码

- (void)scanCodeClick {
    
    NSLog(@"点击了扫码");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// 标签数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.showSearch) {
        return 1;
    }
    
    return self.indexArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.showSearch) {
        return self.searchList.count;
    }
    return [[self.resultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLInventoryDetailsCell *cell =[ZLInventoryDetailsCell cellWithTableView:tableView];
    
    if (self.showSearch) {
        if (self.searchList.count) {
            ZLGoodsModel *model = self.searchList[indexPath.row];
            cell.model = model;
        }
        return cell;
    }
    
    ZLGoodsModel *model = [[self.resultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return ZLInventoryDetailsCellHeight;
}

// 显示每组标题索引 (如果不实现 就不显示右侧索引)
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    
    if (self.showSearch) {
        return nil;
    }
    return self.indexArr;
}

// 设置索引section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.showSearch) {
        return 0.0;
    }
    return 20;
}

// 返回每个索引的内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (self.showSearch) {
        return @"";
    }
    
    return self.indexArr[section]; // [self.indexArray objectAtIndex:section]
}

// 响应点击索引时的委托方法(点击右侧索引表项时调用)
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    return index;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate -

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    }
    [self.myTableView addGestureRecognizer:_tap];
    
    return YES;
}

- (void)tapAction{
    [self.myTableView removeGestureRecognizer:_tap];
    [_searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
    
    // 模拟加载搜索数据
    [self loadSearchData];
    
    self.showSearch = YES;
    [self.myTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchBar.text isEqualToString:@""]) {
        
        self.showSearch = NO;
        
        [self.myTableView reloadData];
    } else {
        
        // 模拟加载搜索数据
        [self loadSearchData];
        
        self.showSearch = YES;
        [self.myTableView reloadData];
    }
    
}

#pragma mark - load

// 模拟加载库存数据
- (void)loadInventoryData {
    
    NSArray *inventoryArr = [NSArray arrayWithObjects:
                             @"冰淇淋",@"土豆",@"##",
                             @"排骨1",@"馒头1",@"小饼",
                             @"排骨2",@"馒头2",@"中饼",
                             @"排骨3",@"馒头3",@"大饼",
                             @"排骨",@"馒头",@"老婆饼",
                             nil];
    
    self.inventoryList = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [inventoryArr count]; i++) {
        ZLGoodsModel *good = [[ZLGoodsModel alloc] init];
        good.name = [inventoryArr objectAtIndex:i];
        good.num = i * 100;
        good.cost = i + 100;
        [self.inventoryList addObject:good];
    }
}

// 模拟加载搜索数据
- (void)loadSearchData {
    
    [self.searchList removeAllObjects];
    
    NSArray *searchArr = [NSArray arrayWithObjects:
                          @"冰淇淋",@"排骨",@"老婆饼",
                          nil];
    
    self.searchList = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [searchArr count]; i++) {
        ZLGoodsModel *search = [[ZLGoodsModel alloc] init];
        search.name = [searchArr objectAtIndex:i];
        search.num = i * 100;
        search.cost = i + 100;
        [self.searchList addObject:search];
    }
}


@end
