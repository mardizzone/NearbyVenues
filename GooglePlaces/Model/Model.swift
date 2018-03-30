//
//  Model.swift
//  GooglePlaces
//
//  Created by Michael Ardizzone on 3/28/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

struct GooglePlacesResponse : Codable {
    let results : [Place]
    static func parsePlacesResults(data: Data) -> GooglePlacesResponse? {
        let decoder = JSONDecoder()
        do {
            let googlePlacesData = try decoder.decode(GooglePlacesResponse.self, from: data)
            return googlePlacesData
        } catch {
            print("error trying to convert data to JSON \(error)")
            return nil
        }
    }
}

struct Place : Codable {
    let name : String
    let place_id : String
}

struct PlaceDetailResponse : Codable {
    let result : PlaceResult
    static func parsePlacesDetailResults(data: Data) -> PlaceDetailResponse? {
        let decoder = JSONDecoder()
        do {
            let googlePlacesData = try decoder.decode(PlaceDetailResponse.self, from: data)
            return googlePlacesData
        } catch {
            print("error trying to convert data to JSON \(error)")
            return nil
        }
    }
}

struct PlaceResult : Codable {
    let formatted_address: String?
    let formatted_phone_number: String?
    let name: String
    let rating: Double?
    let photos: [Photo]?
    let website : String?
}

struct Photo : Codable {
    let height: Int
    let width: Int
    let photo_reference: String
}

