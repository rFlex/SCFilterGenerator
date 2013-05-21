//
//  EverFilters.m
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/14/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import "EverFilters.h"
#import "LevelsPanel.h"

@implementation EverFilter

@synthesize filter;
@synthesize name;

-(id)initWithName:(NSString *)filterName andFilter:(GPUImageFilter *)imageFilter {
    if (self) {
        if (!(self = [super init])) return nil;
        
        self.name = filterName;
        self.filter = imageFilter;
        self.enabled = YES;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    
    if (self) {
        self.enabled = [aDecoder decodeBoolForKey:@"Enabled"];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:self.enabled forKey:@"Enabled"];
}

-(id) copyWithZone:(NSZone *)zone {
    EverFilter * everFilter = [self newInstance];
    
    everFilter.name = self.name;
    everFilter.filter = self.filter;
    
    return everFilter;
}

- (void) willRebuildPipeline {
    
}

- (void) didRebuildPipeline {
    
}

- (void) willProcessImage {
    
}

- (EverFilter*) newInstance {
    return [[EverFilter alloc] initWithName:self.name andFilter:self.filter];
}

- (void) showParameterWindow {
    NSLog(@"Not implemented");
}

@end

@implementation ChannelDelegate

- (id) initWithFilter:(EverFilter *)filter {
    self = [super init];
    
    if (self) {
        _filter = filter;
    }
    
    return self;
}

- (void) minValueChanged:(id)sender :(float)value {
    [_filter.manipulator processImage];
}

- (void) gammaValueChanged:(id)sender :(float)value {
    [_filter.manipulator processImage];
}

- (void) maxValueChanged:(id)sender :(float)value {
    [_filter.manipulator processImage];
}

- (void) minOutValueChanged:(id)sender :(float)value {
    [_filter.manipulator processImage];
}

- (void) maxOutValueChanged:(id)sender :(float)value {
    [_filter.manipulator processImage];
}

- (GPUImageLevelsFilter*) levelFilters {
    return (GPUImageLevelsFilter*)(_filter.filter);
}

@end

@implementation RedChannelDelegate

- (void) minValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMin:value];
    [super minValueChanged:sender :value];
}

- (void) gammaValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMid:value];
    [super gammaValueChanged:sender :value];
}

- (void) maxValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMax:value];
    [super maxValueChanged:sender :value];
}

- (void) minOutValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMinOut:value];
    [super minOutValueChanged:sender :value];
}

- (void) maxOutValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMaxOut:value];
    [super maxOutValueChanged:sender :value];
}

@end

@implementation GreenChannelDelegate

- (void) minValueChanged:(id)sender :(float)value {
    [[self levelFilters] setGreenMin:value];
    [super minValueChanged:sender :value];
}

- (void) gammaValueChanged:(id)sender :(float)value {
    [[self levelFilters] setGreenMid:value];
    [super gammaValueChanged:sender :value];
}

- (void) maxValueChanged:(id)sender :(float)value {
    [[self levelFilters] setGreenMax:value];
    [super maxValueChanged:sender :value];
}

- (void) minOutValueChanged:(id)sender :(float)value {
    [[self levelFilters] setGreenMinOut:value];
    [super minOutValueChanged:sender :value];
}

- (void) maxOutValueChanged:(id)sender :(float)value {
    [[self levelFilters] setGreenMaxOut:value];
    [super maxOutValueChanged:sender :value];
}

@end

@implementation BlueChannelDelegate

- (void) minValueChanged:(id)sender :(float)value {
    [[self levelFilters] setBlueMin:value];
    [super minValueChanged:sender :value];
}

- (void) gammaValueChanged:(id)sender :(float)value {
    [[self levelFilters] setBlueMid:value];
    [super gammaValueChanged:sender :value];
}

- (void) maxValueChanged:(id)sender :(float)value {
    [[self levelFilters] setBlueMax:value];
    [super maxValueChanged:sender :value];
}

