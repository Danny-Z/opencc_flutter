#import "OpenccPlugin.h"
#import "OpenCCService.h"

static dispatch_queue_t queue;

@implementation OpenccPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"opencc_plugin"
                                     binaryMessenger:[registrar messenger]];
    OpenccPlugin* instance = [[OpenccPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"convert" isEqualToString:call.method]) {
        NSString *str = call.arguments[@"text"];
        NSString *config = call.arguments[@"config"];
        OpenCCServiceConverterType converterType = OpenCCServiceConverterTypeS2T;
        
        if (config != nil) {
            NSArray *configs = @[@"s2t",@"t2s",@"s2tw",@"tw2s",@"s2hk",@"hk2s",@"s2twp",@"tw2sp",@"t2hk",@"t2tw"];
            NSUInteger item = [configs indexOfObject: config];
            switch (item) {
                case 0:
                    converterType =OpenCCServiceConverterTypeS2T;
                    break;
                case 1:
                    converterType = OpenCCServiceConverterTypeT2S;
                    break;
                case 2:
                    converterType = OpenCCServiceConverterTypeS2TW;
                    break;
                case 3:
                    converterType = OpenCCServiceConverterTypeTW2S;
                    break;
                case 4:
                    converterType = OpenCCServiceConverterTypeS2HK;
                    break;
                case 5:
                    converterType = OpenCCServiceConverterTypeHK2S;
                    break;
                case 6:
                    converterType = OpenCCServiceConverterTypeS2TWP;
                    break;
                case 7:
                    converterType = OpenCCServiceConverterTypeTW2SP;
                    break;
                case 8:
                    converterType = OpenCCServiceConverterTypeT2HK;
                    break;
                case 9:
                    converterType = OpenCCServiceConverterTypeT2TW;
                    break;
                default:
                    converterType = OpenCCServiceConverterTypeS2T;
                    break;
            }
            
        }
    
    
        OpenCCService *openCCService = [[OpenCCService alloc]initWithConverterType:converterType];
        
        dispatch_async(queue, ^{
            NSString *retStr  = [openCCService convert: str];
            //获取主队列的方法
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                result(retStr);
           });
        });
    
   
        
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
