//
//  OpenCMPView+WKWebViewErrors.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 16.05.22.
//

import WebKit

extension OpenCMPView {
  public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    print(error)
  }
}
