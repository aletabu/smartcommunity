//
//  HTTPBinaryPost.m
//  frewitt
//
//  Created by CicoDorro on 04.03.10.
//  Copyright 2010 SmartSecure. All rights reserved.
//

#import "HTTPBinaryPost.h"

static NSString *const kBoundary = @"LyOoOoOoBaKaStoRsBoUnDaRy";

@implementation HTTPBinaryPost

@synthesize urlRequest = _urlRequest, urlConnection = _urlConnection;

+ (HTTPBinaryPost *)HTTPBinaryPostForApiServiceURL:(NSURL *)apiURL {
	return [[HTTPBinaryPost alloc] initForApiServiceURL:apiURL];
}

- (HTTPBinaryPost *)initForApiServiceURL:(NSURL *)apiURL {
	if (self = [super init]) {
		self.urlRequest = [NSMutableURLRequest requestWithURL:apiURL];
		[_urlRequest setHTTPMethod:@"POST"];
		[_urlRequest addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBoundary] forHTTPHeaderField:@"Content-Type"];
	}

	return self;
}

- (void)postBinaryDatas:(NSDictionary *)binaryDatas andTextDatas:(NSDictionary *)textDatas delegate:(id)delegate {
    [_urlConnection cancel];
    
	NSMutableData *body = [NSMutableData data];
	
	for (NSString *name in textDatas) {
		[body appendData:[[NSString stringWithFormat:@"--%@\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", name] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[textDatas objectForKey:name] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	}

	for (NSString *name in binaryDatas) {
             
		[body appendData:[[NSString stringWithFormat:@"--%@\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"form[file]"
                           , [[binaryDatas objectForKey:name] objectForKey:@"filename"]] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", [[binaryDatas objectForKey:name] objectForKey:@"contentType"]] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[binaryDatas objectForKey:name] objectForKey:@"form[file]"]];
	}
	
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
	[_urlRequest setHTTPBody:body];

	self.urlConnection = [NSURLConnection connectionWithRequest:_urlRequest delegate:delegate];
}

- (void)cancel {
    [_urlConnection cancel];
}

@end