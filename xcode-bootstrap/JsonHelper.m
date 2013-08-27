//
//  JsonParser.m
//  xcode-bootstrap
//
//  Created by Korbinian Hackl on 4/13/12.
//  Copyright (c) 2012 appropo. All rights reserved.
//

#import "JsonHelper.h"
#import "objc/runtime.h"


@implementation JsonHelper


//Parse a Json String into a Ressource with converting it into a dictionary and calling parseDictIntoRessource
+ (id) parseJsonIntoRessource: (NSData *) json {
    
    // parse json into nsdict
    NSError* error;
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"parsing Error: %@ %@", error, [error userInfo]);
    
    id ressource = [self parseDictIntoRessource:dict];

    return ressource;
    
}

//Parse a Dict into a Ressource by checking the ressource type with the root key. works recursiv with child-ressources. checks multiple ressourses
+ (id) parseDictIntoRessource:(NSDictionary *) dict {

    // defining variables
    id ressource;
    int loops = 1;
    NSMutableArray *mutableContainer;
    
    // access one rootKey
    for (id rootKey in dict) {
        
        NSLog(@"Parse Dict into Ressource %@", rootKey);
        //NSLog(@"Show Dict: %@", dict);
        
        // check for multiple ressource and init container and set loop counter to array count
        if ([[dict objectForKey:rootKey] isKindOfClass:[NSArray class]]) {
            mutableContainer = [[NSMutableArray alloc] init];
            loops = [[dict objectForKey:rootKey] count];
            NSLog(@"Multiple Ressource with %i Elements", loops);
        }
        
        
        // one loop for non multiple ressources, multiple loops for multiple ressourses
        for (int i = 0; i < loops; i++) {
            
            NSDictionary *dictToLoop;
            
            // set dictionary with values either as value of rootkey or iterating over the array within rootkey
            if (mutableContainer != nil) {
                dictToLoop = [[dict objectForKey:rootKey] objectAtIndex:i];
            } else {
                dictToLoop = [dict objectForKey:rootKey];
            }
            
            //NSLog(@"dict to loop %@", dictToLoop);
            
            // get ressource from rootkey
            ressource = [self getRessourceFromRessourceString:rootKey];

            // check if a ressource could be found
            if (ressource) {
                for (id key in dictToLoop) {
                    // check if a child ressource within the parent ressource exists and ressource for key exists, else it is parsed to a nsdict into parent ressource
                    if (([[dictToLoop objectForKey:key] isKindOfClass:[NSDictionary class]] || [[dictToLoop objectForKey:key] isKindOfClass:[NSMutableArray class]])  && [self getRessourceFromRessourceString:rootKey] != nil) {
                        NSLog(@"Parse Child Dict into Ressource %@", key);
                        // recursiv child ressource parsing
                        
                        id res = [self parseDictIntoRessource:[NSDictionary dictionaryWithObject:[dictToLoop objectForKey:key] forKey:key]];
                        
                        [ressource setValue:res forKey:key];
                        
                    } else {
                        // TODO: DELETE
                        if ([[dictToLoop objectForKey:key] isKindOfClass:[NSDictionary class]]) {
                            NSLog(@"NSDict Attr: %@", [dictToLoop objectForKey:key]);
                        }
                        
                        // catch errors if key in ressource is not found
                        @try {
                            if ([dictToLoop objectForKey:key] != nil) {
                                
                                [ressource setValue:[dictToLoop objectForKey:key] forKey:key];
                                
                            }
                        }
                        @catch (NSException *exception) {
                            // TODO: Error Handling
                            //ressource = [[ErrorModel alloc] init];
                            NSLog(@"Exception for key %@ : %@", key, exception);
                        }
                    }
                    
                    
                }
            }
            
            // if multiple ressource add to container
            if (mutableContainer != nil) {
                [mutableContainer addObject:ressource];
            }
        }

    }
    
    // return either the container or a single ressource depending on single/multiple ressource
    if (mutableContainer != nil) {
        return mutableContainer;
    } else {
        return ressource;
    }
}

