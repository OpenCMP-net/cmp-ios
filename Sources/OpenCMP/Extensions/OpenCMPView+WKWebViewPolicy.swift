//
//  OpenCMPView+WKWebViewPolicy.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 16.05.22.
//

import WebKit

extension OpenCMPView {
  public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if let config = config {
      if !config.disableDomainAccessPolicy {
        if let domain = navigationAction.request.url?.host {
          if config.allowedDomains.contains(domain) {
            decisionHandler(.allow)
            return
          }
          
          print("Deny to access the domain \(domain).")
        }

        print("Abort access to the url resource.")
        decisionHandler(.cancel)
        return
      }
    }
    
    print("Domain access policy is disabled.")
    decisionHandler(.allow)
  }

  public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    if let serverTrust = challenge.protectionSpace.serverTrust {
      let exceptions = SecTrustCopyExceptions(serverTrust)
      SecTrustSetExceptions(serverTrust, exceptions)
      completionHandler(.useCredential, URLCredential(trust: serverTrust))
      return
    }

    completionHandler(.useCredential, nil)
  }
}
