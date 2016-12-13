//
//  SortViewController.m
//  News标签Demo
//
//  Created by tianXin on 16/12/1.
//
//

#import "DTSortViewController.h"
#import "Constant.h"
#import "DTSortView.h"

@interface DTSortViewController ()

@end

@implementation DTSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DTSortView *sortView = [[DTSortView alloc] initWithFrame:CGRectMake(0, 74, ScreenWidth, ScreenHeight)];
    NSArray *unselectedArray = @[@"政治",@"国外",@"军事"];
    sortView.selectedTitleArray = self.titleArray;
    sortView.unselectedTitleArray = unselectedArray;
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
