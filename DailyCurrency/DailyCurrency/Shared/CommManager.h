//
//  CommManager.h
//  zhuanqian
//
//  Created by KHM on 4/24/14.
//  Copyright (c) 2014 DMY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONN_ERROR_CODE			-9999
#define CONN_ERROR_DESC			@"No internet connection."
#define CONN_ERROR_SERVER		@"Server Internal Error"

@protocol CommDelegate;

@interface CommManager : NSObject {
	id<CommDelegate>		delegate;
}

@property(nonatomic, retain) id<CommDelegate>			delegate;

+ (CommManager*)getCommMgr:(id<CommDelegate>)delegate;
+ (BOOL)isAlive;

- (BOOL)getDailyCurrencyData;

@end


// Communication delegate
@protocol CommDelegate

- (void)getDailyCurrencyDataResult:(int)retcode message:(NSString*)msg retdata:(NSDictionary*)retdata;

@end

