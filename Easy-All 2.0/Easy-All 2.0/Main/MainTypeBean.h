//
//  MainTypeBean.h
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/28.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainToolBean.h"

@interface MainTypeBean : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSMutableArray<MainToolBean *> *mainToolBean;

@end
