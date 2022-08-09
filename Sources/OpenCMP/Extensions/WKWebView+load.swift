//
//  WKWebView+load.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 14.05.22.
//

import WebKit

extension WKWebView {
  func load(_ url: String) {
    if let url = URL(string: url) {
      let request = URLRequest(url: url)
      load(request)
    }
  }
  
  func load(file url: URL, domain: String) {
    if let url = URL(string: "\(url)?domain=\(domain)") {
      loadFileURL(url, allowingReadAccessTo: url)
      load(url.absoluteString)
    }
  }
}
