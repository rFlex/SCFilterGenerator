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

@property (copy, nonatomic) NSURL * file;
@property (assign, nonatomic) IBOutlet NSView *mainView;
@property (assign, nonatomic) IBOutlet GPUImageView *imageView;
@property (retain, nonatomic) NSMutableArray * filters;

@property (retain, nonatomic) GPUImagePicture * source;
@property (retain, nonatomic) NSMutableDictionary * availableFilters;
@property (assign) IBOutlet NSTableView *filterTableView;

@end
