//
//  RESTHelper.m
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 4/16/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import "RESTHelper.h"

@implementation RESTHelper

+ (ASIHTTPRequest *) getRequestWithUrl:(NSURL *) url andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag {

    ASIHTTPRequest *request = [self getStandardRequestWithUrl:url andDelegate:delegate andCheckLoginStatus:YES andTag:tag];
    
    if (start) {
        [request startAsynchronous];
    }
    
    return request;
}

+ (ASIHTTPRequest *) postRequestWithUrl:(NSURL *) url andData:(NSString *) data andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag {
    
    ASIHTTPRequest *request = [self getStandardRequestWithUrl:url andDelegate:delegate andCheckLoginStatus:YES andTag:tag];
    [request setRequestMethod:POST];
    [request appendPostData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (start) {
        [request startAsynchronous];
    }

    return request;
}

+ (ASIHTTPRequest *) putRequestWithUrl:(NSURL *) url andData:(NSString *) data andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag {
    
    ASIHTTPRequest *request = [self getStandardRequestWithUrl:url andDelegate:delegate andCheckLoginStatus:YES andTag:tag];
    [request setRequestMethod:PUT];
    [request appendPostData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (start) {
        [request startAsynchronous];
    }
    
    return request;
}

+ (ASIHTTPRequest *) deleteRequestWithUrl:(NSURL *) url andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag {
    
    ASIHTTPRequest *request = [self getStandardRequestWithUrl:url andDelegate:delegate andCheckLoginStatus:YES andTag:tag];
    [request setRequestMethod:DELETE];
    
    if (start) {
        [request startAsynchronous];
    }
    
    return request;
}


+ (ASIHTTPRequest *) getRequestIgnoreSessionTokenWithUrl:(NSURL *) url andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag {

    ASIHTTPRequest *request = [self getStandardRequestWithUrl:url andDelegate:delegate andCheckLoginStatus:NO andTag:tag];
    
    if (start) {
        [request startAsynchronous];
    }
    
    return request;
}

// method to ignore session token
+ (ASIHTTPRequest *) putRequestIgnoreSessionTokenWithUrl:(NSURL *) url andData:(NSString *) data andDelegate:(id) delegate andStartAsync:(BOOL) start andTag:(int) tag {
    
    ASIHTTPRequest *request = [self getStandardRequestWithUrl:url andDelegate:delegate andCheckLoginStatus:NO andTag:tag];
    [request setRequestMethod:PUT];
    [request appendPostData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (start) {
        [request startAsynchronous];
    }
    
    return request;
}

+ (ASIHTTPRequest *) getStandardRequestWithUrl:(NSURL *) url andDelegate:(id) delegate andCheckLoginStatus: (BOOL) checkLoginStatus andTag:(int) tag {

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:200];

    //check login status
    NSString *sessionToken;
    
    // add session token
    if (checkLoginStatus) {
        
        //TODO: better error handling
        sessionToken = [AuthHelper getSessionToken];
        
        if (sessionToken != nil) {
            [request addRequestHeader:SESSION_TOKEN_KEY value:sessionToken];
        //    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>> MEIN SESSTION TOKEN: %@", [[NSString alloc] initWithData:[Base64 decode:sessionToken] encoding:NSUTF8StringEncoding]);
        }
        
    }
    
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCachePolicy:ASIDoNotReadFromCacheCachePolicy];
    [request setSecondsToCache:60*60*24*30]; // Cache for 30 days
    [request setDelegate:delegate];
    
    request.tag = tag;
    
    //[self setClientCerificateInRequest:request];
    //[request setClientCertificateIdentity:[self getClientCertificateIdentity]];
    [request setValidatesSecureCertificate:YES];
    
    return request;
}

+ (ASIFormDataRequest *) putRequestWithUrl:(NSURL *) url andImage:(UIImage *) image andData:(NSString *) data andDelegate:(id) delegate andStartAsync:(BOOL) start {
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] init];
    //[request setm
    
}

+ (SecIdentityRef) getClientCertificateIdentity {
    
    /*SecIdentityRef identity = NULL;
    SecTrustRef trust = NULL;
    NSData *PKCS12Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bliphead_dev" ofType:@"p12"]];
    [RESTHelper extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data]; */
    
    SecIdentityRef identity = NULL;
    SecTrustRef trust = NULL;
    
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"bliphead_dev" ofType:@"p12"]; 
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath]; 
    CFDataRef inPKCS12Data = (__bridge_retained CFDataRef)PKCS12Data; 
    CFStringRef password = CFSTR("8lipheadPento$"); 
    const void *keys[] = { kSecImportExportPassphrase }; 
    const void *values[] = { password }; 
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL); 
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL); 
    OSStatus securityError = SecPKCS12Import(inPKCS12Data, optionsDictionary, &items); 
    
    if (securityError == 0) { 
		CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
		const void *tempIdentity = NULL;
		tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
		identity = (SecIdentityRef)tempIdentity;
		const void *tempTrust = NULL;
		tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
		trust = (SecTrustRef)tempTrust;
	} else {
		NSLog(@"Failed with error code %d",(int)securityError);

	}
    
    return identity;
    
    


}

/*
+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
	OSStatus securityError = errSecSuccess;
    
	NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"" forKey:(__bridge id)kSecImportExportPassphrase];
    
	CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
	securityError = SecPKCS12Import((__bridge_retained CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
	if (securityError == 0) { 
		CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
		const void *tempIdentity = NULL;
		tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
		*outIdentity = (SecIdentityRef)tempIdentity;
		const void *tempTrust = NULL;
		tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
		*outTrust = (SecTrustRef)tempTrust;
	} else {
		NSLog(@"Failed with error code %d",(int)securityError);
		return NO;
	}
	return YES;
}*/

@end
