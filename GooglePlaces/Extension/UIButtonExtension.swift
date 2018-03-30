//
//  UIButtonExtension.swift
//  GooglePlaces
//
//  Created by Michael Ardizzone on 3/29/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    //we'll use this function to make our button look better
    func makeoverButton() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.titleLabel?.textColor = UIColor.white
        self.backgroundColor = UIColor.blue
    }
}
