	//
//  CommManager.m
//  zhuanqian
//
//  Created by KHM on 4/24/14.
//  Copyright (c) 2014 DMY. All rights reserved.
//

#import "CommManager.h"
#import <netinet/in.h>
#import "Reachability.h"
#import "AfNetworking.h"
#import "SBJson.h"
#import "Common.h"
#import "Base64.h"

#define SERVICE_TIMEOUT_SECONDS		10
//#define SERVICE_URL					@"http://sypic.oicp.net:10211/Service.svc/"
#define SERVICE_URL					@"http://218.25.54.28:10160/Service.svc/"

static CommManager *_sharedCommManager = nil;

@implementation CommManager

@synthesize delegate;


+ (CommManager*)getCommMgr:(id<CommDelegate>)delegate
{
	if (_sharedCommManager == nil)
		_sharedCommManager = [[CommManager alloc] init];
	_sharedCommManager.delegate = delegate;
	
	return _sharedCommManager;
}
- (id)init
{
	self = [super init];
	return self;
}

+ (BOOL)isAlive
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;

	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);

	if(reachability != NULL)
	{
		SCNetworkReachabilityFlags flags;
		if (SCNetworkReachabilityGetFlags(reachability, &flags))
		{
			if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
			{
				return NO;
			}

			if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
			{
				return YES;
			}

			if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
				 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
			{
				if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
				{
					return YES;
				}
			}

			if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
			{
				return YES;
			}
		}
	}

	return NO;
}

- (BOOL)getDailyCurrencyData
{
	BOOL result = YES;

	if (delegate == nil)
	{
		result = NO;
	}
	else
	{
		if (![CommManager isAlive])
		{
			[delegate getDailyCurrencyDataResult:CONN_ERROR_CODE message:CONN_ERROR_DESC retdata:nil];
			result = NO;
		}
		else
		{
			AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
			httpClient.parameterEncoding = AFJSONParameterEncoding;

			[httpClient getPath:@"GetCurrencyData" parameters:nil success:^(AFHTTPRequestOperation* operation, id responseObject)
			{
				NSDictionary* retData = nil;
				NSError* error = nil;
				NSString* responseStr = nil;

				int nRetCode = 0;
				NSString* szMsg = @"";

				responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

				retData = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error:&error];

				nRetCode = [[retData objectForKey:@"RETVAL"] intValue];
				szMsg = [retData objectForKey:@"BASEURL"];

				if (nRetCode == 0)
				{
					NSDictionary* dataDict = [retData objectForKey:@"RETDATA"];
					[delegate getDailyCurrencyDataResult:nRetCode message:szMsg retdata:dataDict];
				}
				else
				{
					[delegate getDailyCurrencyDataResult:nRetCode message:CONN_ERROR_SERVER retdata:nil];
				}

			} failure:^(AFHTTPRequestOperation* operation, NSError* error) {
				NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
				[delegate getDailyCurrencyDataResult:CONN_ERROR_CODE message:CONN_ERROR_SERVER retdata:nil];
			}];
		}
	}

	return result;
}

@end



