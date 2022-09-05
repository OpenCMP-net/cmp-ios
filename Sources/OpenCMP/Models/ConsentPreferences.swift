//
//  ConsentPreferences.swift
//  OpenCMP
//
//  Created by Andreas Reuter on 22.05.22.
//

public struct ConsentPreferences: Codable {
  public var cmpSdkId: Int
  public var cmpSdkVersion: Int
  public var policyVersion: Int
  public var gdprApplies: Int
  public var publisherCc: String
  public var useNonStandardStacks: Int
  public var vendorConsents: String
  public var vendorLegitimateInterests: String
  public var purposeConsents: String
  public var purposeLegitimateInterests: String
  public var specialFeaturesOptIns: String
  public var publisherConsent: String
  public var publisherLegitimateInterests: String
  public var publisherCustomPurposesConsents: String
  public var publisherCustomPurposesLegitimateInterests: String
  public var customVendorConsents: String
  public var customVendorLegitimateInterests: String
  
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
