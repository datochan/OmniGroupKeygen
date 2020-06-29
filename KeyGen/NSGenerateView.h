//
//  NSGenerateView.h
//  KeyGen
//
//  Created by datochan on 2020/6/19.
//  Copyright © 2020 datochan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <x86intrin.h>
NS_ASSUME_NONNULL_BEGIN

typedef struct  {
    long vals[5];
} app_const_item;

@interface NSGenerateView : NSView
@property (weak) IBOutlet NSPopUpButton *btnAppBtn;
@property (strong) IBOutlet NSTextField *tipField;
@property (strong) IBOutlet NSTextField *userNameField;
@property (strong) IBOutlet NSTextField *licenceField;
- (IBAction)click:(NSButton *)sender;
- (NSString*) createSerial:(NSString*)name withAppIdx:(NSInteger)nApp;
@end

NS_ASSUME_NONNULL_END
