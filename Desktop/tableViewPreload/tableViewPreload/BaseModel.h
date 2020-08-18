//
//  BaseModel.h
//  tableViewPreload
//
//  Created by 饶鸿平 on 2020/8/16.
//  Copyright © 2020 饶鸿平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject <NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSString *errorMsg;  // 错误提示
@property (nonatomic, assign) NSInteger errorCode;  // 错误码
@property (nonatomic, assign) NSInteger result;  // 请求结果

@end

NS_ASSUME_NONNULL_END
