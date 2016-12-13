//
//  HomeViewController.m
//  News标签Demo
//
//  Created by tianXin on 16/12/1.
//
//

#import "DTHomeViewController.h"
#import "DTChildViewController.h"
#import "DTSelectHeaderView.h"
#import "Constant.h"
#import "DTSortViewController.h"

@interface DTHomeViewController () {
    NSArray *_titleArray;
}
@property (nonatomic , strong) UIButton *slectListButton;

@end

@implementation DTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    [self loadViews];
}

#pragma mark --
#pragma mark -- <loadViews>
- (void)initializeData {
    _titleArray = @[@"美食",@"旅游",@"电影",@"招聘",@"娱乐",@"肯德基",@"网吧",@"逛街",@"探险",@"流浪",@"LOL",@"图书馆"];
}
- (void)loadViews {
    DTSelectHeaderView *headerView = [DTSelectHeaderView new];
    [self.view addSubview:headerView];
    for (int i = 0 ; i < _titleArray.count; i ++) {
        DTChildViewController *childVC = [[DTChildViewController alloc] init];
        [headerView addChildViewController:childVC title:[_titleArray objectAtIndex:i]];
    }
    [headerView setSelectHeaderView];
    [self createNextBtn];
}

-(void)createNextBtn{
    self.slectListButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.slectListButton.frame = CGRectMake( ScreenWidth-32, 64+12, 20, 20);
    [self.slectListButton setBackgroundImage:[UIImage imageNamed:@"selectBtn"] forState:UIControlStateNormal];
    [self.slectListButton addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.slectListButton];
}

-(void)addBtn:(id)sender{
    DTSortViewController *sortVC = [[DTSortViewController alloc] init];
    sortVC.title = @"标签选择";
    sortVC.titleArray = _titleArray;
    [self.navigationController pushViewController:sortVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
