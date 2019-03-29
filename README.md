# iOS Plugin
the project is iOS plugin for [iOS](https://www.apple.com/jp/ios/ios-12/).

## Description
the project is develoed by Xcode(10.1).

FirebaseCore(5.4.0),FireabaseMessaging(3.4.0).

iOS plugin supported iOS10.0 Later.

## Usage
***Notes on use for iOS***

1.Copy Podfile to your project.

- Podfile(Objective-C):https://github.com/ucreates/ios_plugin_client/blob/master/objectivec/Podfile
- Podfile(Swift):https://github.com/ucreates/ios_plugin_client/blob/master/swift/Podfile

2.Execute command in your ios project.

```pod install```

3.Open ios_plugin_client.xcworkspace.
you should set same build settings Your iOS Client App Project and Pods Project.

```
Base SDK
Build Active Architecture Only
Supported Platforms
Valid Architectures
```

4.Build and Running iOS Plugin on your iOS Client App.
