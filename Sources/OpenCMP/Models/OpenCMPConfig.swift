//
//  OpenCMPConfig.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 18.05.22.
//

public struct OpenCMPConfig: Codable {
  public var domain: String
  public var allowedDomains: [String]
  public var disableDomainAccessPolicy: Bool
  public var printBrowserLogs: Bool
  
  public init(domain: String, allowedDomains: [String], disableDomainAccessPolicy: Bool, printBrowserLogs: Bool) {
    self.domain = domain
    self.allowedDomains = allowedDomains
    self.disableDomainAccessPolicy = disableDomainAccessPolicy
    self.printBrowserLogs = printBrowserLogs
  }
}
