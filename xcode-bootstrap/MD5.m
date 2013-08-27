//
//  MD5Helper.m
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 1/11/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import "MD5.h"

@implementation MD5

//generate md5 hash from string
+ (NSString *) returnMD5Hash:(NSString*)concat {
    const char *concat_str = [concat UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
}

@end
