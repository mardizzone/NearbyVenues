//
//  Protocols.swift
//  GooglePlaces
//
//  Created by Michael Ardizzone on 3/29/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

protocol SpecificPlaceDelegate: class {
    func requestSpecificPlaceData(placeID: String)
}
