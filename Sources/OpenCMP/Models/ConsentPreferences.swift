//
//  ConsentPreferences.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 22.05.22.
//

public struct ConsentPreferences: Codable {
  var cmpSdkId: Int
  var cmpSdkVersion: Int
  var policyVersion: Int
  var gdprApplies: Int
  var publisherCc: String
  var useNonStandardStacks: Int
  var vendorConsents: String
  var vendorLegitimateInterests: String
  var purposeConsents: String
  var purposeLegitimateInterests: String
  var specialFeaturesOptIns: String
  var publisherConsent: String
  var publisherLegitimateInterests: String
  var publisherCustomPurposesConsents: String
  var publisherCustomPurposesLegitimateInterests: String
  var customVendorConsents: String
  var customVendorLegitimateInterests: String
  
  enum CodingKeys: String, CodingKey {
    case cmpSdkId = "IABTCF_CmpSdkID"
    case cmpSdkVersion = "IABTCF_CmpSdkVersion"
    case policyVersion = "IABTCF_PolicyVersion"
    case gdprApplies = "IABTCF_gdprApplies"
    case publisherCc = "IABTCF_PublisherCC"
    case useNonStandardStacks = "IABTCF_UseNonStandardStacks"
    case vendorConsents = "IABTCF_VendorConsents"
    case vendorLegitimateInterests = "IABTCF_VendorLegitimateInterests"
    case purposeConsents = "IABTCF_PurposeConsents"
    case purposeLegitimateInterests = "IABTCF_PurposeLegitimateInterests"
    case specialFeaturesOptIns = "IABTCF_SpecialFeaturesOptIns"
    case publisherConsent = "IABTCF_PublisherConsent"
    case publisherLegitimateInterests = "IABTCF_PublisherLegitimateInterests"
    case publisherCustomPurposesConsents = "IABTCF_PublisherCustomPurposesConsents"
    case publisherCustomPurposesLegitimateInterests = "IABTCF_PublisherCustomPurposesLegitimateInterests"
    case customVendorConsents = "IABTCF_CustomVendorConsents"
    case customVendorLegitimateInterests = "IABTCF_CustomVendorLegitimateInterests"
  }
}
