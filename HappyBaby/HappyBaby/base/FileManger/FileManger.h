//
//  FileManger.h
//  HappyBaby
//
//  Created by feng on 2018/12/26.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,WRFileManagerPathType) {
    WRDocumentsPath,//用户可见且会同步
    WRLibraryPath,//用户不可见且会同步（存在libarary目录下面）
    WRAppSupportPath,//用户不可见且会同步（存在libarary目录下面）
    WRCachesPath,//用户不可见不会同步 可能被工具清理 （存在libarary目录下面）
    WRTmpPath//用户不可见不会同步 且重启应用时会清除
};
@interface FileManger : NSObject


/**
 返回存储路径。
 
 @param pathName 文件名称
 @param pathPath 文件保存到的目的文件夹
 @return 返回存储路径
 */
+ (NSString *)getPath:(NSString *)pathName atDirectior:(WRFileManagerPathType)pathType;

/**
 返回存储路径。
 
 @param pathName 文件名称
 @param pathType 文件保存到的目的文件夹
 @param noBackUp 设置是否icloud
 @return 返回存储路径
 */
+ (NSString *)getPath:(NSString *)pathName atDirectior:(WRFileManagerPathType)pathType noBackUp:(BOOL)noBackUp;
@end

NS_ASSUME_NONNULL_END
