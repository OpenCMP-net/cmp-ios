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
      webView.evaluateJavaScript("trfCmpResolvePromise('\(message.body)', {})")
    case .setConsent:
      if let cookieJson = String(describing: message.body).data(using: .utf8) {
        let cookieStore = CookieStore()
        if let cookies = cookieStore.decode(cookieJson: cookieJson) {
          cookieStore.store(cookies)
          acceptOrReject(cookies)
          break
        }
      }
      
      acceptOrReject(nil)
    case .hideUi, .none:
      print(message.body)
      acceptOrReject(nil)
    }
  }
}
