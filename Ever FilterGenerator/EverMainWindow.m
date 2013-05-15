//
//  EverMainWindow.m
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/14/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <objc/runtime.h>
#import <GPUImage/GPUImage.h>
#import "EverMainWindow.h"
#import "EverFilterCellView.h"
#import "LevelsPanel.h"

@implementation EverMainWindow

@synthesize filters;
@synthesize source;

-(id)init {
    NSLog(@"Is it init?");
    
    return [super init];
}

-(void)dealloc {
    [super dealloc];
}

-(void)buildThatThing {
    self.imageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    
    self.filters = [[NSMutableArray alloc] init];
    self.availableFilters = [[NSMutableDictionary alloc] init];
    
    [self addFilter:[[EverBrightnessFilter alloc] init]];
    [self addFilter:[[EverExposureFilter alloc] init]];
    [self addFilter:[[EverGammaFilter alloc] init]];
    [self addFilter:[[EverContrastFilter alloc] init]];
    [self addFilter:[[EverGaussianBlurFilter alloc] init]];
    [self addFilter:[[EverSaturationFilter alloc] init]];
    [self addFilter:[[EverSharpFilter alloc] init]];
    [self addFilter:[[EverPixellateFilter alloc] init]];
    [self addFilter:[[EverLevelsFilter alloc] init]];
    [self addFilter:[[EverMultiplyBlendFilter alloc] init]];
    [self addFilter:[[EverOverlayBlendFilter alloc] init]];
    
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;    
}

-(void)addFilter:(EverFilter*)everFilter {
    [self.availableFilters setObject:everFilter forKey:everFilter.name];
}

-(void)disconnectPipeline {
    if (self.source != nil) {
        [self.source removeAllTargets];
    }
    
    for (EverFilter * everFilter in self.filters) {
        [everFilter.filter removeAllTargets];
    }
}

-(void)attachFilterToPipeline:(NSString*)filterName {
    EverFilter * filter = [self.availableFilters objectForKey:filterName];
    
    if (filter != nil) {
        filter = [filter newInstance];
        filter.manipulator = self;
        [self.filters addObject:filter];
        [self rebuildPipeline];
        
        NSIndexSet * set = [[NSIndexSet alloc] initWithIndex:self.filters.count];
        [self.filterTableView insertRowsAtIndexes:set withAnimation:NSTableViewAnimationSlideLeft];
    } else {
        NSLog(@"Filter %@ not found", filterName);
    }
}

- (void) removeFilter:(EverFilter*)filter {
    NSUInteger index = [self.filters indexOfObject:filter];
    
    [self disconnectPipeline];
    [self.filterTableView beginUpdates];
    [self.filterTableView removeRowsAtIndexes:[[NSIndexSet alloc]initWithIndex:index] withAnimation:NSTableViewAnimationSlideRight];
    [self.filters removeObjectAtIndex:index];
    [self.filterTableView endUpdates];
        
    [self rebuildPipeline];
}

-(void)showParameter:(EverFilter*)filter {
    [filter showParameterWindow];
}

-(void)rebuildPipeline {
    [self disconnectPipeline];
    
    if (self.source != nil) {
        GPUImageOutput * lastFilter = self.source;
        for (EverFilter * everFilter in self.filters) {
            if (everFilter.enabled) {
                [lastFilter addTarget:everFilter.filter];
                lastFilter = everFilter.filter;
            }
        }
        [lastFilter addTarget:self.imageView];
        
        [self processImage];
    }
}

-(void)clearPipeline {
    [self disconnectPipeline];
    [self.filters removeAllObjects];
}

-(void)newDocument:(id)sender {
    [self clearPipeline];
}

-(void)addFilterBrightness:(id)sender {
    [self attachFilterToPipeline:@"Brightness"];
}

- (void)addFilterExposure:(id)sender {
    [self attachFilterToPipeline:@"Exposure"];
}

- (void) addFilterGamma:(id)sender {
    [self attachFilterToPipeline:@"Gamma"];
}

- (void) addFilterContrast:(id)sender {
    [self attachFilterToPipeline:@"Contrast"];
}

- (void) addFilterGaussian:(id)sender {
    [self attachFilterToPipeline:@"Gaussian blur"];
}

- (void) addFilterSaturation:(id)sender {
    [self attachFilterToPipeline:@"Saturation"];
}

