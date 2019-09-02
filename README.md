# TLCustomAlert

<!--[![CI Status](https://img.shields.io/travis/tylerlafferty4@gmail.com/TLCustomAlert.svg?style=flat)](https://travis-ci.org/tylerlafferty4@gmail.com/TLCustomAlert)-->
[![Version](https://img.shields.io/cocoapods/v/TLCustomAlert.svg?style=flat)](https://cocoapods.org/pods/TLCustomAlert)
[![License](https://img.shields.io/cocoapods/l/TLCustomAlert.svg?style=flat)](https://cocoapods.org/pods/TLCustomAlert)
[![Platform](https://img.shields.io/cocoapods/p/TLCustomAlert.svg?style=flat)](https://cocoapods.org/pods/TLCustomAlert)

## Requirements
- iOS 10.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

TLCustomAlert is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TLCustomAlert'
```

## Usage
TLCustomAlert is easy to use

Create an instance of TLCustomAlert

```swift
let customAlert = TLCustomAlertView()
```

Instantiate the TLCustomAlertActions that you would like to display on the alert. Minimum of 1 and maximum of 2.

```swift
Method:
public init(title: String, handler: (() -> Void)?)

Example:
let okayAction = TLCustomAlertAction(title: "Okay") {
// Called when okay button is tapped
}
```

Once you have your actions set, call the show method on the TLCustomAlertView. The showAlertView method takes

**Required:**

1. View you'd like to alert to display in
2. Title
3. Message text

**Optional:**

4. An image to display
5. A TLCustomAlertAction to display on the right
6. A TLCustomAlertAction to display on the left

```swift
public func showAlertView(superview: UIView, title: String, text: String, img: String?=nil, confirmAction: TLCustomAlertAction?=nil, cancelAction: TLCustomAlertAction?=nil)
```

```swift
customAlertView.showAlertView(superview: view, title: "CustomApp", text: "This is a custom alert message", confirmAction: okayAction, cancelAction: cancelAction)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.



## Author

Tyler Lafferty - tylerlafferty4@gmail.com

## License

TLCustomAlert is available under the MIT license. See the LICENSE file for more info.
