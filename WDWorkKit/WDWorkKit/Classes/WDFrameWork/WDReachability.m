//
//  WDReachability.m
//  WDFrameWork
//
//  Created by Blake on 15/3/12.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import "WDReachability.h"
#import "Reachability.h"
#import <net/if.h>
#import <arpa/inet.h>
#import <ifaddrs.h>

#define ReachabilityLog_i(fmt,...) NSLog(INFO_NEW_FMT(fmt),##__VA_ARGS__,nil)

@interface WDReachability()
{
    Reachability *	_reach;
}

- (BOOL)isReachable;
- (BOOL)isReachableViaWIFI;
- (BOOL)isReachableViaWLAN;

- (void)networkReachabilityChanged:(NSNotification* )indicator;

@end


@implementation WDReachability

+ (WDReachability *)sharedInstance
{
    static WDReachability *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WDReachability alloc] init];
        
    });
    return _instance;
}


- (id)init
{
    self = [super init];
    if ( self )
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(networkReachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        _reach = [Reachability reachabilityForInternetConnection];
        [_reach startNotifier];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (BOOL)isReachable
{
    return [[WDReachability sharedInstance] isReachable];
}

- (BOOL)isReachable
{
    return [_reach isReachable];
}

+ (BOOL)isReachableViaWIFI
{
    return [[WDReachability sharedInstance] isReachableViaWIFI];
}

- (BOOL)isReachableViaWIFI
{
    if ( NO == [_reach isReachable] )
    {
        return NO;
    }
    
    return [_reach isReachableViaWiFi];
}

+ (BOOL)isReachableViaWLAN
{
    return [[WDReachability sharedInstance] isReachableViaWLAN];
}

- (BOOL)isReachableViaWLAN
{
    if ( NO == [_reach isReachable] )
    {
        return NO;
    }
    
    return [_reach isReachableViaWWAN];
}

+ (NSString *)localIP
{
    return [[WDReachability sharedInstance] localIP];
}

- (NSString *)localIP
{
    NSString *			ipAddr = nil;
    struct ifaddrs *	addrs = NULL;
    
    int ret = getifaddrs( &addrs );
    if ( 0 == ret )
    {
        const struct ifaddrs * cursor = addrs;
        
        while ( cursor )
        {
            if ( AF_INET == cursor->ifa_addr->sa_family && 0 == (cursor->ifa_flags & IFF_LOOPBACK) )
            {
                ipAddr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                break;
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs( addrs );
    }
    
    return ipAddr;
}
+ (NSString *)deviceIPAdress
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) {  // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            
            if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"] || [[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"])
            {
                //如果是IPV4地址，直接转化
                if (temp_addr->ifa_addr->sa_family == AF_INET){
                    
                    // Get NSString from C String
                    address = [self formatIPV4Address:((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr];
                }
                
                //如果是IPV6地址
                else if (temp_addr->ifa_addr->sa_family == AF_INET6){
                    address = [self formatIPV6Address:((struct sockaddr_in6 *)temp_addr->ifa_addr)->sin6_addr];
                    if (address && ![address isEqualToString:@""] && ![address.uppercaseString hasPrefix:@"FE80"]) break;
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    //以FE80开始的地址是单播地址
    if (address && ![address isEqualToString:@""] && ![address.uppercaseString hasPrefix:@"FE80"]) {
        return address;
    } else {
        return @"127.0.0.1";
    }
}
- (void)networkReachabilityChanged:(NSNotification* )indicator
{
    Reachability* curReach = [indicator object];
    
    if (curReach && [curReach isKindOfClass:[Reachability class]])
    {
//        ReachabilityLog_i(@"NetWork status changed to:%ld", [curReach currentReachabilityStatus]);
    }
}

/*!
 * 获取当前设备网关地址
 */
+ (NSString *)getGatewayIPAddress{
    NSString *address = nil;
    
    NSString *gatewayIPV4 = [[WDReachability sharedInstance] getGatewayIPV4Address];
    NSString *gatewayIPV6 = [[WDReachability sharedInstance] getGatewayIPV6Address];
    
    if (gatewayIPV6 != nil) {
        address = gatewayIPV6;
    } else {
        address = gatewayIPV4;
    }
    
    return address;
}
//ipv4网关地址
+ (NSString *)getGatewayIPV4Address
{
    
    
    NSString *address = nil;
    
    /* net.route.0.inet.flags.gateway */
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET, NET_RT_FLAGS, RTF_GATEWAY};
    
    size_t l;
    char *buf, *p;
    struct rt_msghdr *rt;
    struct sockaddr *sa;
    struct sockaddr *sa_tab[RTAX_MAX];
    int i;
    
    if (sysctl(mib, sizeof(mib) / sizeof(int), 0, &l, 0, 0) < 0) {
        address = @"192.168.0.1";
    }
    
    if (l > 0) {
        buf = malloc(l);
        if (sysctl(mib, sizeof(mib) / sizeof(int), buf, &l, 0, 0) < 0) {
            address = @"192.168.0.1";
        }
        
        for (p = buf; p < buf + l; p += rt->rtm_msglen) {
            rt = (struct rt_msghdr *)p;
            sa = (struct sockaddr *)(rt + 1);
            for (i = 0; i < RTAX_MAX; i++) {
                if (rt->rtm_addrs & (1 << i)) {
                    sa_tab[i] = sa;
                    sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
                } else {
                    sa_tab[i] = NULL;
                }
            }
            
            if (((rt->rtm_addrs & (RTA_DST | RTA_GATEWAY)) == (RTA_DST | RTA_GATEWAY)) &&
                sa_tab[RTAX_DST]->sa_family == AF_INET &&
                sa_tab[RTAX_GATEWAY]->sa_family == AF_INET) {
                unsigned char octet[4] = {0, 0, 0, 0};
                int i;
                for (i = 0; i < 4; i++) {
                    octet[i] = (((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr >>
                                (i * 8)) &
                    0xFF;
                }
                if (((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0) {
                    in_addr_t addr =
                    ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr;
                    address = [self formatIPV4Address:*((struct in_addr *)&addr)];
                    //                    NSLog(@"IPV4address%@", address);
                    break;
                }
            }
        }
        free(buf);
    }
    
    return address;
}
//ipv6网关地址
+ (NSString *)getGatewayIPV6Address
{
    
    NSString *address = nil;
    
    /* net.route.0.inet.flags.gateway */
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET6, NET_RT_FLAGS, RTF_GATEWAY};
    
    size_t l;
    char *buf, *p;
    struct rt_msghdr *rt;
    struct sockaddr_in6 *sa;
    struct sockaddr_in6 *sa_tab[RTAX_MAX];
    int i;
    
    if (sysctl(mib, sizeof(mib) / sizeof(int), 0, &l, 0, 0) < 0) {
        address = @"192.168.0.1";
    }
    
    if (l > 0) {
        buf = malloc(l);
        if (sysctl(mib, sizeof(mib) / sizeof(int), buf, &l, 0, 0) < 0) {
            address = @"192.168.0.1";
        }
        
        for (p = buf; p < buf + l; p += rt->rtm_msglen) {
            rt = (struct rt_msghdr *)p;
            sa = (struct sockaddr_in6 *)(rt + 1);
            for (i = 0; i < RTAX_MAX; i++) {
                if (rt->rtm_addrs & (1 << i)) {
                    sa_tab[i] = sa;
                    sa = (struct sockaddr_in6 *)((char *)sa + sa->sin6_len);
                } else {
                    sa_tab[i] = NULL;
                }
            }
            
            if( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
               && sa_tab[RTAX_DST]->sin6_family == AF_INET6
               && sa_tab[RTAX_GATEWAY]->sin6_family == AF_INET6)
            {
                address = [self formatIPV6Address:((struct sockaddr_in6 *)(sa_tab[RTAX_GATEWAY]))->sin6_addr];
                //                NSLog(@"IPV6address%@", address);
                break;
            }
        }
        free(buf);
    }
    
    return address;
}

/*!
 * 通过hostname获取ip列表 DNS解析地址
 */
+ (NSArray *)getDNSsWithDormain:(NSString *)hostName{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *IPDNSs = [self getDNSWithHostName:hostName];
    if (IPDNSs && IPDNSs.count > 0) {
        [result addObjectsFromArray:IPDNSs];
    }
    
    return [NSArray arrayWithArray:result];
}


+ (NSArray *)getDNSWithHostName:(NSString *)hostName
{
    const char *hostN = [hostName UTF8String];
    Boolean result = false;
    Boolean bResolved = false;
    CFHostRef hostRef;
    CFArrayRef addresses = NULL;
    
    CFStringRef hostNameRef = CFStringCreateWithCString(kCFAllocatorDefault, hostN, kCFStringEncodingASCII);
    
    hostRef = CFHostCreateWithName(kCFAllocatorDefault, hostNameRef);
    if (hostRef) {
        result = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL);
        if (result == true) {
            addresses = CFHostGetAddressing(hostRef, &result);
        }
    }
    bResolved = result;
    NSMutableArray *ipAddresses = [NSMutableArray array];
    if(bResolved)
    {
        struct sockaddr_in* remoteAddr;
        
        for(int i = 0; i < CFArrayGetCount(addresses); i++)
        {
            CFDataRef saData = (CFDataRef)CFArrayGetValueAtIndex(addresses, i);
            remoteAddr = (struct sockaddr_in*)CFDataGetBytePtr(saData);
            
            if(remoteAddr != NULL)
            {
                //获取IP地址
                const char *strIP41 = inet_ntoa(remoteAddr->sin_addr);
                NSString *strDNS =[NSString stringWithCString:strIP41 encoding:NSASCIIStringEncoding];
                [ipAddresses addObject:strDNS];
            }
        }
    }
    CFRelease(hostNameRef);
    if (hostRef) {
        CFRelease(hostRef);
    }
    
    return [NSArray arrayWithArray:ipAddresses];
}
@end
