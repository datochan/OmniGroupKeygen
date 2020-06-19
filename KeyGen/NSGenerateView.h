//
//  NSGenerateView.h
//  KeyGen
//
//  Created by datochan on 2020/6/19.
//  Copyright © 2020 datochan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSGenerateView : NSView
@property (weak) IBOutlet NSTextField *txtUserName;
@property (weak) IBOutlet NSTextView *txtLicense;
- (IBAction)click:(NSButton *)sender;

@end

NS_ASSUME_NONNULL_END
