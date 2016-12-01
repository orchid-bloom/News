//
//  Constant.h
//  News标签Demo
//
//  Created by tianXin on 16/12/1.
//
//

#ifndef Constant_h
#define Constant_h


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGB2Color(r, g, b)  [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define RandomColor RGB2Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))/** 随机色  */

#endif /* Constant_h */
