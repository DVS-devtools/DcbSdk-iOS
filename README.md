
# Direct Carrier Billing by Digital Virgo
![Swift Version](https://img.shields.io/badge/Swift-5.6.1-F16D39.svg?style=flat)
![Platform](https://img.shields.io/badge/Platform-iOS-green.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Documentation and example of Digital Virgo Direct Carrier Billing.

Following this guide your app will be technically enabled to be promoted and integrated with Digital Virgo mobile payment.

After the integration of the sdk the resultant app can check if the user coming from Digital Virgo acquisition (optionally with explicit login with msdisdn+pin) and can check expiration date and several information.

## Requirements
- iOS Deployment Target: 9.0
- Swift 5.6.1

## Clone and Try it

Clone it and download the dependency with [Carthage](https://github.com/Carthage/Carthage) . Run on terminal this command in the root folder where is the project DCBApplication.xcodeproj

`carthage update`

If you are only interested to download the framework for a specific platform run the code below: (e.g. iOS)

`carthage update --platform iOS`

## Installation on your Project

Create cartfile, if there isn't,  and add this to `Cartfile`

```
binary "https://dvs-devtools.github.io/DcbSdk/ios/carthage-newton-ios-sdk.json"
binary "https://dvs-devtools.github.io/DcbSdk/ios/carthage-dcbapi-ios-sdk.json"
```

Run the following command in terminal

`carthage update`

If you are only interested to download the framework for a specific platform run the code below: (e.g. iOS)

`carthage update --platform iOS`

Then, on your application targets’ General settings tab, in the Frameworks, Libraries, and Embedded Content section, 
drag and drop each Framework you want to use from the Carthage/Build folder on disk.

![Carthage](./readme_resources/carthage.png)

To speed up the process, you may want to also copy each dependency into the build product (e.g., to embed dependencies within the outer framework). 
To do this, create a new Copy Files build phase with the Frameworks destination, then add the framework reference there as well. 
You shouldn't use the carthage copy-frameworks command since inner frameworks would be stripped, and running concurrent instances of copy-frameworks (with parallel builds turn on) is not supported.

Please make sure the two frameworks are linked as seen in the image.

## Example
To use Direct Carrier Billing by Digital Virgo, use the following code.
```swift
let client = DCBApiClient(baseDomain: URL(string:"<FINGERPRINT_DOMAIN>")!,
                          confInfoDomain: URL(string:"<SERVICE_DOMAIN>")!,
                          apikey: "<YOUR_APIKEY>",
                          catalog: "<YOUR_CATALOG>",
                          country: "<YOUR_COUNTRY>",
                          namespace: "<YOUR_NAMESPACE>")

DCBUserManager(client: client).checkFlowDCB(isActive: false) { date, error in
    if let dcbUser = DCBUserManager.dcbUser {
        //User is recognised as Digital Virgo Acquisition​​
​
​       if let date = date {
​           //User is subscribed​
​       } else {
​           //User expired, not subscribed​​
​           //user must pay again to access the product​​
​       }
​   } else {
​       //Normal user discover the app from AppStore​
​   }
}
```

## Conclusion
Hooray! You've finished the integration!    

For further assistance, please get in touch with the Team by dropping an email to dvs-apps@digitalvirgo.com

