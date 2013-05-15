//
//  EverFilters.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/14/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>
#import "SimplePanel.h"
#import "LevelsPanel.h"
#import "BlendPanel.h"

@protocol FilterManipulator<NSObject>

- (void) rebuildPipeline;
- (void) processImage;

@end

@interface EverFilter : NSObject<NSCopying, NSCoding> {
    
    
}

- (void) filterWokeUp;
- (void) showParameterWindow;
- (id) initWithName:(NSString*)filterName andFilter:(GPUImageFilter*)imageFilter;
- (EverFilter*) newInstance;

@property (assign, nonatomic) BOOL enabled;
@property (retain, nonatomic) id<FilterManipulator> manipulator;
@property (retain, nonatomic) GPUImageFilter * filter;
@property (retain, nonatomic) NSString * name;

@end

@interface ChannelDelegate : NSObject<ChannelSettingViewDelegate> {
    EverFilter * _filter;
}

- (GPUImageLevelsFilter*) levelFilters;
- (id) initWithFilter:(EverFilter*)filter;

@end

@interface RedChannelDelegate : ChannelDelegate

@end

@interface GreenChannelDelegate : ChannelDelegate

@end

@interface BlueChannelDelegate : ChannelDelegate    

@end

@interface AllChannelDelegate : ChannelDelegate

@property (retain, nonatomic) LevelsPanel * panel;

@end

@interface EverLevelsFilter : EverFilter {
    
}

@property (retain, nonatomic) ChannelDelegate * redDelegate;
@property (retain, nonatomic) ChannelDelegate * greenDelegate;
@property (retain, nonatomic) ChannelDelegate * blueDelegate;
@property (retain, nonatomic) ChannelDelegate * allDelegate;


@end

@interface EverBlendFilter : EverFilter<BlendPanelDelegate> {
    
}

@property (retain, nonatomic) NSImage * image;
@property (assign, nonatomic) GPUImagePicture * picture;
@property (copy, nonatomic) NSString * file;

@end

@interface EverMultiplyBlendFilter : EverBlendFilter {
    
}

@end

@interface EverOverlayBlendFilter : EverBlendFilter {
    
}

@end

@interface UniqueValueEverFilter : EverFilter<SimplePanelDelegate> {
    
}

@property (assign, nonatomic) float minValue;
@property (assign, nonatomic) float maxValue;
@property (retain, nonatomic) SimplePanel * panel;

- (float) getValue;
- (void) setValue:(float)value;

- (id) initWithName:(NSString*)filterName andFilter:(GPUImageFilter*)imageFilter minValue:(float)minValue maxValue:(float)maxValue;
- (void) valueChanged:(id)sender newValue:(float)value;
- (void) panelClosed:(id)sender;


@end

@interface EverBrightnessFilter : UniqueValueEverFilter {
    
}

@end

@interface EverExposureFilter : UniqueValueEverFilter {
    
}


@end

@interface EverGammaFilter : UniqueValueEverFilter {
    
}

@end

@interface EverContrastFilter : UniqueValueEverFilter {
    
}

@end

@interface EverSaturationFilter : UniqueValueEverFilter {
    
}

@end

@interface EverGaussianBlurFilter : UniqueValueEverFilter {
    
}

@end

@interface EverSharpFilter : UniqueValueEverFilter {
    
}

@end

@interface EverPixellateFilter : UniqueValueEverFilter {
    
}

@end