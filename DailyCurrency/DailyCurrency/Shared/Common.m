//
//  Common.m
//  zhuanqian
//
//  Created by KHM on 4/24/14.
//  Copyright (c) 2014 DMY. All rights reserved.
//

#import "Common.h"

// Instance for global values
static Common* gSharedInst = nil;

// Device Type variable
static int gDeviceType = -1;


// Common class implementation
@implementation Common

+ (Common*)sharedInstance
{
	@synchronized(gSharedInst)
	{
		if (gSharedInst == nil)
		{
			gSharedInst = [Common new];
		}

		return gSharedInst;
	}
}


+ (float)getSystemVersion
{
	return [[[UIDevice currentDevice] systemVersion] floatValue];
}


+ (enum DeviceType) getDeviceType
{
	if (gDeviceType == -1)
	{
		if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
		{
			if ([self getScreenHeight] == 568)
				gDeviceType = DEVICE_TYPE_IPHONE5;
			else
				gDeviceType = DEVICE_TYPE_IPHONE4;
		}
		else
			gDeviceType = DEVICE_TYPE_IPAD;
	}
	
	return gDeviceType;
}

+ (int)getScreenWidth
{
	return [UIScreen mainScreen].bounds.size.width;
}

+ (int)getScreenHeight
{
	return [UIScreen mainScreen].bounds.size.height;
}

+ (int)fround:(float)fValue
{
	return (int)(fValue + 0.5f);
}


#pragma mark Methods for save/load user information

+ (enum NetworkType)getConnectionType
{
	enum NetworkType connType = NETWORK_TYPE_NONE;

	Reachability* reachability = [Reachability reachabilityForInternetConnection];
	[reachability startNotifier];

	NetworkStatus status = [reachability currentReachabilityStatus];
	if (status == ReachableViaWiFi)
	{
		connType = NETWORK_TYPE_WIFI;
	}
	else if (status == ReachableViaWWAN)
	{
		connType = NETWORK_TYPE_CELULAR;
	}

	return connType;
}

+ (NSString*)getIPAddress
{
	NSString* address = @"3G/4G";
	if ([Common getConnectionType] == NETWORK_TYPE_CELULAR)
		return address;

	struct ifaddrs* interfaces = nil;
	struct ifaddrs* temp_addr = nil;

	int success = 0;

	success = getifaddrs(&interfaces);
	if (success == 0) {
		temp_addr = interfaces;

		while (temp_addr != nil)
		{
			if (temp_addr->ifa_addr->sa_family == AF_INET) {
				if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
					address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in*)temp_addr->ifa_addr)->sin_addr)];
				}
			}

			temp_addr = temp_addr->ifa_next;
		}
	}

	freeifaddrs(interfaces);
	return address;
}


+ (int)getIntValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	long value = [Common getLongValueWithKey:key Dict:dict];
	return (int)value;
}

+ (long)getLongValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	id objValue = [dict objectForKey:key];
	if (objValue == nil)
		return 0;

	return (long)[objValue longLongValue];
}

+ (NSString*)getStringValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	id objValue = [dict objectForKey:key];
	if (objValue == nil)
		return @"";

	return (NSString*)objValue;
}

+ (double)getDoubleValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	id objValue = [dict objectForKey:key];
	if (objValue == nil)
		return 0;

	return [objValue doubleValue];
}

+ (float)getFloatValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	id objValue = [dict objectForKey:key];
	if (objValue == nil)
		return 0;

	return [objValue floatValue];
}

+ (NSString*)getCurTime
{
	NSDate* date = [NSDate date];
	NSDateFormatter* dtFormatter = [[NSDateFormatter alloc] init];
	[dtFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	return [dtFormatter stringFromDate:date];
}

+ (BOOL)validatePhone:(NSString*)phoneNum
{
	NSString* phoneRegx = @"^[0-9]{6,14}$";
	NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegx];

	return [phoneTest evaluateWithObject:phoneNum];
}

+ (BOOL)isAppInstalled:(NSString*)urlscheme
{
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlscheme]];
}

+ (float)genRandFloat
{
	return (arc4random() % 1000) / 999.f;
}

+ (int)getCurTimeTick
{
	long tick = [[NSDate date] timeIntervalSince1970];
	return tick % 1000;
}


+ (NSString*)getDeviceIDForVendor
{
	return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

@end

