//
//  OpenCCService.m
//  OpenCC
//
//  Created by gelosie on 12/4/15.
//

#define OPENCC_EXPORT 

#import "OpenCCService.h"
#import <string>
#import "SimpleConverter.hpp"

class SimpleConverter;

@interface OpenCCService (){
    @private opencc::SimpleConverter *simpleConverter;
}

@end


@implementation OpenCCService

-(instancetype)initWithConverterType:(OpenCCServiceConverterType)converterType{
    self = [super init];
    if(self){
        NSString *json = @"s2t.json";
        switch (converterType) {
            case OpenCCServiceConverterTypeS2T:
                json=@"s2t.json";
                break;
            case OpenCCServiceConverterTypeT2S:
                json=@"t2s.json";
                break;
            case OpenCCServiceConverterTypeS2TW:
                json=@"s2tw.json";
                break;
            case OpenCCServiceConverterTypeTW2S:
                json=@"tw2s.json";
                break;
            case OpenCCServiceConverterTypeS2HK:
                json=@"s2hk.json";
                break;
            case OpenCCServiceConverterTypeHK2S:
                json=@"hk2s.json";
                break;
            case OpenCCServiceConverterTypeS2TWP:
                json=@"s2twp.json";
                break;
            case OpenCCServiceConverterTypeTW2SP:
                json=@"tw2sp.json";
                break;
            case OpenCCServiceConverterTypeT2HK:
                json=@"t2hk.json";
                break;
            case OpenCCServiceConverterTypeT2TW:
                json=@"t2tw.json";
                break;
                
            default:json = @"s2t.json";break;
        }
        
        NSBundle* bundle = [self bundleWithBundleName:@"opencc" podName:@"opencc_plugin"];
        NSString *config = [[bundle resourcePath] stringByAppendingPathComponent:json];
        const std::string *c = new std::string([config UTF8String]);
        simpleConverter = new opencc::SimpleConverter(*c);
    }
    return self;
}

/**
 获取文件所在name，默认情况下podName和bundlename相同，传一个即可
 
 @param bundleName bundle名字，就是在resource_bundles里面的名字
 @param podName pod的名字
 @return bundle
 */
-(NSBundle *)bundleWithBundleName:(NSString *)bundleName podName:(NSString *)podName{
    if (bundleName == nil && podName == nil) {
        @throw @"bundleName和podName不能同时为空";
    }else if (bundleName == nil ) {
        bundleName = podName;
    }else if (podName == nil) {
        podName = bundleName;
    }
    
    
    if ([bundleName containsString:@".bundle"]) {
        bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
    }
    //没使用framwork的情况下
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    //使用framework形式
    if (!associateBundleURL) {
        associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
        associateBundleURL = [associateBundleURL URLByAppendingPathComponent:podName];
        associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
        NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
        associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    }
    
    NSAssert(associateBundleURL, @"取不到关联bundle");
    //生产环境直接返回空
    return associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:nil;
}

- (NSString *)convert:(NSString *)str {
    std::string st = simpleConverter->Convert([str UTF8String]);
    return [NSString stringWithCString:st.c_str() encoding:NSUTF8StringEncoding];
}

-(void)dealloc {
    delete simpleConverter;
}

@end