- (void) minOutValueChanged:(id)sender :(float)value {
    [[self levelFilters] setBlueMinOut:value];
    [super minOutValueChanged:sender :value];
}

- (void) maxOutValueChanged:(id)sender :(float)value {
    [[self levelFilters] setBlueMaxOut:value];
    [super maxOutValueChanged:sender :value];
}

@end

@implementation AllChannelDelegate

- (void) minValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMin:value];
    [[self levelFilters] setGreenMin:value];
    [[self levelFilters] setBlueMin:value];
    [self.panel setMinValues:value];
    [super minValueChanged:sender :value];
}

- (void) gammaValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMid:value];
    [[self levelFilters] setGreenMid:value];
    [[self levelFilters] setBlueMid:value];
    [self.panel setMidValues:value];
    [super gammaValueChanged:sender :value];
}

- (void) maxValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMax:value];
    [[self levelFilters] setGreenMax:value];
    [[self levelFilters] setBlueMax:value];
    [self.panel setMaxValues:value];
    [super maxValueChanged:sender :value];
}

- (void) minOutValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMinOut:value];
    [[self levelFilters] setGreenMinOut:value];
    [[self levelFilters] setBlueMinOut:value];
    [self.panel setMinOutValues:value];
    [super minOutValueChanged:sender :value];
}

- (void) maxOutValueChanged:(id)sender :(float)value {
    [[self levelFilters] setRedMaxOut:value];
    [[self levelFilters] setGreenMaxOut:value];
    [[self levelFilters] setBlueMaxOut:value];
    [self.panel setMaxOutValues:value];
    [super maxOutValueChanged:sender :value];
}

@end

@implementation EverLevelsFilter

