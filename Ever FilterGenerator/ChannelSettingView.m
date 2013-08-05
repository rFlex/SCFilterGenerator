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
        [self.delegate minValueChanged:self :[self getMinValue]];
    }
}

- (void) signalGammaValueChanged {
    if ([self.delegate respondsToSelector:@selector(gammaValueChanged::)]) {
        [self.delegate gammaValueChanged:self :[self getGammaValue]];
    }
}

- (void) signalMaxValueChanged {
    if ([self.delegate respondsToSelector:@selector(maxValueChanged::)]) {
        [self.delegate maxValueChanged:self :[self getMaxValue]];
    }
}

- (void) signalMinOutValueChanged {
    if ([self.delegate respondsToSelector:@selector(minOutValueChanged::)]) {
        [self.delegate minOutValueChanged:self :[self getMinOutValue]];
    }
}

- (void) signalMaxOutValueChanged {
    if ([self.delegate respondsToSelector:@selector(maxOutValueChanged::)]) {
        [self.delegate maxOutValueChanged:self :[self getMaxOutValue]];
    }
}

- (float) getMinValue {
    return self.minSlider.floatValue / self.minSlider.maxValue;
}

- (void) setMinValue:(float)value {
    NSInteger intValue = (NSInteger)(value * self.minSlider.maxValue);
    
    self.minSlider.integerValue = intValue;
    self.minTextField.intValue = self.minSlider.integerValue;
}

- (float) getGammaValue {
    return self.gamSlider.floatValue;
}

- (void) setGammaValue:(float)value {
    self.gamSlider.floatValue = value;
    self.gamTextField.floatValue = self.gamSlider.floatValue;
}

- (float) getMaxValue {
    return self.maxSlider.floatValue / self.maxSlider.maxValue;
}

- (void) setMaxValue:(float)value {
    NSInteger intValue = (NSInteger)(value * self.maxSlider.maxValue);
    
    self.maxSlider.integerValue = intValue;
    self.maxTextField.integerValue = self.maxSlider.integerValue;
}

- (float) getMinOutValue {
    return self.minOutSlider.floatValue / self.minOutSlider.maxValue;
}

- (void) setMinOutValue:(float)value {
    NSInteger intValue = (NSInteger)(value * self.minOutSlider.maxValue);

    self.minOutSlider.integerValue = intValue;
    self.minOutTextField.integerValue = self.minOutSlider.integerValue;
}

- (float) getMaxOutValue {
    return self.maxOutSlider.floatValue / self.maxOutSlider.maxValue;
}

- (void) setMaxOutValue:(float)value {
    NSInteger intValue = (NSInteger)(value * self.maxOutSlider.maxValue);
    
    self.maxOutSlider.integerValue = intValue;
    self.maxOutTextField.integerValue = self.maxOutSlider.integerValue;
}

- (IBAction)minTextFieldChanged:(id)sender {
    [self setMinValue:self.minTextField.floatValue / self.maxSlider.maxValue];
    [self signalMinValueChanged];
}

- (IBAction)minSliderChanged:(id)sender {
    [self setMinValue:self.minSlider.floatValue / self.minSlider.maxValue];
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
    [self setMaxValue:self.maxTextField.floatValue / self.maxSlider.maxValue];
    [self signalMaxValueChanged];
}

- (IBAction)maxSliderChanged:(id)sender {
    [self setMaxValue:self.maxSlider.floatValue / self.maxSlider.maxValue];
    [self signalMaxValueChanged];
}

- (IBAction)minOutTextFieldChanged:(id)sender {
    [self setMinOutValue:self.minOutTextField.floatValue / self.minOutSlider.maxValue];
    [self signalMinOutValueChanged];
}

- (IBAction)minOutSliderChanged:(id)sender {
    [self setMinOutValue:self.minOutSlider.floatValue / self.minOutSlider.maxValue];
    [self signalMinOutValueChanged];
}

- (IBAction)maxOutTextFieldChanged:(id)sender {
    [self setMaxOutValue:self.maxOutTextField.floatValue / self.maxOutSlider.maxValue];
    [self signalMaxOutValueChanged];
}

- (IBAction)maxOutSliderChanged:(id)sender {
    [self setMaxOutValue:self.maxOutSlider.floatValue / self.maxOutSlider.maxValue];
    [self signalMaxOutValueChanged];
}
@end
