//
//  main.c
//  WeWorkMacPlugin
//
//  Created by Anonymous on 17/05/2018.
//  Copyright © 2018 Anonymous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+WorkWeChat.h"
static void __attribute__((constructor)) initialize(void) {
    NSLog(@"++++++++ WorkWechat Plugin loaded ++++++++");
    [NSObject hookWorkWeChat];
}

