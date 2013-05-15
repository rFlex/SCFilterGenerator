//
//  LevelsPanel.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/15/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ChannelSettingView.h"

@interface LevelsPanel : NSWindowController {
    ChannelSettingView * _redSettings;
    ChannelSettingView * _blueSettings;
    ChannelSettingView * _greenSettings;
    ChannelSettingView * _allSettings;
}

+ (LevelsPanel*) startPanel;

- (void) setRedChannelValuesMin:(float)min mid:(float)mid max:(float)max minOut:(float)minOut maxOut:(float)maxOut;
- (void) setGreenChannelValuesMin:(float)min mid:(float)mid max:(float)max minOut:(float)minOut maxOut:(float)maxOut;
- (void) setBlueChannelValuesMin:(float)min mid:(float)mid max:(float)max minOut:(float)minOut maxOut:(float)maxOut;
- (void) setMinValues:(float)min;
- (void) setMidValues:(float)min;
- (void) setMaxValues:(float)max;
- (void) setMinOutValues:(float)minOut;
- (void) setMaxOutValues:(float)maxOut;

- (id<ChannelSettingViewDelegate>) getRedDelegate;
- (void) setRedDelegate:(id<ChannelSettingViewDelegate>)delegate;
- (id<ChannelSettingViewDelegate>) getBlueDelegate;
- (void) setBlueDelegate:(id<ChannelSettingViewDelegate>)delegate;
- (id<ChannelSettingViewDelegate>) getGreenDelegate;
- (void) setGreenDelegate:(id<ChannelSettingViewDelegate>)delegate;
- (id<ChannelSettingViewDelegate>) getAllDelegate;
- (void) setAllDelegate:(id<ChannelSettingViewDelegate>)delegate;

@property (assign) IBOutlet NSView *channelSettings;


@end
