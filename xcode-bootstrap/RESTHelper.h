//
//  RESTHelper.h
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 4/16/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import <Foundation/Foundation.h>

// TODO: include asihttprequest framework
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"

@interface RESTHelper : NSObject {

    BOOL ignoreSessionToken;
}

// TEST

+ (ASIHTTPRequest *) getRequestWithUrl:(NSURL *) url andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag;

+ (ASIHTTPRequest *) postRequestWithUrl:(NSURL *) url andData:(NSString *) data andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag;

+ (ASIHTTPRequest *) putRequestWithUrl:(NSURL *) url andData:(NSString *) data andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag;

+ (ASIHTTPRequest *) deleteRequestWithUrl:(NSURL *) url andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag;


+ (ASIHTTPRequest *) getRequestIgnoreSessionTokenWithUrl:(NSURL *) url andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag;

+ (ASIHTTPRequest *) putRequestIgnoreSessionTokenWithUrl:(NSURL *) url andData:(NSString *) data andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag;

// helper methods
+ (ASIHTTPRequest *) getStandardRequestWithUrl:(NSURL *) url andDelegate:(id) delegate andCheckLoginStatus: (BOOL) checkLoginStatus andTag:(int) tag;

@end
