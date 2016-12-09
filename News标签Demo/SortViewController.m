//
//  SortViewController.m
//  News标签Demo
//
//  Created by tianXin on 16/12/1.
//
//

#import "SortViewController.h"
#import "FXJSortView.h"
#import "Constant.h"
#import "SortView.h"

@interface SortViewController ()

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    FXJSortView *sortView = [[FXJSortView alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, ScreenHeight)];
//    NSArray *weixuanzhongArr = @[@"对三",@"呵呵",@"要不起"];
//    
//    [sortView firstTitleBtns:self.titleArray];
//    [sortView secondTitleBtns:weixuanzhongArr];
//    [self.view addSubview:sortView];
    SortView *sortView = [[SortView alloc] initWithFrame:CGRectMake(0, 74, ScreenWidth, ScreenHeight)];
    NSArray *unselectedArray = @[@"政治",@"国外",@"军事"];
    [sortView selectedTitleButton:self.titleArray];
    [sortView unselectedTitleButton:unselectedArray];
    [self.view addSubview:sortView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
