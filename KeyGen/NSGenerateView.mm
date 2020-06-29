/*
 *
 *  NSGenerateView.m
 *  KeyGen
 *
 *  Created by datochan on 2020/6/19.
 *  Copyright © 2020 datochan. All rights reserved.
 *
 */

#import "NSGenerateView.h"
#import <CommonCrypto/CommonDigest.h>

uint32_t xmmword_4ED0 = 0x0C080400;
long appID[8] = { 1000205, 1000216, 1000215, 1000200, 1000211, 1000210, 1000219, 1000220 };
app_const_item appConst[8] = {
    { { 2166349967, 3516606518,    3340673861,  3888010930,    3917387330  } },
    { { 3897956573, 3851341696,    3149004735,  1472226105,    3050433222  } },
    { { 3841106624, 973072845,     3682144089,  1755785687,    373844180   } },
    { { 2839155968, 1845824791,    2907975541,  3840242358,    1976016107  } },
    { { 116552378,  1263373209,    181212998,   2290278625,    3084396539  } },
    { { 1267193479, 1420167569,    1218504242,  243197170,     2803342978  } },
    { { 1559023413, 3388057537,    2518807587,  3764430787,    396685095   } },
    { { 1012020148, 3339835935,    446837266,   1073311664,    1812727945  } }
};
long appFlag[] = { 2, 4, 6, 7 };

@interface NSData (Ascii)
- (NSString *)ascii26String;

@end

@implementation NSData (Ascii)
- (NSString *)ascii26String
{
    NSString *result = @"";
    NSString *tmpResult = @"";
    const unsigned char *lpData = (const unsigned char *)self.bytes;
    long v9 = 0;
    unsigned char *v8 = NULL;
    char *v10 = NULL;
    char v11 = 0;
    char v22[8] = { 0 };
    unsigned char v24[7] = { 0 };
    NSUInteger dataLen = self.length;
 LABEL_2:
    unsigned int v4 = 0;
    long *lpAppFlag = &appConst[7].vals[4];
    long appFlagItem = 0;
    int idx = 0;
    while (dataLen != idx) {
        v4 = lpData[idx++] | (v4 << 8);
        ++lpAppFlag;
        if (idx == 4) {
            tmpResult = result;
            memset(v24, 0, 7);
            appFlagItem = *lpAppFlag;
            lpData += 4;
            dataLen -= 4;
            v8 = v24;
            v9 = appFlagItem;
            do {
                --v9;
                *v8 = v4 % 26u;
                v8 += 1;
                v4 /= 26u;
            } while (v9);
            v10 = v22;
            do {
                v11 = *(&v24[0] - 1 + appFlagItem--);
                *v10++ = v11 + 65;
            } while (appFlagItem);
            result = [tmpResult stringByAppendingString:[NSString stringWithUTF8String:(const char *)v22]];
            goto LABEL_2;
        }
    }
    if (idx) {
        tmpResult = result;
        v8 = v24;
        memset(v24, 0, 7);
        appFlagItem = *lpAppFlag;
        v9 = appFlagItem;
        do {
            --v9;
            *v8 = v4 % 26u;
            v8 += 1;
            v4 /= 26u;
        } while (v9);
        v10 = v22;
        do {
            v11 = *(&v24[0] - 1 + appFlagItem--);
            *v10++ = v11 + 65;
        } while (appFlagItem);
        result = [tmpResult stringByAppendingString:[NSString stringWithUTF8String:(const char *)v22]];
    }

    return(result);
}

@end

@implementation NSGenerateView
- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];

    return(self);
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

