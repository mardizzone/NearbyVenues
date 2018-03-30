//
//  Networking.swift
//  GooglePlaces
//
//  Created by Michael Ardizzone on 3/28/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    class func requestRecentDataFromInstagram(searchTerm: String, location: String?, completionHandler : @escaping ([Place]) -> Void) {
        let params: Parameters = ["rankby" : "distance", "location" : location ?? "37.386052,-122.083851", "keyword" : searchTerm, "key" : "AIzaSyBbKdvOrGfhuhDkTIGOqajsQ2kpB-oAuUM", "type" : "establishment" ]
        Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { response in
            guard let data = response.data else {
                return
            }
            if let GooglePlaceJSON = GooglePlacesResponse.parsePlacesResults(data: data) {
                completionHandler(GooglePlaceJSON.results)
            }
        }
    }
    
    class func getSpecificPlaceData(placeID: String, completionHandler: @escaping (PlaceResult) -> Void) {
        let params: Parameters = ["placeid" : placeID, "key" : "AIzaSyBbKdvOrGfhuhDkTIGOqajsQ2kpB-oAuUM"]
        Alamofire.request("https://maps.googleapis.com/maps/api/place/details/json", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { response in
            guard let data = response.data else {
                return
            }
            
            if let GooglePlaceJSON = PlaceDetailResponse.parsePlacesDetailResults(data: data) {
                completionHandler(GooglePlaceJSON.result)
            }
        }
        
    }
}
