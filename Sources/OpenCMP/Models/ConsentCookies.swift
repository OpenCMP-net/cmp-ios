//
//  ConsentCookies.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 18.05.22.
//

public struct ConsentCookies: Codable {
  public var tcf: String
  public var google: String?
  public var custom: String
  public var meta: ConsentMetaData
  public var preferences: ConsentPreferences
}
