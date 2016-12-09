//
//  SortView.h
//  News标签Demo
//
//  Created by tianXin on 2016/12/7.
//
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface SortView : UIView

@property(nonatomic,strong)NSMutableArray *selectedArray;  //选中
@property(nonatomic,strong)UIImageView *lineImageView;

- (void)selectedTitleButton:(NSArray *)selectedTitleArray;
- (void)unselectedTitleButton:(NSArray *)unselectedTitleArray;

@end

@interface SortButton : UIButton
@property (nonatomic ,assign) BOOL isDown;

@end
