//
//  SHA.h
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 4/25/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHA : NSObject

+ (NSData *) sha256:(NSString *)clear;

@end
