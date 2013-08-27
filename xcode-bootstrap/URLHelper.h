//
//  URLHelper.h
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 4/30/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject

+ (NSURL *) getUrlToRessourceType:(NSString *) type withParams:(NSMutableArray *) params;

@end
