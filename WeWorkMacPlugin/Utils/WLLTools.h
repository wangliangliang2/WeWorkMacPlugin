//
//  WLLTools.h
//  QQPlugin
//
//  Created by Anonymous on 05/02/2018.
//  Copyright © 2018 Anonymous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface WLLTools : NSObject

/**
 替换对象方法
 
 @param originalClass 原始类
 @param originalSelector 原始类的方法
 @param swizzledClass 替换类
 @param swizzledSelector 替换类的方法
 */
void wll_hookMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector);

/**
 替换类方法
 
 @param originalClass 原始类
 @param originalSelector 原始类的类方法
 @param swizzledClass 替换类
 @param swizzledSelector 替换类的类方法
 */
void wll_hookClassMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector);


+ (NSString *)executeShellCommand:(NSString *)msg;

+ (void)switchSandboxPath;

@end
