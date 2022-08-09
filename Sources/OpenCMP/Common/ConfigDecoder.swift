//
//  ConfigDecoder.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 20.05.22.
//

import Foundation

class ConfigDecoder {
  private var url: URL
  
  private init(url: URL) {
    self.url = url
  }
  
  static func shared() throws -> ConfigDecoder {
    guard let url = Bundle.main.url(forResource: "OpenCMP-Info", withExtension: "plist") else {
      throw ConfigDecodingError.configNotFound
    }
    return (ConfigDecoder(url: url))
  }
  
  func decode() throws -> OpenCMPConfig? {
    var config: OpenCMPConfig?
    
    if let data = try? Data(contentsOf: url) {
      let decoder = PropertyListDecoder()
      config = try? decoder.decode(OpenCMPConfig.self, from: data)
    }
    return (config)
  }
}
