//
//  NSGenerateView.m
//  KeyGen
//
//  Created by datochan on 2020/6/19.
//  Copyright © 2020 datochan. All rights reserved.
//

#import "NSGenerateView.h"

@implementation NSGenerateView
- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    [self.txtLicense setEditable:false];

    return self;
}

- (IBAction)click:(NSButton *)sender {
    if(1 == sender.tag) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://www.52pojie.cn/"]];
        return;
    }
    // 添加生成序列号的代码
}

@end
