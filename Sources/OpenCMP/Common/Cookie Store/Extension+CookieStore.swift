//
//  Extension+CookieStore.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 22.05.22.
//

import Foundation

extension CookieStore {
  func encode(cookies: ConsentCookies) -> Data? {
    let encoder = JSONEncoder()
    if let cookieJson = try? encoder.encode(cookies) {
      return (cookieJson)
    }
    return (nil)
  }
  
  func decode(cookieJson: Data) -> ConsentCookies? {
    let decoder = JSONDecoder()
    if let cookies = try? decoder.decode(ConsentCookies.self, from: cookieJson) {
      return (cookies)
    }
    return (nil)
  }
}
