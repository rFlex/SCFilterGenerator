//
//  BlendPanel.m
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/15/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import "BlendPanel.h"

@interface BlendPanel ()

@end

@implementation BlendPanel

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

+ (BlendPanel*) startPanel:(id<BlendPanelDelegate>)delegate {
    BlendPanel * panel = [[BlendPanel alloc] initWithWindowNibName:@"BlendPanel"];
    [panel loadWindow];
    
    panel.delegate = delegate;
    
    [panel showWindow:nil];
    
    return panel;
}

- (IBAction)openFilePressed:(id)sender {
    NSOpenPanel * panel = [NSOpenPanel openPanel];
    
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL * document = [[panel URLs] objectAtIndex:0];
            
            NSImage * image = [[NSImage alloc] initWithContentsOfURL:document];
            
            if ([image isValid]) {
                if ([self.delegate respondsToSelector:@selector(imageChanged:image:url:)]) {
                    [self.delegate imageChanged:self image:image url:document];
                }
                [self setFile:[document path]];
            }
        }
    }];

}

- (void) setFile:(NSString *)file {
    if (file != nil) {
        self.fileTextField.stringValue = [@"File: " stringByAppendingString:file];
    } else {
        self.fileTextField.stringValue = @"File: ";
    }
}

@end
