//
//  SearchResponse.swift
//  ios-sdk
//
//  Created by Sarah Lensing on 3/21/17.
//  Copyright © 2017 Mapzen. All rights reserved.
//

import Foundation
import Pelias

@objc(MZSearchResponse)
public class SearchResponse : NSObject {
  let peliasResponse: PeliasResponse

  private lazy var internalParsedError: SearchError? = { [unowned self] in
    guard let peliasParsedError = self.peliasResponse.parsedError else { return nil }
    return SearchError.init(peliasParsedError)
    }()

  private lazy var internalParsedResponse: ParsedSearchResponse? =  { [unowned self] in
    guard let peliasParsedResponse = self.peliasResponse.parsedResponse else { return nil }
    return ParsedSearchResponse.init(peliasParsedResponse)
  }()

  public var data: Data? {
    get {
      return peliasResponse.data
    }
  }

  public var response: URLResponse? {
    get {
      return peliasResponse.response
    }
  }

  public var error: NSError? {
    get {
      return peliasResponse.error
    }
  }

  public var parsedResponse: ParsedSearchResponse? {
    get {
      return internalParsedResponse
    }
  }

  public var parsedError: SearchError? {
    get {
      return internalParsedError
    }
  }

  init(_ response: PeliasResponse) {
    peliasResponse = response
  }

  public override func isEqual(_ object: Any?) -> Bool {
    guard let response = object as? SearchResponse else { return false }
    return response.peliasResponse.data == peliasResponse.data &&
            response.peliasResponse.response == peliasResponse.response &&
            response.peliasResponse.error == peliasResponse.error
  }
}

@objc(MZParsedSearchResponse)
public class ParsedSearchResponse: NSObject {

  let peliasResponse: PeliasSearchResponse

  public var parsedResponse: NSDictionary {
    get {
      return peliasResponse.parsedResponse
    }
  }

  init(_ response: PeliasSearchResponse) {
    peliasResponse = response
  }

  public static func encode(_ response: ParsedSearchResponse) {
    PeliasSearchResponse.encode(response.peliasResponse)
  }

  public func decode() -> ParsedSearchResponse? {
    guard let decoded = PeliasSearchResponse.decode() else { return nil }
    return ParsedSearchResponse.init(decoded)
  }
}

