//
//  OpenCMPView.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 14.05.22.
//

import UIKit
import WebKit

public class OpenCMPView: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
  static public var shared: OpenCMPView?
  
  internal var acceptOrReject: (_ cookies: ConsentCookies?) -> Void
  
  internal var showUi: () -> Void
  
  internal var hideUi: () -> Void
  
  internal let config: OpenCMPConfig?
  
  private let url: URL
  
  private init(config: OpenCMPConfig, acceptOrReject: @escaping (_ cookies: ConsentCookies?) -> Void, showUi: @escaping () -> Void, hideUi: @escaping () -> Void) throws {
    #if SWIFT_PACKAGE
    let url = Bundle.module.url(forResource: "cmp", withExtension: "html")
    #else
    let url = Bundle(for: OpenCMPView.self).url(forResource: "cmp", withExtension: "html")
    #endif
    
    guard let url = url else {
      throw OpenCMPWebViewError.cannotLoad
    }
    
    self.url = url
    self.acceptOrReject = acceptOrReject
    self.showUi = showUi
    self.hideUi = hideUi
    self.config = config
    
    super.init(nibName: nil, bundle: nil)
  }
  
  public static func shared(config: OpenCMPConfig, acceptOrReject: @escaping (_ cookies: ConsentCookies?) -> Void, showUi: @escaping () -> Void, hideUi: @escaping () -> Void) throws -> OpenCMPView? {
    if shared == nil {
      shared = try OpenCMPView(
        config: config,
        acceptOrReject: acceptOrReject,
        showUi: showUi,
        hideUi: hideUi
      )
    }
    
    return (shared)
  }
  
  public static func shared(acceptOrReject: @escaping (_ cookies: ConsentCookies?) -> Void, showUi: @escaping () -> Void, hideUi: @escaping () -> Void) throws -> OpenCMPView? {
    guard shared == nil else {
      return (shared)
    }
    
    let decoder = try ConfigDecoder.shared()
    let config = try decoder.decode()
    
    guard config?.domain != nil else {
      throw ConfigDecodingError.domainNotFound
    }
    
    return (try OpenCMPView.shared(config: config!, acceptOrReject: acceptOrReject, showUi: showUi, hideUi: hideUi))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func loadView() {
    super.loadView()
    
    view.addSubview(webView)
    
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 100
      ),
      webView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
        constant: 0
      ),
      webView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: 0
      ),
      webView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
        constant: 0
      )
    ])
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    // Open cmp can accept an empty domain string. In this case
    // the open cmp shows the default styles of the open cmp.
    webView.load(file: url, domain: config?.domain ?? "")
  }
  
  public func deleteCookieStore() {
    let cookieStore = CookieStore()
    cookieStore.delete()
  }
  
  public func showUiByUser() {
    // Shows the cookie consent banner by triggering the js api.
    webView.evaluateJavaScript("__tcfapi(\"showUi\", 2, function(){})") { _, error in
      guard error == nil else {
        print("Cookie consent responds with a JavaScript error: \(error!).")
        return
      }
    }
  }
  
  internal lazy var webView: WKWebView = {
    let configuration = WKWebViewConfiguration()
    configuration.userContentController.add(self, name: WebViewScriptAction.getConsent.rawValue)
    configuration.userContentController.add(self, name: WebViewScriptAction.setConsent.rawValue)
    configuration.userContentController.add(self, name: WebViewScriptAction.showUi.rawValue)
    configuration.userContentController.add(self, name: WebViewScriptAction.hideUi.rawValue)

    configuration.applicationNameForUserAgent = Constants.customUserAgent
    
    let webView = WKWebView(
      frame: view.bounds,
      configuration: configuration
    )
    
    webView.navigationDelegate = self
    
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.alpha = 0
    webView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
    webView.isHidden = true
    
    if let config = config {
      if config.printBrowserLogs {
        webView.browserLogs(messageHandler: self)
      }
    }
    
    return (webView)
  }()
  
  internal func showUiView() {
    webView.isHidden = false
  }
  
  internal func hideUiView() {
    webView.isHidden = true
  }
}
