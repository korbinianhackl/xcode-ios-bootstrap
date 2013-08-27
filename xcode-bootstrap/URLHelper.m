//
//  URLHelper.m
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 4/30/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import "URLHelper.h"

@implementation URLHelper


+ (NSURL *) getUrlToRessourceType:(NSString *) type withParams:(NSMutableArray *) params {
    
    NSString *paramString = @"";

    if (params != nil) {
        for (int i = 0; i < [params count]; i++) {
            NSLog(@"param %i: %@", i, [params objectAtIndex:i]);
            paramString = [paramString stringByAppendingString:[NSString stringWithFormat:@"/%@", [params objectAtIndex:i]]];
        }
    }
    
    // TODO: DELETE
   /* if ([type isEqualToString:MESSAGE_RESSOURCE]) {
        type = [[NSString stringWithString:@"test/"] stringByAppendingString:type];
    }*/
    
// TODO: include API_URL in constants
//    NSLog(@">>>>>>>>>>>>>URL: %@", [NSString stringWithFormat:@"%@%@%@", API_URL, type, paramString]);
//    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", API_URL, type, paramString]];
    return nil;
}

@end
