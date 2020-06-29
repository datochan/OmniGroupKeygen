//
//  AppDelegate.m
//  KeyGen
//
//  Created by datochan on 2020/6/19.
//  Copyright © 2020 datochan. All rights reserved.
//

#import "AppDelegate.h"
#import "NSGenerateView.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) NSGenerateView *generateView;
@property (nonatomic,strong) AVMIDIPlayer *player;

- (void)closeWindow;
@end

@implementation AppDelegate

-(AVMIDIPlayer *)player{
    if (!_player) {
        // 1.创建音乐路径
        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"tbs" ofType:@"mid"];
        NSURL *musicURL = [[NSURL alloc]initFileURLWithPath:musicFilePath];
        
        // 2.创建播放器
        _player = [[AVMIDIPlayer alloc] initWithContentsOfURL:musicURL soundBankURL:nil error:nil];
    }
    
    return _player;
}

- (void)playMidi {
    if (self.player.isPlaying) {
        return;
    }
    
    [self.player prepareToPlay];
    self.player.currentPosition = 0;
    [self.player play: ^() {[self playMidi];}];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //注册窗口关闭消息，关闭窗口就退出应用
    self.generateView = [[NSGenerateView alloc] initWithFrame:self.window.contentView.bounds];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeWindow)name:NSWindowWillCloseNotification object:self.window];
    
    [self playMidi];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)closeWindow {
    [[NSApplication sharedApplication] terminate:nil];//退出app

}

@end
