//
//  AppDelegate.m
//  KeyGen
//
//  Created by datochan on 2020/6/19.
//  Copyright © 2020 datochan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
- (void)closeWindow;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //注册窗口关闭消息，关闭窗口就退出应用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeWindow)name:NSWindowWillCloseNotification object:self.window];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)closeWindow {
    [[NSApplication sharedApplication] terminate:nil];//退出app

}


@end
