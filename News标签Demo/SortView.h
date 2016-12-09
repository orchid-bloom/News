//
//  SortView.h
//  News标签Demo
//
//  Created by tianXin on 2016/12/7.
//
//

#import <UIKit/UIKit.h>

@interface SortView : UIView

@property(nonatomic,strong,nullable)NSArray *selectedTitleArray;
@property(nonatomic,strong,nullable)NSArray *unselectedTitleArray;

@end

@interface SortButton : UIButton

@property (nonatomic ,assign) BOOL isDown;

@end
