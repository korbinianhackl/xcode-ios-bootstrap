//
//  MD5Helper.h
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 1/11/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface MD5 : NSObject

//generates md5 hash from a string
+ (NSString *) returnMD5Hash:(NSString*)concat;

@end
