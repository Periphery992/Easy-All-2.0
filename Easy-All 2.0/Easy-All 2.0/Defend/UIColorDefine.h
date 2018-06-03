//
//  UIColorDefine.h
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#ifndef UIColorDefine_h
#define UIColorDefine_h

/**
 使用16进制RGB值和透明度便捷创建一个UIColor
 
 @param rgbValue 16进制的rgb值 如0x000000  (黑色)
 @param alp 透明度 0.0f-1.0f
 @return 返回一个UIColor对象
 */
#define UIColorFromRGB(rgbValue, alp)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                                                         green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
                                                          blue:((float)(rgbValue & 0xFF)) / 255.0 \
                                                         alpha:alp]

#endif /* UIColorDefine_h */
