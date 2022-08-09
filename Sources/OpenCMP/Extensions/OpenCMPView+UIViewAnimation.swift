//
//  OpenCMPView+UIViewAnimation.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 16.05.22.
//

import UIKit
import WebKit

extension OpenCMPView {
  public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    UIView.animate(withDuration: 0.8) {
      webView.alpha = 1
      webView.transform = CGAffineTransform(translationX: 0, y: 0)
      webView.layoutIfNeeded()
    }
  }
}
