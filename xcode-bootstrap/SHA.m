//
//  SHA.m
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 4/25/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import "SHA.h"

@implementation SHA

+ (NSData *) sha256:(NSString *)clear {
    
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    /*NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;*/
    
    return out;
    
}

@end
