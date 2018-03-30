//
//  ViewController.swift
//  GooglePlaces
//
//  Created by Michael Ardizzone on 3/28/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit
import CoreLocation

class MasterViewController: UIViewController {
    
    @IBOutlet weak var placesTableView: UITableView!
    var placesForTableView = [Place]()
    var locationString : String?
    var locationManager = CLLocationManager()
    weak var specificPlaceDelegate : SpecificPlaceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationManager()
        self.hideKeyboardWhenTappedAround()
    }
}

extension MasterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        Networking.requestRecentDataFromInstagram(searchTerm: searchText, location: locationString) { response in
            self.placesForTableView = response
            self.placesTableView.reloadData()
        }
    }
    //hide keyboard when user taps on tableview
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesForTableView.count
        //return placesForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        cell.textLabel?.text = placesForTableView[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        specificPlaceDelegate = detailVC
        let placeID = placesForTableView[indexPath.row].place_id
        self.navigationController?.pushViewController(detailVC, animated: true)
        specificPlaceDelegate?.requestSpecificPlaceData(placeID: placeID)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}

extension MasterViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationString = "\(locations.last!.coordinate.latitude),\(locations.last!.coordinate.longitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}
