#import "SqliteViewerPlugin.h"
#import <sqlite_viewer/sqlite_viewer-Swift.h>

@implementation SqliteViewerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSqliteViewerPlugin registerWithRegistrar:registrar];
}
@end
