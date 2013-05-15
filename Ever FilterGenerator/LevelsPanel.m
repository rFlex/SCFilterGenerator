//
//  LevelsPanel.m
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/15/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import "LevelsPanel.h"

@implementation LevelsPanel

+ (LevelsPanel*) startPanel {
    LevelsPanel * panel = [[LevelsPanel alloc] initWithWindowNibName:@"LevelsPanel"];
    [panel loadWindow];
    
    ChannelSettingView * red = [ChannelSettingView instantiate:panel];
    ChannelSettingView * green = [ChannelSettingView instantiate:panel];
    ChannelSettingView * blue = [ChannelSettingView instantiate:panel];
    ChannelSettingView * allColors = [ChannelSettingView instantiate:panel];
    
    NSView * baseView = [panel channelSettings];
    NSPoint currentOffset = NSMakePoint(0, 0);
    
    if (allColors != nil) {
        NSRect frame = allColors.frame;
        frame.origin = currentOffset;
        allColors.frame = frame;
        currentOffset.y += frame.size.height;
        

        allColors.colorWell.color = [NSColor whiteColor];
        
//        NSView * superView = allColors.colorWell.superview;
//        NSRect colorFrame = allColors.colorWell.frame;
//        NSView * container = [[NSView alloc] initWithFrame:colorFrame];
//        
//        [superView addSubview:container positioned:NSWindowBelow relativeTo:allColors.colorWell];
//        [allColors.colorWell removeFromSuperview];
//        
//        float cellWidth = colorFrame.size.width / 3;
//        
//        NSColorWell * redColor = [[NSColorWell alloc] initWithFrame:CGRectMake(0, 0, cellWidth, colorFrame.size.height)];
//        NSColorWell * greenColor = [[NSColorWell alloc] initWithFrame:CGRectMake(cellWidth, 0, cellWidth, colorFrame.size.height)];
//        NSColorWell * blueColor = [[NSColorWell alloc] initWithFrame:CGRectMake(cellWidth * 2, 0, cellWidth, colorFrame.size.height)];
//        
//        redColor.color = [NSColor redColor];
//        greenColor.color = [NSColor greenColor];
//        blueColor.color = [NSColor blueColor];
//        
//        [container addSubview:redColor];
//        [container addSubview:greenColor];
//        [container addSubview:blueColor];
        
        allColors.channelName.stringValue = @"All channels";
        
        [baseView addSubview:allColors];
    }
    
    if (blue != nil) {
        NSRect frame = blue.frame;
        frame.origin = currentOffset;
        blue.frame = frame;
        currentOffset.y += frame.size.height;
        
        blue.colorWell.color = [NSColor blueColor];
        blue.channelName.stringValue = @"Blue channel";
        
        [baseView addSubview:blue];
    }
    
    if (green != nil) {
        NSRect frame = green.frame;
        frame.origin = currentOffset;
        green.frame = frame;
        currentOffset.y += frame.size.height;
        
        green.colorWell.color = [NSColor greenColor];
        green.channelName.stringValue = @"Green channel";
        
        [baseView addSubview:green];
    }
    
    if (red != nil) {
        NSRect frame = red.frame;
        frame.origin = currentOffset;
        red.frame = frame;
        currentOffset.y += frame.size.height;
        
        [baseView addSubview:red];
    }

    
    [panel showWindow:nil];

    panel->_redSettings = red;
    panel->_greenSettings = green;
    panel->_blueSettings = blue;
    panel->_allSettings = allColors;
    
    return panel;
}

- (void)setRedChannelValuesMin:(float)min mid:(float)mid max:(float)max minOut:(float)minOut maxOut:(float)maxOut {
    [_redSettings setMinValue:min];
    [_redSettings setGammaValue:mid];
    [_redSettings setMaxValue:max];
    [_redSettings setMinOutValue:minOut];
    [_redSettings setMaxOutValue:maxOut];
}

- (void)setGreenChannelValuesMin:(float)min mid:(float)mid max:(float)max minOut:(float)minOut maxOut:(float)maxOut {
    [_greenSettings setMinValue:min];
    [_greenSettings setGammaValue:mid];
    [_greenSettings setMaxValue:max];
    [_greenSettings setMinOutValue:minOut];
    [_greenSettings setMaxOutValue:maxOut];
}

- (void)setBlueChannelValuesMin:(float)min mid:(float)mid max:(float)max minOut:(float)minOut maxOut:(float)maxOut {
    [_blueSettings setMinValue:min];
    [_blueSettings setGammaValue:mid];
    [_blueSettings setMaxValue:max];
    [_blueSettings setMinOutValue:minOut];
    [_blueSettings setMaxOutValue:maxOut];
}

- (void) setMinValues:(float)min {
    [_redSettings setMinValue:min];
    [_greenSettings setMinValue:min];
    [_blueSettings setMinValue:min];
}

- (void) setMidValues:(float)min {
    [_redSettings setGammaValue:min];
    [_greenSettings setGammaValue:min];
    [_blueSettings setGammaValue:min];
}

- (void) setMaxValues:(float)max {
    [_redSettings setMaxValue:max];
    [_greenSettings setMaxValue:max];
    [_blueSettings setMaxValue:max];
}

- (void) setMinOutValues:(float)minOut {
    [_redSettings setMinOutValue:minOut];
    [_greenSettings setMinOutValue:minOut];
    [_blueSettings setMinOutValue:minOut];

}

- (void) setMaxOutValues:(float)maxOut {
    [_redSettings setMaxOutValue:maxOut];
    [_greenSettings setMaxOutValue:maxOut];
    [_blueSettings setMaxOutValue:maxOut];
}


- (id<ChannelSettingViewDelegate>) getRedDelegate {
    return _redSettings.delegate;
}

- (void) setRedDelegate:(id<ChannelSettingViewDelegate>)delegate {
    _redSettings.delegate = delegate;
}

- (id<ChannelSettingViewDelegate>) getBlueDelegate {
    return _blueSettings.delegate;
}

- (void) setBlueDelegate:(id<ChannelSettingViewDelegate>)delegate {
    _blueSettings.delegate = delegate;
}

- (id<ChannelSettingViewDelegate>) getGreenDelegate {
    return _greenSettings.delegate;
}

- (void) setGreenDelegate:(id<ChannelSettingViewDelegate>)delegate {
    _greenSettings.delegate = delegate;
}

- (id<ChannelSettingViewDelegate>) getAllDelegate {
   return _allSettings.delegate;
}

- (void) setAllDelegate:(id<ChannelSettingViewDelegate>)delegate {
    _allSettings.delegate = delegate;
}


@end
