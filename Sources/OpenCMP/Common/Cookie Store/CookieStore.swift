//
//  CookieStore.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 22.05.22.
//

import Foundation

class CookieStore {
  func store(_ cookies: ConsentCookies) {
    let cookieData = encode(cookies: cookies)
    UserDefaults.standard.set(cookieData, forKey: Constants.cookieStoreName)
  }
  
  func load() -> ConsentCookies? {
    if let cookieData = UserDefaults.standard.data(forKey: Constants.cookieStoreName) {
      return (decode(cookieJson: cookieData))
    }
    return (nil)
  }
}
