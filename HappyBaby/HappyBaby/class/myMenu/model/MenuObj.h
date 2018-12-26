//
//  MenuObj.h
//  HappyBaby
//
//  Created by feng on 2018/12/26.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuObj : NSObject

@property (nonatomic, assign) int objID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSMutableArray *foodArr;
@end

NS_ASSUME_NONNULL_END
