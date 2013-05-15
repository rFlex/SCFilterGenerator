//
//  ChannelSettingView.m
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/15/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import "ChannelSettingView.h"
#import <objc/runtime.h>

@implementation ChannelSettingView

+ (ChannelSettingView*) instantiate:(NSObject*)owner {
    NSArray * array = nil;
    ChannelSettingView * view = nil;
    
    if ([[NSBundle mainBundle] loadNibNamed:@"ChannelSettingView" owner:owner topLevelObjects:&array]) {
        NSUInteger index = [array indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [obj isKindOfClass:[ChannelSettingView class]];
        }];
        
        if (index < [array count]) {
            view = [array objectAtIndex:index];
        }
    }
    
    return view;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}


- (void) signalMinValueChanged {
    if ([self.delegate respondsToSelector:@selector(minValueChanged::)]) {
        [self.delegate minValueChanged:self :self.minSlider.floatValue];
    }
}

- (void) signalGammaValueChanged {
    if ([self.delegate respondsToSelector:@selector(gammaValueChanged::)]) {
        [self.delegate gammaValueChanged:self :self.gamSlider.floatValue];
    }
}

- (void) signalMaxValueChanged {
    if ([self.delegate respondsToSelector:@selector(maxValueChanged::)]) {
        [self.delegate maxValueChanged:self :self.maxSlider.floatValue];
    }
}

- (void) signalMinOutValueChanged {
    if ([self.delegate respondsToSelector:@selector(minOutValueChanged::)]) {
        [self.delegate minOutValueChanged:self :self.minOutSlider.floatValue];
    }
}

- (void) signalMaxOutValueChanged {
    if ([self.delegate respondsToSelector:@selector(maxOutValueChanged::)]) {
        [self.delegate maxOutValueChanged:self :self.maxOutSlider.floatValue];
    }
}

- (float) getMinValue {
    return self.minSlider.floatValue;
}

- (void) setMinValue:(float)value {
    self.minSlider.floatValue = value;
    self.minTextField.floatValue = self.minSlider.floatValue;
}

- (float) getGammaValue {
    return self.gamSlider.floatValue;
}

- (void) setGammaValue:(float)value {
    self.gamSlider.floatValue = value;
    self.gamTextField.floatValue = self.gamSlider.floatValue;
}

- (float) getMaxValue {
    return self.maxSlider.floatValue;
}

- (void) setMaxValue:(float)value {
    self.maxSlider.floatValue = value;
    self.maxTextField.floatValue = self.maxSlider.floatValue;
}

- (float) getMinOutValue {
    return self.minOutSlider.floatValue;
}

- (void) setMinOutValue:(float)value {
    self.minOutSlider.floatValue = value;
    self.minOutTextField.floatValue = self.minOutSlider.floatValue;
}

- (float) getMaxOutValue {
    return self.maxOutSlider.floatValue;
}

- (void) setMaxOutValue:(float)value {
    self.maxOutSlider.floatValue = value;
    self.maxOutTextField.floatValue = self.maxOutSlider.floatValue;
}

- (IBAction)minTextFieldChanged:(id)sender {
    [self setMinValue:self.minTextField.floatValue];
    [self signalMinValueChanged];
}

- (IBAction)minSliderChanged:(id)sender {
    [self setMinValue:self.minSlider.floatValue];
    [self signalMinValueChanged];
}

- (IBAction)gamTextFieldChanged:(id)sender {
    [self setGammaValue:self.gamTextField.floatValue];
    [self signalGammaValueChanged];
}

- (IBAction)gamSliderChanged:(id)sender {
    [self setGammaValue:self.gamSlider.floatValue];
    [self signalGammaValueChanged];
}

- (IBAction)maxTextFieldChanged:(id)sender {
    [self setMaxValue:self.maxTextField.floatValue];
    [self signalMaxValueChanged];
}

- (IBAction)maxSliderChanged:(id)sender {
    [self setMaxValue:self.maxSlider.floatValue];
    [self signalMaxValueChanged];
}

- (IBAction)minOutTextFieldChanged:(id)sender {
    [self setMinOutValue:self.minOutTextField.floatValue];
    [self signalMinOutValueChanged];
}

- (IBAction)minOutSliderChanged:(id)sender {
    [self setMinOutValue:self.minOutSlider.floatValue];
    [self signalMinOutValueChanged];
}

- (IBAction)maxOutTextFieldChanged:(id)sender {
    [self setMaxOutValue:self.maxOutTextField.floatValue];
    [self signalMaxOutValueChanged];
}

- (IBAction)maxOutSliderChanged:(id)sender {
    [self setMaxOutValue:self.maxOutSlider.floatValue];
    [self signalMaxOutValueChanged];
}
@end
