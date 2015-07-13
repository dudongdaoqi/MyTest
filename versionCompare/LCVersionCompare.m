//
//  LCVersionCompare.m
//  PartnerApp
//
//  Created by lc on 3/31/15.
//  Copyright (c) 2015 xulicheng. All rights reserved.
//

#import "LCVersionCompare.h"
#import "LCAlertView.h"

typedef enum QUpdateType
{
    QUpdateYes,
    QUpdateNO,
    QUpdateMust
}QUpdateTypes;


@interface LCVersionCompare()<LCAlertViewDelegate>

@property (nonatomic, strong) NSString *myNewVersion;

@end


@implementation LCVersionCompare

@synthesize myNewVersion = _myNewVersion;
@synthesize isUpdate = _isUpdate;

- (void)versionDataParse:(NSDictionary *)dataDic
{
    if (!dataDic) {
        return;
    }
    
    NSString *newVersion = [self parseString:dataDic key:@"new_version"];
    NSString *urlVersion = [self parseString:dataDic key:@"open_url"];
    
    
    if (newVersion) {
        
        _myNewVersion = [NSString stringWithString:newVersion];

        if (1 == [[dataDic objectForKey:@"has_new"]integerValue]) {
            
            NSString *oldVersion =  nil;
            NSUserDefaults *versionDefault = [NSUserDefaults standardUserDefaults];
            if ([versionDefault objectForKey:@"WebKitMonovularversion"]) {
                oldVersion = [versionDefault objectForKey:@"WebKitMonovularversion"];
            }else{
                oldVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            }
            [versionDefault setObject:newVersion forKey:@"WebKitMonovularversion"];
            [versionDefault synchronize];
            
            [versionDefault setObject:urlVersion forKey:@"WebKitMonovularHashtable"];
            [versionDefault synchronize];
            
            if (1 == [[dataDic objectForKey:@"force_update"]integerValue]){
                _isUpdate = QUpdateMust;
            }else{
                if ([oldVersion compare:newVersion] == NSOrderedAscending) {
                    _isUpdate = QUpdateYes;
                }else{
                    _isUpdate = QUpdateNO;
                }
            }
        }else{
            _isUpdate = QUpdateNO;
        }
        
    }else{
        _isUpdate = QUpdateNO;
    }
    
    [self versionAlert];
}


- (void)versionAlert
{
    switch (_isUpdate) {
        case QUpdateMust:
        {
            LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"发现新版本%@,请更新!", _myNewVersion]  delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil, nil];
            alert.alertAction = ^(NSInteger buttonIndex){
                [self veriosnCom:buttonIndex];
            };
            [alert show];
            break;
        }
        case QUpdateYes:
        {
            LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"发现新版本%@,请更新!", _myNewVersion] delegate:self cancelButtonTitle:@"更新" otherButtonTitles:@"取消", nil];
            [alert show];
            break;
        }
        case QUpdateNO:
            break;
        default:
            break;
    }
}


- (void)alertView:(LCAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *urlVersion = nil;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"WebKitMonovularHashtable"] isKindOfClass:[NSString class]]) {
        urlVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"WebKitMonovularHashtable"];
    }
    
    if (1 == buttonIndex) {
        return;
    }
    
    if ((0 == buttonIndex) && urlVersion) {
        NSURL *url = [NSURL URLWithString:urlVersion];
        [[UIApplication sharedApplication]openURL:url];
    }else{
        if (urlVersion) {
            NSURL *url = [NSURL URLWithString:urlVersion];
            [[UIApplication sharedApplication]openURL:url];
        }else{
            NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/us/app/id948559586"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

- (void)veriosnCom:(NSInteger)buttonIndex
{
    NSString *urlVersion = nil;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"WebKitMonovularHashtable"] isKindOfClass:[NSString class]]) {
        urlVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"WebKitMonovularHashtable"];
    }
    
    if (1 == buttonIndex) {
        return;
    }
    
    if ((0 == buttonIndex) && urlVersion) {
        NSURL *url = [NSURL URLWithString:urlVersion];
        [[UIApplication sharedApplication]openURL:url];
    }else{
        if (urlVersion) {
            NSURL *url = [NSURL URLWithString:urlVersion];
            [[UIApplication sharedApplication]openURL:url];
        }else{
            NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/us/app/id948559586"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}


- (NSString *)parseString:(NSDictionary *)dictionary key:(NSString *)key
{
    if (!dictionary || !key) {
        return nil;
    }
    id temp = [dictionary objectForKey:key];
    if (temp && [temp isKindOfClass:[NSString class]]) {
        NSString *backString = (NSString *)temp;
        return backString;
    }else if (temp && [temp isKindOfClass:[NSNumber class]]) {
        NSNumber *backString = (NSNumber *)temp;
        
        double maxQuota = [backString doubleValue];
        return [NSString stringWithFormat:@"%.2f", maxQuota];
    }else{
        return nil;
    }
}


@end