- (id) init {
    self.redDelegate = [[RedChannelDelegate alloc] initWithFilter:self];
    self.blueDelegate = [[BlueChannelDelegate alloc] initWithFilter:self];
    self.greenDelegate = [[GreenChannelDelegate alloc] initWithFilter:self];
    self.allDelegate = [[AllChannelDelegate alloc] initWithFilter:self];

    return [super initWithName:@"Levels" andFilter:[[GPUImageLevelsFilter alloc] init]];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    
    if (self) {
        GPUImageLevelsFilter * levelsFilter = (GPUImageLevelsFilter*)self.filter;
        
        [levelsFilter setBlueMax:[aDecoder decodeFloatForKey:@"BlueMax"]];
        [levelsFilter setBlueMaxOut:[aDecoder decodeFloatForKey:@"BlueMaxOut"]];
        [levelsFilter setBlueMid:[aDecoder decodeFloatForKey:@"BlueMid"]];
        [levelsFilter setBlueMin:[aDecoder decodeFloatForKey:@"BlueMin"]];
        [levelsFilter setBlueMinOut:[aDecoder decodeFloatForKey:@"BlueMinOut"]];
        [levelsFilter setBlueMaxOut:[aDecoder decodeFloatForKey:@"BlueMaxOut"]];
        [levelsFilter setGreenMax:[aDecoder decodeFloatForKey:@"GreenMax"]];
        [levelsFilter setGreenMaxOut:[aDecoder decodeFloatForKey:@"GreenMaxOut"]];
        [levelsFilter setGreenMid:[aDecoder decodeFloatForKey:@"GreenMid"]];
        [levelsFilter setGreenMin:[aDecoder decodeFloatForKey:@"GreenMin"]];
        [levelsFilter setGreenMinOut:[aDecoder decodeFloatForKey:@"GreenMinOut"]];
        [levelsFilter setGreenMaxOut:[aDecoder decodeFloatForKey:@"GreenMaxOut"]];
        [levelsFilter setRedMax:[aDecoder decodeFloatForKey:@"RedMax"]];
        [levelsFilter setRedMaxOut:[aDecoder decodeFloatForKey:@"RedMaxOut"]];
        [levelsFilter setRedMid:[aDecoder decodeFloatForKey:@"RedMid"]];
        [levelsFilter setRedMin:[aDecoder decodeFloatForKey:@"RedMin"]];
        [levelsFilter setRedMinOut:[aDecoder decodeFloatForKey:@"RedMinOut"]];
        [levelsFilter setRedMaxOut:[aDecoder decodeFloatForKey:@"RedMaxOut"]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    GPUImageLevelsFilter * levelsFilter = (GPUImageLevelsFilter*)self.filter;

    [aCoder encodeFloat:[levelsFilter getBlueMax] forKey:@"BlueMax"];
    [aCoder encodeFloat:[levelsFilter getBlueMaxOut] forKey:@"BlueMaxOut"];
    [aCoder encodeFloat:[levelsFilter getBlueMid] forKey:@"BlueMid"];
    [aCoder encodeFloat:[levelsFilter getBlueMin] forKey:@"BlueMin"];
    [aCoder encodeFloat:[levelsFilter getBlueMinOut] forKey:@"BlueMinOut"];
    [aCoder encodeFloat:[levelsFilter getGreenMax] forKey:@"GreenMax"];
    [aCoder encodeFloat:[levelsFilter getGreenMaxOut] forKey:@"GreenMaxOut"];
    [aCoder encodeFloat:[levelsFilter getGreenMid] forKey:@"GreenMid"];
    [aCoder encodeFloat:[levelsFilter getGreenMin] forKey:@"GreenMin"];
    [aCoder encodeFloat:[levelsFilter getGreenMinOut] forKey:@"GreenMinOut"];
    [aCoder encodeFloat:[levelsFilter getRedMax] forKey:@"RedMax"];
    [aCoder encodeFloat:[levelsFilter getRedMaxOut] forKey:@"RedMaxOut"];
    [aCoder encodeFloat:[levelsFilter getRedMid] forKey:@"RedMid"];
    [aCoder encodeFloat:[levelsFilter getRedMin] forKey:@"RedMin"];
    [aCoder encodeFloat:[levelsFilter getRedMinOut] forKey:@"RedMinOut"];
}

- (void) showParameterWindow {
    LevelsPanel * panel = [LevelsPanel startPanel];
    [panel setRedDelegate:self.redDelegate];
    [panel setBlueDelegate:self.blueDelegate];
    [panel setGreenDelegate:self.greenDelegate];
    [panel setAllDelegate:self.allDelegate];
    
    GPUImageLevelsFilter * levelsFilter = (GPUImageLevelsFilter*)self.filter;
    
    [panel setRedChannelValuesMin:[levelsFilter getRedMin] mid:[levelsFilter getRedMid] max:[levelsFilter getRedMax] minOut:[levelsFilter getRedMinOut] maxOut:[levelsFilter getRedMaxOut]];
    [panel setBlueChannelValuesMin:[levelsFilter getBlueMin] mid:[levelsFilter getBlueMid] max:[levelsFilter getBlueMax] minOut:[levelsFilter getBlueMinOut] maxOut:[levelsFilter getBlueMaxOut]];
    [panel setGreenChannelValuesMin:[levelsFilter getGreenMin] mid:[levelsFilter getGreenMid] max:[levelsFilter getGreenMax] minOut:[levelsFilter getGreenMinOut] maxOut:[levelsFilter getGreenMaxOut]];
    
    ((AllChannelDelegate*)self.allDelegate).panel = panel;
}

- (EverFilter*) newInstance {
    return [[EverLevelsFilter alloc] init];
}

@end

@implementation EverBlendFilter


- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        NSString * file = [aDecoder decodeObjectForKey:@"fileName"];
        self.picture = [[GPUImagePicture alloc] initWithURL:[[NSURL alloc] initWithString:file]];
        [self.picture addTarget:self.filter];
        [self.picture processImage];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.file forKey:@"fileName"];
}

- (void) showParameterWindow {
    BlendPanel * panel = [BlendPanel startPanel:self];
    [panel setFile:self.file];
}

- (void) willRebuildPipeline {
    if (self.picture != nil) {
        [self.picture removeAllTargets];
    }
}

