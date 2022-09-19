//
//  OpenCMPConfig.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 18.05.22.
//

struct OpenCMPConfig: Codable {
  var domain: String
  var allowedDomains: [String]
  var disableDomainAccessPolicy: Bool
  var printBrowserLogs: Bool
}
