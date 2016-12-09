//
//  SortView.m
//  News标签Demo
//
//  Created by tianXin on 2016/12/7.
//
//

#import "SortView.h"
#import "Constant.h"

#define distance 20 //标签间的距离
#define numOfRow 4 //每行的按钮数量
#define buttonWidth (ScreenWidth - distance * (numOfRow+1)) / numOfRow
#define buttonHeight 20
#define sectionHeight 20

@interface  SortView ()

@property(nonatomic,strong)NSMutableArray *selectedArray;  //选中
@property(nonatomic,strong)NSMutableArray *secondSectionArray;//存放未选中的
@property(nonatomic,strong)NSMutableArray *buttonArray;//存放所有Btn 避免后面拖动判断时判断到其他控件
@property(nonatomic,strong)UIImageView    *lineImageView;
@property(nonatomic,assign)CGPoint         recognizerPoint;

@end

@implementation SortView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _secondSectionArray = [NSMutableArray array];
        _buttonArray        = [NSMutableArray array];
        _selectedArray      = [NSMutableArray array];
        _recognizerPoint    = CGPointMake(0, 0);
    }
    return self;
}
#pragma mark --
#pragma mark -- <loadViews>
- (void)setSelectedTitleArray:(NSArray *)selectedTitleArray {
    _selectedTitleArray = selectedTitleArray;
    for (id objc in selectedTitleArray) {
        [self.selectedArray addObject:objc];
    }
    self.lineImageView = [[UIImageView alloc] init];
    self.lineImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.lineImageView];
    for (int i = 0; i < selectedTitleArray.count; i++) {
        CGFloat btnX = distance + (buttonWidth + distance) * (i % numOfRow);
        CGFloat btnY = (buttonHeight + distance) * (i / numOfRow) + distance/3;
        SortButton *btn = [SortButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, buttonWidth, buttonHeight);
        btn.backgroundColor = [UIColor whiteColor];
        [btn.layer setBorderWidth:0.3]; //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.5 });
        [btn.layer setBorderColor:colorref];//边框颜色
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5]; //设置矩形四个圆角半径
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
- (void)setUnselectedTitleArray:(NSArray *)unselectedTitleArray {
    _unselectedTitleArray = unselectedTitleArray;
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
        [btn.layer setCornerRadius:5]; //设置矩形四个圆角半径
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
        [self layoutSecondSection];
    }
}
- (void)layoutSecondSection {
    NSInteger row = 0;
    if (self.selectedArray.count % numOfRow == 0) {
        row = self.selectedArray.count / numOfRow;
    }else{
        row = self.selectedArray.count /numOfRow + 1;
    }
    CGFloat sectionLineHeight = row * (buttonHeight + distance);
    self.lineImageView.frame = CGRectMake(0, sectionLineHeight, ScreenWidth, 0.5);
    for (int i = 0; i< _secondSectionArray.count; i++) {
        SortButton *button = [self viewWithTag:i+100];
        //button现在的位置
        NSInteger nowWeiZhi=_secondSectionArray.count-i;
        CGFloat btnX = distance + (buttonWidth + distance) * ((nowWeiZhi-1) % numOfRow);
        CGFloat btnY = (buttonHeight + distance) * ((nowWeiZhi-1) / numOfRow);
        
        [UIView animateWithDuration:0.3 animations:^{
            button.frame = CGRectMake(btnX, sectionLineHeight+sectionHeight+btnY, buttonWidth, buttonHeight);
        }];
    }
}
- (void)touchButtonn:(SortButton *)sender {
    if (!sender.isDown) {
        [self.selectedArray removeObjectAtIndex:sender.tag-1];
        [self changeSelectedSection:sender.tag];
        sender.isDown = YES;
        sender.tag = _secondSectionArray.count+100;
        NSString *title = sender.titleLabel.text;
        [_secondSectionArray insertObject:title atIndex:0];
        [self layoutSecondSection];
    }else{
        NSInteger weiZhi=_secondSectionArray.count-sender.tag+100-1;
        NSString *str = [_secondSectionArray objectAtIndex:weiZhi];
        [_secondSectionArray removeObjectAtIndex:weiZhi];
        [self.selectedArray addObject:str];
        [self changeUnselectedSection:sender];
    }
}
- (void)changeSelectedSection:(NSInteger)changeTag {
    for (NSInteger i = changeTag; i<=self.selectedArray.count; i++) {
        SortButton *button = [self viewWithTag:i+1];
        button.tag = i;
        CGFloat btnX = distance + (buttonWidth + distance) * ((i-1) % numOfRow);
        CGFloat btnY = (buttonHeight + distance) * ((i-1) / numOfRow);
        [UIView animateWithDuration:0.3 animations:^{
            button.frame = CGRectMake(btnX, btnY, buttonWidth, buttonHeight);
        }];
    }
}
- (void)changeUnselectedSection:(SortButton *)sender {
    for (NSInteger i = sender.tag; i<_secondSectionArray.count+100; i++) {
        SortButton *button = [self viewWithTag:i+1];
        button.tag = i;
    }
    //修改上移按钮的位置
    sender.tag = self.selectedArray.count;
    sender.isDown = NO;
    CGFloat btnX = distance + (buttonWidth + distance) * ((sender.tag-1) % numOfRow);
    CGFloat btnY = (buttonHeight + distance) * ((sender.tag-1) / numOfRow);
    [UIView animateWithDuration:0.3 animations:^{
        sender.frame = CGRectMake(btnX, btnY, buttonWidth, buttonHeight);
    }];
    //修改后面btn的位置
    [self layoutSecondSection];
}
- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
    SortButton *recognizerView = (SortButton *)recognizer.view;
    if (recognizerView.isDown == NO) {
        // 触碰点
        _recognizerPoint = [recognizer locationInView:self];
        //begin
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            
            [UIView animateWithDuration:0.2 animations:^{
                recognizerView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                recognizerView.alpha = 0.7;
            }];
            [self bringSubviewToFront:recognizerView];
        }//change
        else if (recognizer.state == UIGestureRecognizerStateChanged){
            
            recognizerView.center = _recognizerPoint;
            for (SortButton *btn in _buttonArray) {
                if (CGRectContainsPoint(btn.frame, recognizerView.center)&& btn!= recognizerView && btn.isDown ==NO) {
                    
                    if (btn.tag > recognizerView.tag) {
                        //向后
                        long int to = btn.tag;
                        long int from = recognizerView.tag;
                        
                        NSString *str = [self.selectedArray objectAtIndex:from - 1];
                        [self.selectedArray removeObjectAtIndex:from - 1 ];
                        [self.selectedArray insertObject:str atIndex:to - 1 ];
                        
                        for (long int i = from; i<=to; i++) {
                            if (i==to) {
                                recognizerView.tag = to;
                            }else{
                                SortButton *onebtn = [self viewWithTag:i+1];
                                onebtn.tag = i;
                                CGFloat btnX = distance + (buttonWidth + distance) * ((i-1) % numOfRow);
                                CGFloat btnY = (buttonHeight + distance) * ((i-1) / numOfRow);
                                [UIView animateWithDuration:0.3 animations:^{
                                    onebtn.frame = CGRectMake(btnX, btnY, buttonWidth, buttonHeight);
                                    
                                }];
                            }
                        }
                    } else {
                        //向前
                        long int twoto = btn.tag;
                        long int twofrom = recognizerView.tag;
                        
                        NSString *str = [self.selectedArray objectAtIndex:twofrom - 1];
                        [self.selectedArray removeObjectAtIndex:twofrom - 1 ];
                        [self.selectedArray insertObject:str atIndex:twoto - 1 ];
                        
                        for ( NSInteger i = twofrom; i>= twoto; i--) {
                            if (i == twoto) {
                                recognizerView.tag = twoto;
                            }else{
                                SortButton *twobtn = [self viewWithTag:i-1];
                                twobtn.tag = i;
                                CGFloat btnX = distance + (buttonWidth + distance) * ((i-1) % numOfRow);
                                CGFloat btnY = (buttonHeight + distance) * ((i-1) / numOfRow);
                                [UIView animateWithDuration:0.3 animations:^{
                                    twobtn.frame = CGRectMake(btnX, btnY, buttonWidth, buttonHeight);
                                }];
                                
                            }
                        }
                    }
                }
            }
        } else if (recognizer.state == UIGestureRecognizerStateEnded){
            //长按结束
            [UIView animateWithDuration:0.2 animations:^{
                recognizerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                recognizerView.alpha = 1;
                CGFloat btnX = distance + (buttonWidth + distance) * ((recognizerView.tag - 1) % numOfRow);
                CGFloat btnY = (buttonHeight + distance) * ((recognizerView.tag -1) / numOfRow);
                [UIView animateWithDuration:0.3 animations:^{
                    recognizerView.frame = CGRectMake(btnX, btnY, buttonWidth, buttonHeight);
                }];
            }];
        }
    }
}
@end

@implementation SortButton


@end
