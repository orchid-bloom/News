//
//  SelectHeaderView.m
//  News标签Demo
//
//  Created by tianXin on 16/12/1.
//
//

#import "DTSelectHeaderView.h"
#import "Constant.h"

static CGFloat Height = 44.0f;
static CGFloat Scale  = 1.2f;

@implementation DTSelectHeaderView

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return  self;
}
#pragma mark --
#pragma mark -- <loadViews>
- (void)setSelectHeaderView {
    UIViewController *superVC = [self filterViewControllerWithView:self];
    CGRect frame = CGRectMake(0, 64, ScreenWidth - 40, Height);
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:frame];
    [superVC.view addSubview:self.titleScrollView];
    
    frame = CGRectMake(0, Height + 64, ScreenWidth, ScreenHeight - Height);
    self.contentViewScrollView = [[UIScrollView alloc] initWithFrame:frame];
    [superVC.view addSubview:self.contentViewScrollView];
    
    CGFloat W = 60;
    CGFloat H = Height;
    CGFloat x = 0;
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, W - 10, H - 10)];
    self.backgroundImageView.image = [UIImage imageNamed:@"backimageView"];
    self.backgroundImageView.backgroundColor = [UIColor whiteColor];
    self.backgroundImageView.userInteractionEnabled = YES;
    [self.titleScrollView addSubview:self.backgroundImageView];
   
    NSInteger count = superVC.childViewControllers.count;
    for (NSInteger i = 0 ; i < count; i ++) {
        UIViewController *childVC = [superVC.childViewControllers objectAtIndex:i];
        x = i * W;
        CGRect rect = CGRectMake(x, 0, W, H);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        [btn setTitle:childVC.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:btn];
        [self.titleScrollView addSubview:btn];
        if (i == 0) {
            [self buttonClick:btn];
        }
    }
    self.titleScrollView.contentSize = CGSizeMake(W*count, Height);
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    self.contentViewScrollView.contentSize = CGSizeMake(count *ScreenWidth, 0);
    self.contentViewScrollView.pagingEnabled = YES;
    self.contentViewScrollView.showsVerticalScrollIndicator = NO;
    self.contentViewScrollView.showsHorizontalScrollIndicator = NO;
    self.contentViewScrollView.delegate = self;
    self.contentViewScrollView.bounces = NO;
}

- (void)buttonClick:(UIButton *)button {
    [self selectButton:button];
    [self.contentViewScrollView setContentOffset:CGPointMake(button.tag *ScreenWidth, 0) animated:YES];
    [self setChildViewController:button.tag];
}

- (void)selectButton:(UIButton *)button {
    [self.selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.selectButton.transform = CGAffineTransformIdentity;
    
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.transform = CGAffineTransformMakeScale(Scale, Scale);
    [self.titleScrollView scrollRectToVisible:CGRectMake(button.frame.origin.x - 80, 0, ScreenWidth, Height) animated:YES];
}

- (void)setChildViewController:(NSInteger)index {
    UIViewController *superVC = [self filterViewControllerWithView:self];
    CGFloat x = index * ScreenWidth;
    UIViewController *childVC = [superVC.childViewControllers objectAtIndex:index];
    if (childVC.view.superview) {
        return;
    }
    childVC.view.frame = CGRectMake(x, 0, ScreenWidth, ScreenHeight - self.titleScrollView.frame.size.height);
    [self.contentViewScrollView addSubview:childVC.view];
}
#pragma mark --
#pragma mark -- <add childViewController>
- (UIViewController *)filterViewControllerWithView:(UIView *)sourceView {
    id target = sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}
- (void)addChildViewController:(UIViewController *)ViewController title:(NSString *)title {
    UIViewController *superVC = [self filterViewControllerWithView:self];
    ViewController.title = title;
    [superVC addChildViewController:ViewController];
}
#pragma mark --
#pragma mark -- <UIScrollView delegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = self.contentViewScrollView.contentOffset.x/ScreenWidth;
    [self selectButton:[self.buttonArray objectAtIndex:index]];
    [self setChildViewController:index];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger oldIndex = offsetX/ ScreenWidth;
    NSInteger newIndex = oldIndex + 1;
    
    UIButton *oldButton = [self.buttonArray objectAtIndex:oldIndex];
    UIButton *newButton = nil;
    if (newIndex < self.buttonArray.count) {
        newButton  = self.buttonArray[newIndex];
    }
    CGFloat scaleR  = offsetX / ScreenWidth - oldIndex;
    CGFloat scaleL  = 1 - scaleR;
    CGFloat transScale = Scale - 1;
    self.backgroundImageView.transform = CGAffineTransformMakeTranslation((offsetX*(self.titleScrollView.contentSize.width / self.contentViewScrollView.contentSize.width)), 0);
    oldButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    newButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    UIColor *newColor = [UIColor colorWithRed:(174+66*scaleR)/255.0 green:(174-71*scaleR)/255.0 blue:(174-174*scaleR)/255.0 alpha:1];
    UIColor *oldColor = [UIColor colorWithRed:(174+66*scaleL)/255.0 green:(174-71*scaleL)/255.0 blue:(174-174*scaleL)/255.0 alpha:1];
    
    [oldButton setTitleColor:oldColor forState:UIControlStateNormal];
    [newButton setTitleColor:newColor forState:UIControlStateNormal];
}

@end
