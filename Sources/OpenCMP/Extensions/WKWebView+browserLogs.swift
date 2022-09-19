//
//  WKWebView+browserLogs.swift
//  
//
//  Created by Andreas Reuter on 13.09.22.
//

import WebKit

extension WKWebView {
  func browserLogs(messageHandler: WKScriptMessageHandler) {
    let source = """
      function captureLog(msg) {
        window.webkit.messageHandlers.captureLog.postMessage(msg);
      }
      window.console.log = captureLog;
      window.console.debug = captureLog;
      window.console.info = captureLog;
      window.console.warn = captureLog;
      window.console.error = captureLog;
    """
    
    let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    
    configuration.userContentController.addUserScript(script)
    configuration.userContentController.add(messageHandler, name: "captureLog")
  }
}
