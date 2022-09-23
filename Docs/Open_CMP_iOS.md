# Open CMP iOS

# Getting Started
1. You must sign up on [github.com](https://github.com) to download the Open CMP Swift Package
2. Open Xcode and navigate to your iOS app project, as below click “Add Packages…”
    
![](file:///./img/Screenshot+2022-06-10+at+10.32.14.png)

3. Our Open CMP package is publicly available. Therefore, with your GitHub account you have access to
4. Hooray! You are ready to download the Swift Package. You should navigate to “All Sources” or “Recently Used” to get to the search field on the top right, as below
5. Copy and paste the url https://github.com/OpenCMP-net/cmp-ios into the search field. You will get the ***cmp-ios*** Swift Package listed in the window
    
![](file:///./img/Screenshot+2022-06-10+at+10.37.40.png)

8. Now hit the button ***Add Package*** to finally add the new package to your Xcode project
    
![](file:///./img/Screenshot+2022-06-10+at+10.37.52.png)

9. The Open CMP Swift Package is listed in the Xcode navigator, as below
    
![](file:///./img/Screenshot+2022-06-10+at+10.38.11.png)

# Apply configuration

You can start with the default configuration below. However, we provide you with a customized configuration that you can use to apply your styling, etc. You need to copy the configuration file **OpenCMP-Info.plist** to the root directory.


![](file:///./img/Screenshot+2022-06-10+at+12.03.05.png)



![](file:///./img/Screenshot+2022-06-10+at+12.03.28.png)



    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
            <key>domain</key>
            <string>traffective.com</string>
            <key>allowedDomains</key>
            <array>
                    <string>cdn.opencmp.net</string>
                    <string>www.traffective.com</string>
            </array>
            <key>disableDomainAccessPolicy</key>
            <true/>
            <key>printBrowserLogs</key>
            <false/>
    </dict>
    </plist>
# Apply remote configuration

You can inject the config object without using the **OpenCMP-Info.plist**. You should not have the **OpenCMP-Info.plist** in place if you inject the config object otherwise your config gets overwritten with the config from **OpenCMP-Info.plist** the file.

    let config = OpenCMPConfig(
      domain: "traffective.com",
      allowedDomains: ["www.traffective.com"],
      disableDomainAccessPolicy: true,
      printBrowserLogs: false
    )
    
    let uiView = try? OpenCMPView.shared(config: config, acceptOrReject: acceptOrReject, showUi: showUi, hideUi: hideUi)
    return (uiView!)


# UIKit integration

Our Open CMP framework is developed in UIKit. Therefore it becomes easy to add the view of the Cookie Consent Banner into your app code. You will receive the cookie data via the ***acceptOrReject*** closure. It will dismiss the Open CMP view whenever the user accepted or rejected the consent.

**Hint**

> Sometimes it is a challenge to further process data returned in a closure. We suggest to work with the **Combine** framework.


    let uiView = try? OpenCMPView.shared(acceptOrReject: { cookies in
      // You will receive the stored 'cookies' here.
    }, showUi: { }, hideUi: { })
    addSubview(uiView)

**Show the consent ui again if a user clicks a button**

    OpenCMPView.shared?.showUiByUser()

**Hint**

> You will get the new cookie consent again in the ‘acceptOrReject’ closure.
# Sample cookie data

The *cookie object* is strongly typed. Therefore it suggest you all the attributes of the *cookie object*. We also give you a sample of the possible cookie data:


    tcf : "CPaXqOpPaXqPbAVACAENCTCsAP_AAH_AAAYgIZtV7T9cbGlDOX59YNtkWIUH1lAFouQCCBaAE6ABwCOAcKQEw2ASIEzoACACIBgAoDKBIAAEGEEQAEAQQIgBADHgIgiEhAAKIAJAABMBAQAAAAsKAAAAEAAIhEAZIACAmCqgQg5mQkAEIIAQQgABAAgAAKABAoMABAEIABgAAAAAgQAAAAAAAIIZgEiCpcQAFCGGBJIEEECIEQVhAFAKACCACAAiAAAAAAYKQAUUACAAAIAAAAAAAAoAYBAAAAAEgAAEAAQIAAABAAAAAAAAAIAAJAABABAAAAAAgCAAAAAAAAAAAAAAAAgAAQAAQCQEAAEAAQAgABAAAAAIAAAAAAAAAIAAAAAAAAAAAAAAAAAIAAAA.YAAAAAAAAAAA"
    google : nil
    custom : "CPaXqOpPaXqPbAVACAENCTCgAAAAAAAAAAAAFBwAgAWgKDAAAAAA.YAAAAAAAAAAA"
    meta : ConsentMetaData
      dv : 297
    preferences : ConsentPreferences
      cmpSdkId : 21
      cmpSdkVersion : 2
      policyVersion : 2
      gdprApplies : 1
      publisherCc : "DE"
      useNonStandardStacks : 0
      vendorConsents : "1101010101111011010011111101011100011011000110100101000011001110010111111001111101011000001101101101100100010110001000010100000111110101100101000000000101101000101110010000000010000010000001011010000000000100111010000000000001110000000010001110000000011100001010010000000100110000110110000000010010001000000100110011101000000000000010000000000010001000000001100000000000101000000011001010000001001000000000000000000100000110000100000100010000000000000100000000010000010000001000100000000001000000000011000111100000001000100000100010000100100001000000000000001010001000000000001001000000000000000001001100000001000000010000000000000000000000000000101100001010000000000000000000000000000100000000000000001000100001000100000000011001001000000000000010000000100110000010101010100000010000100000111001100110010000100100000000000100001000001000000000010000010000100000000000000001000000000000100000000000000000001010000000000001000000101000001100000000000001000000000100001000000000000001100000000000000000000000000000000000100000010000000000000000000000000000000000000000000000001"
      vendorLegitimateInterests : "0000000100100010000010101001011100010000000000000101000010000110000110000001001001001000000100000100000100000010001000000100010000010101100001000000000101000000001010000000000010000010000000000010000000000000100010000000000000000000000000000000000000011000001010010000000000010100010100000000000010000000000000000000001000000000000000000000000000000000000000000000000000101000000000011000000001000000000000000000000000000000000100100000000000000000000100000000000000010000001000000000000000000000000001000000000000000000000000000000000000000000000000000000001000000000000000001001000000000000000001000000000001000000000000000000000000000000000000100000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000010000000000000000010000000010010000000100000000000000000100000000000000010000000000100000000000000001000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001"
      purposeConsents : "1111111111"
      purposeLegitimateInterests : "0111111111"
      specialFeaturesOptIns : "11"
      publisherConsent : ""
      publisherLegitimateInterests : ""
      publisherCustomPurposesConsents : ""
      publisherCustomPurposesLegitimateInterests : ""
      customVendorConsents : "0000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001"
      customVendorLegitimateInterests : ""
# SwiftUI: Interfacing with UIKit (optional)

Our Open CMP framework is developed in UIKit. No worries! If you use SwiftUI you can easily develop a view class by using the ***Coordinator*** and ***UIViewControllerRepresentable*** interfaces.


    import SwiftUI
    import OpenCMP
    import WebKit
    
    struct CookieConsentView: UIViewControllerRepresentable {
      var acceptOrReject: (_ cookies: ConsentCookies?) -> Void
    
      var showUi: () -> Void
      
      var hideUi: () -> Void
          
      func makeUIViewController(context: Context) -> some UIViewController {
        let uiView = try? OpenCMPView.shared(acceptOrReject: acceptOrReject, showUi: showUi, hideUi: hideUi)
        return (uiView!)
      }
    
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
      }
      
      func makeCoordinator() -> Coordinator {
        Coordinator(self)
      }
      
      internal class Coordinator {
        let cookieConsent: CookieConsentView
        
        init(_ cookieConsent: CookieConsentView) {
          self.cookieConsent = cookieConsent
        }
      }
    }
## SwiftUI integration sample code
    import SwiftUI
    import OpenCMP
    
    struct ContentView: View {
      var body: some View {
        CookieConsentView(
          acceptOrReject: { cookies in print(cookies) },
          showUi: {  },
          hideUi: {  }
        )
      }
    }

**Show the consent ui again if a user clicks a button**

    Button("Show Ui", action: {
      OpenCMPView.shared?.showUiByUser()
    })

**Hint**

> You will get the new cookie consent again in the ‘acceptOrReject’ closure.

