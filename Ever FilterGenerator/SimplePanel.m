//
//  GammaPanel.m
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/15/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import "SimplePanel.h"

@implementation SimplePanel

- (IBAction)textChanged:(id)sender {
    [self setFloatValue:self.textField.floatValue];
    if ([self.delegate respondsToSelector:@selector(valueChanged:newValue:)]) {
        [self.delegate valueChanged:self newValue:[self getFloatValue]];
    }
}

- (IBAction)sliderChanged:(id)sender {
    [self setFloatValue:self.slider.floatValue];
    if ([self.delegate respondsToSelector:@selector(valueChanged:newValue:)]) {
        [self.delegate valueChanged:self newValue:[self getFloatValue]];
    }
}

- (void) setFloatValue:(float)value {
    self.slider.floatValue = value;
    self.textField.floatValue = value;
}

- (float) getFloatValue {
    return self.slider.floatValue;
}

+ (SimplePanel*) startPanel:(id<SimplePanelDelegate>)delegate minValue:(float)minValue maxValue:(float)maxValue title:(NSString *)title {
    SimplePanel * panel = [[SimplePanel alloc] initWithWindowNibName:@"SimplePanel"];
    
    [panel loadWindow];
    
    panel.delegate = delegate;

    [panel.slider setMinValue:minValue];
    [panel.slider setMaxValue:maxValue];
    [panel.window setTitle:title];
    panel.staticText.stringValue = [title stringByAppendingString:@" value"];

    [panel showWindow:delegate];
    
    return panel;
}

@end