- (NSString *)createSerial:(NSString *)name withAppIdx:(NSInteger)nApp
{
    NSLog(@"用户名为:%@, 应用序号为: %ld", name, nApp);
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    NSCharacterSet *charset = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *finalName = [[name componentsSeparatedByCharactersInSet:charset] componentsJoinedByString:@""];
    NSInteger finalNameLength = [finalName length];
    int v9 = -4;
    uint8_t content[13] = { 0 };
    do {
        content[v9 + 9] = arc4random();
        content[v9 + 13] = -1;
    } while (v9++);
    NSData *v10 = [NSData dataWithBytes:&content[5] length:8];
    
    NSString *v11 = [v10 ascii26String];

    NSString *v12 = [v11 substringWithRange:NSMakeRange(0, 4)];
    NSString *v13 = [v11 substringWithRange:NSMakeRange(4, 4)];
    NSString *v14 = [v11 substringWithRange:NSMakeRange(8, 4)];
    NSString *v15 = [v11 substringWithRange:NSMakeRange(12, 2)];
    NSString *v16 = [NSString stringWithFormat:@"%@-%@-%@-%@", v12, v13, v14, v15];
    NSString *v17 = [NSString stringWithFormat:@"%lu%@%@", appID[nApp], v16, finalName];

//    NSString *v17 = [NSString stringWithUTF8String:"1000220JNMM-OEIN-XMRL-XVdatochan"];
    NSData *v20 = [NSData dataWithBytes:[v17 UTF8String] length:[v17 length]];
    CC_SHA1([v20 bytes], (CC_LONG)[v20 length], digest);
    app_const_item *v23 = &appConst[nApp];
    NSInteger idx = 0;
    __m128i v25 = _mm_load_si128( (const __m128i *)&xmmword_4ED0);
    do {
        *(uint32_t *)&digest[idx * 4] = _mm_cvtsi128_si32(
            _mm_shuffle_epi8(
                _mm_xor_si128(
                    _mm_unpacklo_epi16(
                        _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(uint32_t *)&digest[idx * 4]), v25),
                        v25),
                    _mm_unpacklo_epi16(
                        _mm_unpacklo_epi8(_mm_cvtsi32_si128( (int)v23->vals[idx]), v25),
                        v25) ),
                v25) );
        ++idx;
    } while (idx != 5);

    idx = -5;
    do {
        digest[idx + 5] = digest[idx + 5] ^ digest[idx + 20] ^ digest[idx + 15] ^ digest[idx + 10];
        ++idx;
    } while (idx);

    content[4] = digest[4];
    *(unsigned int *)content = *(unsigned int *)digest;

    if (finalNameLength) {
        idx = 0;
        do {
            content[idx] = ~(content[idx] ^ [finalName characterAtIndex:idx % finalNameLength]);
            ++idx;
        } while (idx != 13);
    }

    NSData *v33 = [NSData dataWithBytes:content length:13];
    NSString *v34 = [v33 ascii26String];
    NSString *v36 = [v34 substringWithRange:NSMakeRange(0, 4)];
    NSString *v37 = [v34 substringWithRange:NSMakeRange(4, 4)];
    NSString *v38 = [v34 substringWithRange:NSMakeRange(8, 4)];
    NSString *v39 = [v34 substringWithRange:NSMakeRange(12, 4)];
    NSString *v40 = [v34 substringWithRange:NSMakeRange(16, 4)];
    NSString *v41 = [v34 substringWithRange:NSMakeRange(20, 4)];
    NSString *v42 = [v34 substringWithRange:NSMakeRange(24, 3)];

    return [NSString stringWithFormat:@"%@-%@-%@-%@-%@-%@-%@", v36, v37, v38, v39, v40, v41, v42];
}

- (IBAction)click:(NSButton *)sender
{
    if ( 1 == sender.tag ) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://www.52pojie.cn/"]];
        return;
    }

    self.tipField.stringValue = @"";
    if ( [self.userNameField.stringValue length] <= 0 ) {
        self.tipField.stringValue = @"UserName can not be empty.";
        return;
    }

    // 添加生成序列号的代码
    NSString *serial = [self createSerial:self.userNameField.stringValue withAppIdx:self.btnAppBtn.selectedTag];
    self.licenceField.stringValue = serial;
}

@end
