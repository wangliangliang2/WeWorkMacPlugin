//
//  WeWorkMacPlugin.h
//  WeWorkMacPlugin
//
//  Created by Anonymous on 17/05/2018.
//  Copyright © 2018 Anonymous. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for WeWorkMacPlugin.
FOUNDATION_EXPORT double WeWorkMacPluginVersionNumber;

//! Project version string for WeWorkMacPlugin.
FOUNDATION_EXPORT const unsigned char WeWorkMacPluginVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WeWorkMacPlugin/PublicHeader.h>

@interface WEWApplicationLifeCricleObserver : NSObject
- (void)applicationDidFinishLaunching;
@end

@interface WEWMessage : NSObject
@property(nonatomic) BOOL isRevoke;
@property(nonatomic) BOOL isRevokeByAck; // @synthesize isRevokeByAck=_isRevokeByAck;
@property(nonatomic) BOOL isRevokeInReceiptMode;
@end

@interface WEWCustomView : NSView
@property(nonatomic) BOOL showWaterMark;
@end

@interface WEWConvListController : NSObject
- (void)p_onTableViewDoubleClick;
@end

