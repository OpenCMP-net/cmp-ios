//
//  ConsentCookies.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 18.05.22.
//

public struct ConsentCookies: Codable {
  var tcf: String
  var google: String?
  var custom: String
  var meta: ConsentMetaData
  var preferences: ConsentPreferences
}
