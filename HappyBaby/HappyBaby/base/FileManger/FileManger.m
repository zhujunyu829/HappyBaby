//
//  FileManger.m
//  HappyBaby
//
//  Created by feng on 2018/12/26.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import "FileManger.h"

@implementation FileManger

+ (NSString *)getPath:(NSString *)pathName atDirectior:(WRFileManagerPathType)pathType
{
    return [self getPath:pathName atDirectior:pathType noBackUp:NO];
}
+ (NSString *)getPath:(NSString *)pathName atDirectior:(WRFileManagerPathType)pathType noBackUp:(BOOL)noBackUp{
    if (!pathName) {
        return nil;
    }
    NSString *path ;
    switch (pathType) {
        case WRDocumentsPath:
        {
            path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            
        }break;
        case WRLibraryPath:{
            path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        }break;
        case WRAppSupportPath:{
            path = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject;
            
        }break;
        case WRCachesPath:{
            path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
            path = [path stringByAppendingPathComponent:@"Caches"];
        }break;
        case WRTmpPath:{
            path = NSTemporaryDirectory() ;
        }break;
        default:
            break;
    }
    path = [path stringByAppendingPathComponent:pathName];
    if (noBackUp && ![[NSFileManager defaultManager] fileExistsAtPath:path]) {//设置不备份未YES 且文件不存在时才设置
        [self  fileExcludedFromBackup:path];
    }
    return path;
}
+ (void)fileExcludedFromBackup:(NSString *)path{
    if (!path) {
        return;
    }
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    assert([[NSFileManager defaultManager] fileExistsAtPath: path]);
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:path];
    BOOL success = [url setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey
                                   error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [url lastPathComponent], error);
    }
}
@end
