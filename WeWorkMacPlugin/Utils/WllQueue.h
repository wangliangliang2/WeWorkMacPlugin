//
//  WllQueue.h
//  QQPlugin
//
//  Created by Anonymous on 06/02/2018.
//  Copyright © 2018 Anonymous. All rights reserved.
//

#ifndef WllQueue_h
#define WllQueue_h

/**
 队列指定
 
 */

static void DispactchSetSpecific(dispatch_queue_t queue, const void *key) {
    CFStringRef context = CFSTR("context");
    dispatch_queue_set_specific(queue,
                                key,
                                (void*)context,
                                (dispatch_function_t)CFRelease);
}

static void DispatchSync(dispatch_queue_t queue, const void *key, dispatch_block_t block) {
    CFStringRef context = (CFStringRef)dispatch_get_specific(key);
    // 该函数执行时如果在指定 dispatch_queue_t 则直接执行 block，如果不在指定 dispatch_queue_t 则 dispatch_sync 到指定队列执行，用于避免 dispatch_sync 可能引起的死锁
    if (context) {
        block();
    } else {
        dispatch_sync(queue, block);
    }
}

static void DispatchAsync(dispatch_queue_t queue, const void *key, dispatch_block_t block) {
    CFStringRef context = (CFStringRef)dispatch_get_specific(key);
    // 该函数执行时如果在指定 dispatch_queue_t 则直接执行 block，如果不在指定 dispatch_queue_t 则 dispatch_async 到指定队列执行
    if (context) {
        block();
    } else {
        dispatch_async(queue, block);
    }
}

#endif /* WllQueue_h */
