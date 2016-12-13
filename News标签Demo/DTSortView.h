//
//  SortView.h
//  News标签Demo
//
//  Created by tianXin on 2016/12/7.
//
//

#import <UIKit/UIKit.h>

@interface DTSortView : UIView

@property(nonatomic,strong,nullable)NSArray *selectedTitleArray;
@property(nonatomic,strong,nullable)NSArray *unselectedTitleArray;

@end

@interface DTSortButton : UIButton

@property (nonatomic ,assign) BOOL isDown;

@end