// parses a ressource back to a json string by getting all keys of the ressource as string
+ (NSString *) parseRessourceIntoJson:(id) ressource {

    Class klass = [ressource class];
    
    if (klass == NULL) {
        return nil;
    }
    
    // get ressource String
    NSString *ressourceString = [self getRessourceStringFromRessource:ressource];
    
    NSMutableDictionary *keys = [[NSMutableDictionary alloc] init];
                                    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [keys setObject:propertyType forKey:propertyName];
        }
    }
    
    free(properties);
    
    
    //NSLog(@"results: %@", keys);
    
    // returning a copy here to make sure the dictionary is immutable
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    
    for (id key in keys) {
        if ([ressource valueForKey:key] != nil) {
            
            // check if a ressource exists for key name
            if ([self getRessourceFromRessourceString:key] != nil && [[ressource valueForKey:key] isKindOfClass:[[self getRessourceFromRessourceString:key] class]]) {
                
                // recursiv parsing a ressource into json
                
                // TODO: check if json can be directly parsed here
                [dict setObject:[self parseChildRessourceIntoJson:[ressource valueForKey:key]] forKey:key];
                
            } else {
                [dict setObject:[ressource valueForKey:key] forKey:key];
            }
            
            
            //[dict setObject:[ressource valueForKey:key] forKey:key];
        }

    }
    
    NSDictionary *dictToParse = [NSDictionary dictionaryWithObject:dict forKey:ressourceString];
    
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictToParse 
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    NSLog(@"Parsed Ressouce %@ into JsonData: %@", ressourceString, [[NSString alloc] initWithData:jsonData                                        
                                                  encoding:NSUTF8StringEncoding]);
    
    return [[NSString alloc] initWithData:jsonData                                        
                                            encoding:NSUTF8StringEncoding];
                                    
}

+ (NSDictionary *) parseChildRessourceIntoJson:(id) ressource {
    Class klass = [ressource class];
    
    if (klass == NULL) {
        return nil;
    }
    
    // get ressource String
    NSString *ressourceString = [self getRessourceStringFromRessource:ressource];
    
    NSMutableDictionary *keys = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [keys setObject:propertyType forKey:propertyName];
        }
    }
    
    free(properties);
    
    
    //NSLog(@"results: %@", keys);
    
    // returning a copy here to make sure the dictionary is immutable
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    
    for (id key in keys) {
        if ([ressource valueForKey:key] != nil) {
            
            // check if a ressource exists for key name
            if ([self getRessourceFromRessourceString:key] != nil && [[ressource valueForKey:key] isKindOfClass:[[self getRessourceFromRessourceString:key] class]]) {
                
                // recursiv parsing a ressource into json
                
                // TODO: check if json can be directly parsed here
                [dict setObject:[self parseChildRessourceIntoJson:[ressource valueForKey:key]] forKey:key];
                
            } else {
                [dict setObject:[ressource valueForKey:key] forKey:key];
            }
            
            
            //[dict setObject:[ressource valueForKey:key] forKey:key];
        }
        
    }
    
    return [[NSDictionary dictionaryWithObject:dict forKey:ressourceString] objectForKey:ressourceString];
}

// Helper Variable for Object Properties
static const char * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /* 
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.            
             */
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }        
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}

+ (NSString *) getRessourceStringFromRessource: (id) ressource {
    
    NSString *ressourceString;
//    if ([ressource isKindOfClass:[model class]]) {
//        ressourceString = @"article";
//    }
    
    return ressourceString;

}

+ (id) getRessourceFromRessourceString: (NSString *) rootKey {


    id ressource = nil;
    // Defining Ressources to parse
//    if ([rootKey isEqualToString:@"article"]) {
//        ressource = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext];
//        
//    }

    return ressource;
}

@end
