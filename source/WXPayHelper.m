#import "WXPayHelper.h"

@implementation WXPayHelper {

}
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]
                addObserver:self
                   selector:@selector(handleUrl:)
                       name:@"applicationOpenUrl"
                     object:nil];
    }
    return self;
}

- (void)handleUrl:(NSNotification *)notification {
    [WXApi handleOpenURL:notification.object delegate:self];
}

- (void)startPay:(NSString *)app_id data:(NSString *)data {
    [WXApi registerApp:app_id];
    id json = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    PayReq *request = [[PayReq alloc] init];
    request.openID = json[@"appid"];
    request.partnerId = json[@"partnerid"];
    request.prepayId = json[@"prepayid"];
    request.nonceStr = json[@"noncestr"];
    request.timeStamp = (UInt32)json[@"timestamp"];
    request.package = json[@"package"];
    request.sign = json[@"sign"];

    [WXApi sendReq:request];
}

- (void)onReq:(BaseReq *)req {

}

- (void)onResp:(BaseResp *)resp {

}

@end