- (void) addFilterSharpen:(id)sender {
    [self attachFilterToPipeline:@"Sharpen"];
}

- (void) addFilterPixellate:(id)sender {
    [self attachFilterToPipeline:@"Pixellate"];
}

- (void) addFilterLevel:(id)sender {
    [self attachFilterToPipeline:@"Levels"];
}

- (void) addFilterOverlay:(id)sender {
    [self attachFilterToPipeline:@"Overlay blend"];
}

- (void) addFilterMultiply:(id)sender {
    [self attachFilterToPipeline:@"Multiply blend"];
}

-(void)processImage {
    if (self.source != nil) {
        [self.source processImage];
    }
}

-(void)openDocument:(id)sender {
    NSOpenPanel * panel = [NSOpenPanel openPanel];
    
    [panel setAllowedFileTypes:[[NSArray alloc] initWithObjects:@"efl", nil]];
    
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL * document = [[panel URLs] objectAtIndex:0];
            
            NSMutableArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfURL:document]];
                        
            if (array != nil) {
                [self setOpenedFile:document];
                for (EverFilter * filter in array) {
                    NSLog(@"Filter: %@", filter.name);
                    filter.manipulator = self;
                }
                
                [self clearPipeline];
                self.filters = array;
                
                [self.filterTableView reloadData];
                
                [self rebuildPipeline];
                NSLog(@"Loaded!");
            } else {
                NSLog(@"Failed to load");
            }
        }
    }];
}

- (void) openImage:(id)sender {
    NSOpenPanel * panel = [NSOpenPanel openPanel];
    
    [panel setAllowedFileTypes:[[NSArray alloc] initWithObjects:@"jpg", @"jpeg", @"png", nil]];
    
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL * document = [[panel URLs] objectAtIndex:0];
            
            NSImage * image = [[NSImage alloc] initWithContentsOfURL:document];
            
            if ([image isValid]) {
                GPUImagePicture * picture = [[GPUImagePicture alloc] initWithImage:image];
                
                [self disconnectPipeline];
                
                self.source = picture;
                
                [self rebuildPipeline];
                
                [picture release];
            } else {
                NSLog(@"Picture is not valid");
            }
        }
    }];
}

- (void) setOpenedFile:(NSURL*)file {
    self.file = file;
    self.title = [@"Ever FilterGenerator - " stringByAppendingString:[file lastPathComponent]];
}

- (void) saveDocument:(id)sender {
    if (self.file == nil) {
        [self saveDocumentTo:self];
    } else {
        [self saveDocumentToURL:self.file];
    }
}

- (void) saveDocumentToURL:(NSURL*)url {
    NSData* artistData = [NSKeyedArchiver archivedDataWithRootObject:self.filters];
    
    if (artistData != nil) {
        if ([artistData writeToURL:url atomically:YES]) {
            [self setOpenedFile:url];
            NSLog(@"Success");
        } else {
            NSLog(@"Failed to save");
        }
        
    } else {
        NSLog(@"Failed to archive");
    }
}

- (void) saveDocumentTo:(id)sender {
    NSSavePanel * panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:@"myFilter"];
    [panel setAllowedFileTypes:[[NSArray alloc] initWithObjects:@"efl", nil]];
    
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            [self saveDocumentToURL:[panel URL]];
        }
    }];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView*)tableView {
    return self.filters.count;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    EverFilterCellView * filterCell = [tableView makeViewWithIdentifier:@"EverFilterCellView" owner:self];
    
    if (filterCell != nil) {
        [filterCell buildCell:[self.filters objectAtIndex:row]];
        filterCell.delegate = self;
    } else {
        NSLog(@"Dat is noule");
    }
    
    return filterCell;
}

- (void) editPressed:(EverFilterCellView *)cell {
    [cell.filter showParameterWindow];
}

- (void) deletePressed:(EverFilterCellView *)cell {
    [self removeFilter:cell.filter];
}

- (void) bypassBoxChanged:(EverFilterCellView *)cell {
    cell.filter.enabled = cell.checkbox.state;
    [self rebuildPipeline];
    
    if (cell.filter.enabled) {
        [cell.filter filterWokeUp];
    }
}

- (BOOL) tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
    return YES;
}

- (NSDragOperation) tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    return NSDragOperationEvery;
}


@end
