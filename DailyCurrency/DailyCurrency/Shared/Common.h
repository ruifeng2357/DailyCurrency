//
//  Common.h
//  zhuanqian
//
//  Created by KHM on 4/24/14.
//  Copyright (c) 2014 DMY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "Reachability.h"


#define MOVE_FROM_LEFT(ctrl) { \
								CATransition *animation = [CATransition animation]; \
								[animation setDuration:0.3]; \
								[animation setType:kCATransitionPush]; \
								[animation setSubtype:kCATransitionFromLeft]; \
								[animation setTimingFunction:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]]; \
								[[ctrl.view.superview layer] addAnimation:animation forKey:@"SwitchToView"];

#define MOVE_FROM_RIGHT(ctrl) { \
								CATransition *animation = [CATransition animation]; \
								[animation setDuration:0.3]; \
								[animation setType:kCATransitionPush]; \
								[animation setSubtype:kCATransitionFromRight]; \
								[animation setTimingFunction:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]]; \
								[[ctrl.view.superview layer] addAnimation:animation forKey:@"SwitchToView"];

#define SHOW_VIEW_FROM_LEFT(srcctrl, dstctrl) MOVE_FROM_LEFT(srcctrl) \
								[srcctrl presentViewController:dstctrl animated:NO completion:nil]; }

#define SHOW_VIEW_FROM_RIGHT(srcctrl, dstctrl) MOVE_FROM_RIGHT(srcctrl) \
								[srcctrl presentViewController:dstctrl animated:NO completion:nil]; }

#define BACK_VIEW_TO_LEFT(srcctrl) MOVE_FROM_RIGHT(srcctrl) \
								[srcctrl dismissViewControllerAnimated:NO completion:nil]; }

#define BACK_VIEW_TO_RIGHT(srcctrl) MOVE_FROM_LEFT(srcctrl) \
								[srcctrl dismissViewControllerAnimated:NO completion:nil]; }

enum DeviceType
{
	DEVICE_TYPE_UNKNOWN,
	DEVICE_TYPE_IPAD,
	DEVICE_TYPE_IPHONE4,
	DEVICE_TYPE_IPHONE5,
};

enum NetworkType
{
	NETWORK_TYPE_NONE,
	NETWORK_TYPE_CELULAR,
	NETWORK_TYPE_WIFI,
};



@interface Common : NSObject {
}

+ (Common*)sharedInstance;

+ (float)getSystemVersion;
+ (enum DeviceType) getDeviceType;
+ (int)getScreenWidth;
+ (int)getScreenHeight;

+ (enum NetworkType)getConnectionType;
+ (NSString*)getIPAddress;
+ (NSString*)getDeviceIDForVendor;


+ (int)getIntValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (long)getLongValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (NSString*)getStringValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (double)getDoubleValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (float)getFloatValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;

@end


