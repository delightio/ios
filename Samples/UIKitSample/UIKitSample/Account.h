//
//  Account.h
//  UIKitSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;

+ (id)accountWithName:(NSString *)name email:(NSString *)email password:(NSString *)password;
- (id)initWithName:(NSString *)name email:(NSString *)email password:(NSString *)password;

@end