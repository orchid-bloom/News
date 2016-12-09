//
//  SortView.m
//  News标签Demo
//
//  Created by tianXin on 2016/12/7.
//
//

#import "SortView.h"

#define distance 20 //标签间的距离
#define numOfRow 4 //每行的按钮数量
#define buttonWidth (ScreenWidth - distance * (numOfRow+1)) / numOfRow
#define buttonHeight 20
#define sectionHeight 20

@implementation SortView {
    CGPoint         _recognizerPoint;
    NSMutableArray *_secondSectionArray;//存放未选中的
    NSMutableArray *_buttonArray;//存放所有Btn 避免后面拖动判断时判断到其他控件
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _secondSectionArray = [NSMutableArray array];
        _buttonArray        = [NSMutableArray array];
        _selectedArray      = [NSMutableArray array];
    }
    return self;
}

#pragma mark --
#pragma mark -- <loadViews>
- (void)selectedTitleButton:(NSArray *)selectedTitleArray {
    for (id objc in selectedTitleArray) {
        [self.selectedArray addObject:objc];
    }
    for (int i = 0; i < selectedTitleArray.count; i++) {
        CGFloat btnX = distance + (buttonWidth + distance) * (i % numOfRow);
        CGFloat btnY = (buttonHeight + distance) * (i / numOfRow);
        SortButton *btn = [SortButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, buttonWidth, buttonHeight);
        btn.backgroundColor = [UIColor whiteColor];
        [btn.layer setBorderWidth:0.3]; //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.5 });
        [btn.layer setBorderColor:colorref];//边框颜色
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        btn.tag = i+1;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        [btn setTitle:selectedTitleArray[i] forState:UIControlStateNormal];
        //事件
        [btn addTarget:self action:@selector(touchButtonn:) forControlEvents:UIControlEventTouchUpInside];
        //添加手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        
        [btn addGestureRecognizer:longPress];
        [_buttonArray addObject:btn];
        [self addSubview:btn];
    }
}
- (void)unselectedTitleButton:(NSArray *)unselectedTitleArray {
    for(id obj in unselectedTitleArray) {
        [_secondSectionArray addObject: obj];
    }
    for (int i = 0; i < unselectedTitleArray.count; i++) {
        SortButton *btn = [SortButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        [btn.layer setBorderWidth:0.3]; //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.5 });
        [btn.layer setBorderColor:colorref];//边框颜色
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        btn.tag = i+100;
        btn.isDown = YES;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        [btn setTitle:unselectedTitleArray[i] forState:UIControlStateNormal];
        //事件
        [btn addTarget:self action:@selector(touchButtonn:) forControlEvents:UIControlEventTouchUpInside];
        //添加手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [btn addGestureRecognizer:longPress];
        [_buttonArray addObject:btn];
        [self addSubview:btn];
        [self nextSection];
    }
}
- (void)touchButtonn:(UIButton *)button {
    
}
- (void)longPress:(UILongPressGestureRecognizer *)gesture {
    
}

- (void)nextSection {
    NSInteger row = 0;

}

@end

@implementation SortButton


@end
