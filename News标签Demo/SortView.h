//
//  SortView.h
//  News标签Demo
//
//  Created by tianXin on 16/12/1.
//
//

#import <UIKit/UIKit.h>
//屏幕相关
#define  SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@interface SortView : UIView

-(void)firstTitleBtns:(NSArray *)arr;//创建已选Buttons

-(void)secondTitleBtns:(NSArray *)arr;

@property (nonatomic , strong) NSMutableArray *newtitleArr; //已选中的

@property (nonatomic , strong) UIImageView *lineImageView ;


@end

@interface MyButton : UIButton

@property (nonatomic , assign) BOOL isDown;

@end
