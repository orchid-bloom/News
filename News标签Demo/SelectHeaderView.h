//
//  SelectHeaderView.h
//  News标签Demo
//
//  Created by tianXin on 16/12/1.
//
//

#import <UIKit/UIKit.h>

@interface SelectHeaderView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView    *titleScrollView;       //标题ScrollView
@property(nonatomic,strong)UIScrollView    *contentViewScrollView; //控制器ScrollView
@property(nonatomic,strong)NSArray         *titleArray;                 //标题Array
@property(nonatomic,strong)NSMutableArray  *buttonArray;           //buttonArray
@property(nonatomic,strong)UIButton        *selectButton;          //选择button
@property(nonatomic,strong)UIImageView     *backgroundImageView;

- (void)addChildViewController:(UIViewController *)ViewController title:(NSString *)title ;
- (void)setSelectHeaderView;

@end
