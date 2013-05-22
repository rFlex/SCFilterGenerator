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

- (NSString*) getCSharpParameters:(NSString*)variableName;
- (void) willRebuildPipeline;
- (void) didRebuildPipeline;
- (void) willProcessImage;
- (void) showParameterWindow;
- (id) initWithName:(NSString*)filterName andFilter:(GPUImageFilter*)imageFilter;
- (EverFilter*) newInstance;

@property (assign, nonatomic) BOOL enabled;
@property (strong, nonatomic) id<FilterManipulator> manipulator;
@property (strong, nonatomic) GPUImageFilter * filter;
@property (strong, nonatomic) NSString * name;

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

@property (strong, nonatomic) LevelsPanel * panel;

@end

@interface EverLevelsFilter : EverFilter {
    
}

@property (strong, nonatomic) ChannelDelegate * redDelegate;
@property (strong, nonatomic) ChannelDelegate * greenDelegate;
@property (strong, nonatomic) ChannelDelegate * blueDelegate;
@property (strong, nonatomic) ChannelDelegate * allDelegate;


@end

@interface EverBlendFilter : EverFilter<BlendPanelDelegate> {
    
}

@property (strong, nonatomic) BlendPanel * panel;
@property (strong, nonatomic) NSImage * image;
@property (strong, nonatomic) GPUImagePicture * picture;
@property (copy, nonatomic) NSURL * file;

@end

@interface EverMultiplyBlendFilter : EverBlendFilter

@end

@interface EverOverlayBlendFilter : EverBlendFilter

@end

@interface EverAddBlendFilter : EverBlendFilter

@end

@interface EverSubtractBlendFilter : EverBlendFilter

@end

@interface EverColorBurnBlendFilter : EverBlendFilter

@end

@interface EverScreenBlendFilter : EverBlendFilter

@end

@interface EverAlphaBlendFilter : EverBlendFilter

@end

@interface EverNormalBlendFilter : EverBlendFilter

@end

@interface EverLinearBlendFilter : EverBlendFilter

@end

@interface EverExclusionFilter : EverBlendFilter

@end

@interface UniqueValueEverFilter : EverFilter<SimplePanelDelegate> {
    
}

@property (assign, nonatomic) float minValue;
@property (assign, nonatomic) float maxValue;
@property (strong, nonatomic) SimplePanel * panel;

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