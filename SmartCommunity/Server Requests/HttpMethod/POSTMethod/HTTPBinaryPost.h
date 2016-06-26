//
//  HTTPBinaryPost.h
//  frewitt
//
//  Created by CicoDorro on 04.03.10.
//  Copyright 2010 SmartSecure. All rights reserved.
//

@interface HTTPBinaryPost : NSObject

@property (nonatomic, strong) NSMutableURLRequest *urlRequest;
@property (nonatomic, strong) NSURLConnection *urlConnection;

+ (HTTPBinaryPost *)HTTPBinaryPostForApiServiceURL:(NSURL *)apiURL;

- (HTTPBinaryPost *)initForApiServiceURL:(NSURL *)apiURL;
- (void)postBinaryDatas:(NSDictionary *)binaryDatas andTextDatas:(NSDictionary *)textDatas delegate:(id)delegate;
- (void)cancel;

@end