- (void) didRebuildPipeline {
    if (self.picture != nil) {
        [self.picture addTarget:self.filter atTextureLocation:1];
    }
}

- (void) willProcessImage {
    if (self.picture != nil) {
        [self.picture processImage];
    }
}

- (void) imageChanged:(id)sender image:(NSImage *)image url:(NSURL *)url {
    self.picture = [[GPUImagePicture alloc] initWithImage:image];
    [self.picture addTarget:self.filter];
    
    [self.picture processImage];
    
    self.file = url.absoluteString;
}

@end

@implementation EverMultiplyBlendFilter

- (id) init {
    return [super initWithName:@"Multiply blend" andFilter:[[GPUImageMultiplyBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverMultiplyBlendFilter alloc] init];
}

@end
    
@implementation  EverOverlayBlendFilter

- (id) init {
    return [super initWithName:@"Overlay blend" andFilter:[[GPUImageOverlayBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverOverlayBlendFilter alloc] init];
}

@end

@implementation EverAddBlendFilter

- (id) init {
    return [super initWithName:@"Add blend" andFilter:[[GPUImageAddBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverAddBlendFilter alloc] init];
}

@end

@implementation EverSubtractBlendFilter

- (id) init {
    return [super initWithName:@"Substract blend" andFilter:[[GPUImageSubtractBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverSubtractBlendFilter alloc] init];
}

@end

@implementation EverColorBurnBlendFilter

- (id) init {
    return [super initWithName:@"Color burn blend" andFilter:[[GPUImageColorBurnBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverColorBurnBlendFilter alloc] init];
}

@end

@implementation EverScreenBlendFilter

- (id) init {
    return [super initWithName:@"Screen blend" andFilter:[[GPUImageScreenBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverScreenBlendFilter alloc] init];
}

@end

@implementation EverAlphaBlendFilter

- (id) init {
    return [super initWithName:@"Alpha blend" andFilter:[[GPUImageAlphaBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverAlphaBlendFilter alloc] init];
}

@end

@implementation EverNormalBlendFilter

- (id) init {
    return [super initWithName:@"Normal blend" andFilter:[[GPUImageNormalBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverNormalBlendFilter alloc] init];
}

@end

@implementation EverLinearBlendFilter

- (id) init {
    return [super initWithName:@"Linear burn blend" andFilter:[[GPUImageLinearBurnBlendFilter alloc] init]];
}

- (EverFilter*) newInstance {
    return [[EverLinearBlendFilter alloc] init];
}

@end

@implementation UniqueValueEverFilter

- (id) initWithName:(NSString *)filterName andFilter:(GPUImageFilter *)imageFilter minValue:(float)aMinValue maxValue:(float)aMaxValue {
    self = [super initWithName:filterName andFilter:imageFilter];
    
    self.minValue = aMinValue;
    self.maxValue = aMaxValue;
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setValue:[aDecoder decodeFloatForKey:@"UniqueValue"]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeFloat:[self getValue] forKey:@"UniqueValue"];
}

- (void) showParameterWindow {
    SimplePanel * panel = [SimplePanel startPanel:self minValue:self.minValue maxValue:self.maxValue title:self.name];
        
    [panel setFloatValue:[self getValue]];
    self.panel = panel;
}

- (float) getValue {
    return 0;
}

- (void) setValue:(float)value {
    [self.manipulator processImage];
}

- (void) valueChanged:(id)sender newValue:(float)value {
    [self setValue:value];
}

- (void) panelClosed:(id)sender {
    self.panel = nil;
}

@end

@implementation EverBrightnessFilter

-(id)init {
    return [super initWithName:@"Brightness" andFilter:[[GPUImageBrightnessFilter alloc] init] minValue:-1 maxValue:1];
}

- (float) getValue {
    return ((GPUImageBrightnessFilter*)self.filter).brightness;
}

- (void) setValue:(float)value {
    ((GPUImageBrightnessFilter*)self.filter).brightness = value;
    [super setValue:value];
}

-(EverFilter*)newInstance {
    return [[EverBrightnessFilter alloc] init];
}

@end

@implementation EverExposureFilter

- (id) init {
    return [super initWithName:@"Exposure" andFilter:[[GPUImageExposureFilter alloc] init] minValue:-10 maxValue:10];
}

- (float) getValue {
    return ((GPUImageExposureFilter*)self.filter).exposure;
}

- (void) setValue:(float)value {
    ((GPUImageExposureFilter*)self.filter).exposure = value;
    [super setValue:value];
}

- (EverFilter*) newInstance {
    return [[EverExposureFilter alloc] init];
}

@end

@implementation EverGammaFilter

- (id) init {
    return [super initWithName:@"Gamma" andFilter:[[GPUImageGammaFilter alloc] init] minValue:0 maxValue:3];
}

- (float) getValue {
    return ((GPUImageGammaFilter*)self.filter).gamma;
}

- (void) setValue:(float)value {
    ((GPUImageGammaFilter*)self.filter).gamma = value;
    [super setValue:value];
}

- (EverFilter*) newInstance {
    return [[EverGammaFilter alloc] init];
}

@end

@implementation EverContrastFilter

- (id) init {
    return [super initWithName:@"Contrast" andFilter:[[GPUImageContrastFilter alloc] init] minValue:0 maxValue:4];
}

- (float) getValue {
    return ((GPUImageContrastFilter*)self.filter).contrast;
}

- (void) setValue:(float)value {
    ((GPUImageContrastFilter*)self.filter).contrast = value;
    [super setValue:value];
}

- (EverFilter*) newInstance {
    return [[EverContrastFilter alloc] init];
}

@end

@implementation EverSaturationFilter

- (id) init {
    return [super initWithName:@"Saturation" andFilter:[[GPUImageSaturationFilter alloc] init] minValue:0 maxValue:2];
}

- (float) getValue {
    return ((GPUImageSaturationFilter*)self.filter).saturation;
}

- (void) setValue:(float)value {
    ((GPUImageSaturationFilter*)self.filter).saturation = value;
    [super setValue:value];
}

- (EverFilter*) newInstance {
    return [[EverSaturationFilter alloc] init];
}

@end

@implementation EverGaussianBlurFilter

- (id) init {
    return [super initWithName:@"Gaussian blur" andFilter:[[GPUImageGaussianBlurFilter alloc] init] minValue:0 maxValue:40];
}

- (float) getValue {
    return ((GPUImageGaussianBlurFilter*)self.filter).blurSize;
}

- (void) setValue:(float)value {
    ((GPUImageGaussianBlurFilter*)self.filter).blurSize = value;
    [super setValue:value];
}

- (EverFilter*) newInstance {
    return [[EverGaussianBlurFilter alloc] init];
}

@end

@implementation EverSharpFilter

- (id) init {
    return [super initWithName:@"Sharpen" andFilter:[[GPUImageSharpenFilter alloc] init] minValue:-4 maxValue:4];
}

- (float) getValue {
    return ((GPUImageSharpenFilter*)self.filter).sharpness;
}

- (void) setValue:(float)value {
    ((GPUImageSharpenFilter*)self.filter).sharpness = value;
    [super setValue:value];
}

- (EverFilter*) newInstance {
    return [[EverSharpFilter alloc] init];
}

@end

@implementation EverPixellateFilter

- (id) init {
    return [super initWithName:@"Pixellate" andFilter:[[GPUImagePixellateFilter alloc] init] minValue:0 maxValue:1];
}

- (float) getValue {
    return ((GPUImagePixellateFilter*)self.filter).fractionalWidthOfAPixel;
}

- (void) setValue:(float)value {
    ((GPUImagePixellateFilter*)self.filter).fractionalWidthOfAPixel = value;
    [super setValue:value];
}

- (EverFilter*) newInstance {
    return [[EverPixellateFilter alloc] init];
}

@end