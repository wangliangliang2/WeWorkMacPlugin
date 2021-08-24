//
//  NSObject+WorkWeChat.m
//  WeWorkMacPlugin
//
//  Created by Anonymous on 17/05/2018.
//  Copyright © 2018 Anonymous. All rights reserved.
//

#import "NSObject+WorkWeChat.h"
#import "WeWorkMacPlugin.h"
#import "WLLTools.h"
@implementation NSObject (WorkWeChat)
+(void)hookWorkWeChat{
    //      替换沙盒路径
    [WLLTools switchSandboxPath];
    //校验
    wll_hookMethod(objc_getClass("NSBundle"), @selector(executablePath), [self class], @selector(hook_executablePath));

    //去除水印
    wll_hookMethod(objc_getClass("WEWCustomView"), @selector(showWaterMark), [self class], @selector(hook_showWaterMark));

    //多开
    wll_hookMethod(objc_getClass("__NSArrayI"), @selector(count), [self class], @selector(hook_count));
    // 禁止小窗口
    wll_hookMethod(objc_getClass("WEWConvListController"), @selector(p_onTableViewDoubleClick), [self class], @selector(hook_p_onTableViewDoubleClick));
    
    //多开控制栏目注册
    wll_hookMethod(objc_getClass("WEWApplicationLifeCricleObserver"), @selector(applicationDidFinishLaunching), [self class], @selector(hook_applicationDidFinishLaunching));
    
}

- (NSString *)hook_executablePath {
    NSString *executablePath = [self hook_executablePath];
    if ([executablePath hasSuffix:@"企业微信"]) {
        executablePath = [executablePath stringByAppendingString:@"_backup"];
    }
    return executablePath;
}

- (BOOL)hook_showWaterMark{
    return NO;
}

- (BOOL)hook_isRevoke{
    return NO;
}

- (void)hook_p_onTableViewDoubleClick{
}

- (void)hook_applicationDidFinishLaunching{
    [self hook_applicationDidFinishLaunching];
    [self addPlugin];
}

- (void)addPlugin{
    NSMenu *mainMenu = [NSApp mainMenu];
    NSMenuItem *oneItem = [[NSMenuItem alloc] initWithTitle:@"" action:nil keyEquivalent:@""];
        [mainMenu insertItem:oneItem atIndex:2];
    NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@"Plugin"];
        [oneItem setSubmenu:subMenu];
    [subMenu addItemWithTitle:@"New Wework" action:@selector(onNewWeworkInstance:) keyEquivalent:@"N"];
    [NSApp setMainMenu:mainMenu];
}

- (void)onNewWeworkInstance:(NSMenuItem *)item {
    NSLog(@"%@",[WLLTools executeShellCommand:@"open -n /Applications/企业微信.app"]);
}

-(NSUInteger)hook_count{
    NSUInteger count = [self hook_count];
    if (count>0 &&  [[self performSelector:@selector(objectAtIndex:) withObject:0] isKindOfClass:[NSRunningApplication class]]){
        return 0;
    }
    return count;
}

@end
