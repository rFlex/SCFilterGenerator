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

@implementation NSString (Paths)

- (NSString*)stringWithPathRelativeTo:(NSString*)anchorPath {
    NSArray *pathComponents = [self pathComponents];
    NSArray *anchorComponents = [anchorPath pathComponents];
    
    NSInteger componentsInCommon = MIN([pathComponents count], [anchorComponents count]);
    for (NSInteger i = 0, n = componentsInCommon; i < n; i++) {
        if (![[pathComponents objectAtIndex:i] isEqualToString:[anchorComponents objectAtIndex:i]]) {
            componentsInCommon = i;
            break;
        }
    }
    
    NSUInteger numberOfParentComponents = [anchorComponents count] - componentsInCommon;
    NSUInteger numberOfPathComponents = [pathComponents count] - componentsInCommon;
    
    NSMutableArray *relativeComponents = [NSMutableArray arrayWithCapacity:
                                          numberOfParentComponents + numberOfPathComponents];
    for (NSInteger i = 0; i < numberOfParentComponents; i++) {
        [relativeComponents addObject:@".."];
    }
    [relativeComponents addObjectsFromArray:
     [pathComponents subarrayWithRange:NSMakeRange(componentsInCommon, numberOfPathComponents)]];
    return [NSString pathWithComponents:relativeComponents];
}

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
                NSString * path = [document.path stringWithPathRelativeTo:[[NSFileManager defaultManager] currentDirectoryPath]];
                if ([self.delegate respondsToSelector:@selector(imageChanged:image:path:)]) {
                    [self.delegate imageChanged:self image:image path:path];
                }
                [self setFile:path];
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
