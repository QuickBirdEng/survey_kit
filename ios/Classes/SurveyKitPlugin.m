#import "SurveyKitPlugin.h"
#if __has_include(<survey_kit/survey_kit-Swift.h>)
#import <survey_kit/survey_kit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "survey_kit-Swift.h"
#endif

@implementation SurveyKitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSurveyKitPlugin registerWithRegistrar:registrar];
}
@end
