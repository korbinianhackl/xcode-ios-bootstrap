//
//  JsonParser.h
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 4/13/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
//#import "NSObject+Properties.h"
//#import "NSString+PropertyKVC.h"
#import <objc/runtime.h>

@interface JsonHelper : NSObject


+ (id) parseJsonIntoRessource: (NSData *) json;
+ (id) parseDictIntoRessource:(NSDictionary *) dict;

+ (NSString *) parseRessourceIntoJson:(id) ressource;
+ (NSDictionary *) parseChildRessourceIntoJson:(id) ressource;



@end
