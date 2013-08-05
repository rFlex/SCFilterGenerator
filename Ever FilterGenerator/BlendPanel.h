//
//  BlendPanel.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/15/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol BlendPanelDelegate <NSObject>

@optional
- (void) imageChanged:(id)sender image:(NSImage*)image url:(NSURL*)path;

@end

@interface BlendPanel : NSWindowController {
    
}

@property (strong) id<BlendPanelDelegate> delegate;
@property (weak) IBOutlet NSTextField *fileTextField;

- (IBAction) openFilePressed:(id)sender;

+ (BlendPanel*) startPanel:(id<BlendPanelDelegate>)delegate;

- (void) setFile:(NSString*)file;

@end
