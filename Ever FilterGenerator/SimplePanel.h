//
//  GammaPanel.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/15/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol SimplePanelDelegate <NSObject>

- (void) valueChanged:(id)sender newValue:(float)value;
- (void) panelClosed:(id)sender;

@end

@interface SimplePanel : NSWindowController {
    
}

- (IBAction)textChanged:(id)sender;
- (IBAction)sliderChanged:(id)sender;

- (void) setFloatValue:(float)value;
- (float) getFloatValue;

+ (SimplePanel*) startPanel:(id<SimplePanelDelegate>)delegate minValue:(float)minValue maxValue:(float)maxValue title:(NSString*)title;

@property (strong, nonatomic) id<SimplePanelDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSSlider *slider;
@property (weak, nonatomic) IBOutlet NSTextField *textField;
@property (weak, nonatomic) IBOutlet NSSlider *sliderChanged;
@property (weak, nonatomic) IBOutlet NSTextField *staticText;

@end
