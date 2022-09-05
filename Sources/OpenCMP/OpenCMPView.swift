//
//  OpenCMPView.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 14.05.22.
//

import UIKit
import WebKit

public class OpenCMPView: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
  public var acceptOrReject: (_ cookies: ConsentCookies?) -> Void
  
  public var hideUi: () -> Void
  
  private let url: URL
  
  internal let config: OpenCMPConfig?
  
  private init(url: URL, acceptOrReject: @escaping (_ cookies: ConsentCookies?) -> Void, hideUi: @escaping () -> Void) throws {
    self.url = url
    self.acceptOrReject = acceptOrReject
    self.hideUi = hideUi
    
    let decoder = try ConfigDecoder.shared()
    config = try decoder.decode()
    
    if config != nil {
      if config!.domain.isEmpty {
        throw OpenCMPWebViewError.domainNotFound
      }
    }
    
    super.init(nibName: nil, bundle: nil)
  }
  
  public static func shared(acceptOrReject: @escaping (_ cookies: ConsentCookies?) -> Void, hideUi: @escaping () -> Void) throws -> OpenCMPView {
    #if SWIFT_PACKAGE
    guard let url = Bundle.module.url(forResource: "index", withExtension: "html") else {
      throw OpenCMPWebViewError.cannotOpen
    }
    #else
    guard let url = Bundle(for: OpenCMPView.self).url(forResource: "index", withExtension: "html") else {
      throw OpenCMPWebViewError.cannotOpen
    }
    #endif
    
    return (try OpenCMPView(url: url, acceptOrReject: acceptOrReject, hideUi: hideUi))
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
    webView.load(file: url, domain: config!.domain)
  }
  
  public func deleteCookieStore() {
    let cookieStore = CookieStore()
    cookieStore.delete()
  }
  
  internal lazy var webView: WKWebView = {
    let configuration = WKWebViewConfiguration()
    configuration.userContentController.add(self, name: WebViewScriptAction.getConsent.rawValue)
    configuration.userContentController.add(self, name: WebViewScriptAction.setConsent.rawValue)
    configuration.userContentController.add(self, name: WebViewScriptAction.hideUi.rawValue)

    let webView = WKWebView(
      frame: view.bounds,
      configuration: configuration
    )
    
    webView.navigationDelegate = self
    
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.alpha = 0
    webView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
    
    return (webView)
  }()
}
