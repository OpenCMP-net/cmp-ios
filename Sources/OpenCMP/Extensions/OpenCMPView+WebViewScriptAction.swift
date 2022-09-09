//
//  OpenCMPView+WebViewScriptAction.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 21.05.22.
//

import WebKit

extension OpenCMPView {
  public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    switch WebViewScriptAction(rawValue: message.name) {
    case .getConsent:
      let cookieStore = CookieStore()
      let cookies = cookieStore.load()
      
      var cookieJson = "{}"
      if cookies != nil {
        let encodedCookie = cookieStore.encode(cookies: cookies!)
        if encodedCookie != nil {
          cookieJson = String(data: encodedCookie!, encoding: .utf8)!
        }
      }
      
      webView.evaluateJavaScript("trfCmpResolvePromise('\(message.body)', '\(cookieJson)')") { _, error in
        guard error == nil else {
          print("Cookie consent responds with a JavaScript error: \(error!).")
          return
        }
      }
    case .setConsent:
      if let cookieJson = String(describing: message.body).data(using: .utf8) {
        let cookieStore = CookieStore()
        if let cookies = cookieStore.decode(cookieJson: cookieJson) {
          cookieStore.store(cookies)
          hideUiView()
          acceptOrReject(cookies)
          break
        }
      }
      
      hideUiView()
      acceptOrReject(nil)
    case .showUi:
      showUiView()
      showUi()
    case .hideUi, .none:
      hideUiView()
      hideUi()
    }
  }
}
