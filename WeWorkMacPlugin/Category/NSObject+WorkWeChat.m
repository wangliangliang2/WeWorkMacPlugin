//
//  NSObject+WorkWeChat.m
//  WeWorkMacPlugin
//
//  Created by Anonymous on 17/05/2018.
//  Copyright © 2018 Anonymous. All rights reserved.
//

#import "NSObject+WorkWeChat.h"
#import "fishhook.h"
#import "WLLTools.h"
#import "BigBang.h"
static NSString * const kFilePath = @"%@/Library/Containers/com.tencent.WeWorkMac/Data";

@implementation NSObject (WorkWeChat)
+(void)hookWorkWeChat{
    //      替换沙盒路径
    rebind_symbols((struct rebinding[2]) {
        { "NSSearchPathForDirectoriesInDomains", swizzled_NSSearchPathForDirectoriesInDomains, (void *)&original_NSSearchPathForDirectoriesInDomains },
        { "NSHomeDirectory", swizzled_NSHomeDirectory, (void *)&original_NSHomeDirectory }
    }, 2);
//    [self redirectNSlogToDocumentFolder];
    wll_hookMethod(objc_getClass("WEWMessageScrollView"), @selector(setShowWaterMark:), [self class], @selector(hook_setShowWaterMark:));
    wll_hookMethod(objc_getClass("WEWApplicationLifeCricleObserver"), @selector(applicationDidFinishLaunching), [self class], @selector(hook_applicationDidFinishLaunching));
    
    //消息防撤回

    wll_hookMethod(objc_getClass("WEWMessage"), @selector(setIsRevoke:), [self class], @selector(hook_setIsRevoke:));
    wll_hookMethod(objc_getClass("WEWMessage"), @selector(setIsRevokeByAck:), [self class], @selector(hook_setIsRevokeByAck:));
    wll_hookMethod(objc_getClass("WEWMessage"), @selector(setIsRevokeInReceiptMode:), [self class], @selector(hook_setIsRevokeInReceiptMode:));


}

- (void)hook_setIsRevoke:(BOOL)arg{
    [self hook_setIsRevoke:NO];

}
- (void)hook_setIsRevokeByAck:(BOOL)arg{
    [self hook_setIsRevokeByAck:NO];
}
- (void)hook_setIsRevokeInReceiptMode:(BOOL)arg{
    [self hook_setIsRevokeInReceiptMode:NO];
}



- (void)hook_wew_handleMessageDidRevokeNotification:(id)arg1{
    
}

- (void)hook_revokeMessageByAck:(unsigned long long)arg1 callback:(id)arg2{
    
}

- (void)hook_RemoveRevokeMessagesByAck:(id)arg1{

}

+ (void)redirectNSlogToDocumentFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"work_WeChat+Hook.log"];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

- (void)hook_applicationDidFinishLaunching{
    
}

- (void)hook_setShowWaterMark:(id)arg1{
}




#pragma mark - 替换 NSSearchPathForDirectoriesInDomains & NSHomeDirectory
static NSArray<NSString *> *(*original_NSSearchPathForDirectoriesInDomains)(NSSearchPathDirectory directory, NSSearchPathDomainMask domainMask, BOOL expandTilde);

NSArray<NSString *> *swizzled_NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory, NSSearchPathDomainMask domainMask, BOOL expandTilde) {
    NSMutableArray<NSString *> *paths = [original_NSSearchPathForDirectoriesInDomains(directory, domainMask, expandTilde) mutableCopy];
    NSString *sandBoxPath = [NSString stringWithFormat:kFilePath,original_NSHomeDirectory()];
    
    [paths enumerateObjectsUsingBlock:^(NSString *filePath, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [filePath rangeOfString:original_NSHomeDirectory()];
        if (range.length > 0) {
            NSMutableString *newFilePath = [filePath mutableCopy];
            [newFilePath replaceCharactersInRange:range withString:sandBoxPath];
            paths[idx] = newFilePath;
        }
    }];
    
    return paths;
}

static NSString *(*original_NSHomeDirectory)(void);

NSString *swizzled_NSHomeDirectory(void) {
    return [NSString stringWithFormat:kFilePath,original_NSHomeDirectory()];
}
@end
