//
//  ChannelSettingView.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/15/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ChannelSettingViewDelegate <NSObject>

@optional
- (void) minValueChanged:(id)sender :(float)value;
- (void) gammaValueChanged:(id)sender :(float)value;
- (void) maxValueChanged:(id)sender :(float)value;
- (void) minOutValueChanged:(id)sender :(float)value;
- (void) maxOutValueChanged:(id)sender :(float)value;

@end

@interface ChannelSettingView : NSView {
    
}

+ (ChannelSettingView*) instantiate:(NSObject*)owner;

- (float) getMinValue;
- (void) setMinValue:(float)value;
- (float) getGammaValue;
- (void) setGammaValue:(float)value;
- (float) getMaxValue;
- (void) setMaxValue:(float)value;
- (float) getMinOutValue;
- (void) setMinOutValue:(float)value;
- (float) getMaxOutValue;
- (void) setMaxOutValue:(float)value;

@property (assign) id<ChannelSettingViewDelegate> delegate;
@property (assign) IBOutlet NSTextField *channelName;
@property (assign) IBOutlet NSColorWell *colorWell;
@property (assign) IBOutlet NSTextField *minTextField;
@property (assign) IBOutlet NSSlider *minSlider;
@property (assign) IBOutlet NSTextField *gamTextField;
@property (assign) IBOutlet NSSlider *gamSlider;
@property (assign) IBOutlet NSTextField *maxTextField;
@property (assign) IBOutlet NSSlider *maxSlider;
@property (assign) IBOutlet NSTextField *minOutTextField;
@property (assign) IBOutlet NSSlider *minOutSlider;

@property (assign) IBOutlet NSTextField *maxOutTextField;
@property (assign) IBOutlet NSSlider *maxOutSlider;

- (IBAction)minTextFieldChanged:(id)sender;
- (IBAction)minSliderChanged:(id)sender;
- (IBAction)gamTextFieldChanged:(id)sender;
- (IBAction)gamSliderChanged:(id)sender;
- (IBAction)maxTextFieldChanged:(id)sender;
- (IBAction)maxSliderChanged:(id)sender;
- (IBAction)minOutTextFieldChanged:(id)sender;
- (IBAction)minOutSliderChanged:(id)sender;
- (IBAction)maxOutTextFieldChanged:(id)sender;
- (IBAction)maxOutSliderChanged:(id)sender;

@end
