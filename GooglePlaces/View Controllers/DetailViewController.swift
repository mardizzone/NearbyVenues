//
//  DetailViewController.swift
//  GooglePlaces
//
//  Created by Michael Ardizzone on 3/29/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //format the the website button
        websiteButton.makeoverButton()
    }

    @IBAction func websiteButtonPressed(_ sender: UIButton) {
        if let websiteURL = sender.currentTitle {
            guard let url = URL(string: websiteURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

//MARK: - Download and Present Data in View
extension DetailViewController: SpecificPlaceDelegate {
    func requestSpecificPlaceData(placeID: String) {
        Networking.getSpecificPlaceData(placeID: placeID, completionHandler: { placeResult in
            self.setUpDetailView(placeResult: placeResult)
        })
    }
    
    func setUpDetailView(placeResult: PlaceResult) {
        if let addressText = placeResult.formatted_address {
            self.addressLabel.text = addressText
            self.addressLabel.isHidden = false
        }
        if let phoneNumberText = placeResult.formatted_phone_number {
            self.phoneNumberLabel.text = phoneNumberText
            self.phoneNumberLabel.isHidden = false
        }
        if let ratingText = placeResult.rating {
            self.ratingLabel.text = "\(ratingText)⭐️"
            self.ratingLabel.isHidden = false
        }
        self.titleLabel.text = placeResult.name
        if let websiteURL = placeResult.website {
            self.websiteButton.setTitle(websiteURL, for: UIControlState.normal)
            self.websiteButton.isEnabled = true
            self.websiteButton.isHidden = false
        } else {
            self.websiteButton.setTitle("", for: .normal)
            self.websiteButton.isHidden = true
            self.websiteButton.isEnabled = false
        }
        guard let photoURL = placeResult.photos?.first?.photo_reference else { return }
        let screenWidth = Int(UIScreen.main.bounds.width - 30)
        //with more time, we would store our key in the keychain where it will be secure
        let requestURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=\(screenWidth)&photoreference=\(photoURL)&key=AIzaSyBbKdvOrGfhuhDkTIGOqajsQ2kpB-oAuUM"
        if let imageURL = URL(string: requestURL) {
            let request = Request(url: imageURL)
            Manager.shared.loadImage(with: request, into: self.placeImageView)
        }
    }
}
