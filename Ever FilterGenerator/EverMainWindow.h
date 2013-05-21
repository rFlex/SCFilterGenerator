//
//  EverMainWindow.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/14/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GPUImage/GPUImage.h"
#import "EverFilters.h"
#import "EverFilterCellView.h"

@interface EverMainWindow : NSWindow<FilterManipulator, NSTableViewDelegate, NSTableViewDataSource, EverFilterCellViewDelegate> {
    GPUImagePicture * _source;
}

- (void) buildThatThing;
- (void) rebuildPipeline;
- (void) processImage;
- (void) bypassBoxChanged:(EverFilterCellView*)cell;
- (void) deletePressed:(EverFilterCellView*)cell;
- (void) editPressed:(EverFilterCellView*)cell;

@property (strong, nonatomic) NSURL * file;
@property (strong, nonatomic) NSMutableArray * filters;

@property (weak, nonatomic) IBOutlet NSView *mainView;
@property (weak, nonatomic) IBOutlet GPUImageView *imageView;
@property (weak) IBOutlet NSTableView *filterTableView;

@property (strong, nonatomic) GPUImagePicture * source;
@property (strong, nonatomic) NSMutableDictionary * availableFilters;

@end
