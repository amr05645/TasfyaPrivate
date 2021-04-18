//
//  AddAddressVC.swift
//  Tasfya
//
//  Created by Elsaadany on 14/04/2021.
//

import UIKit
import CoreLocation

class AddAddressVC: UIViewController {
    
    private let locationManager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lng: CLLocationDegrees?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func locationTapped(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func confirmtapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddAddressVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
//        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        self.lat = location.coordinate.latitude
        self.lng = location.coordinate.longitude
                
        locationManager.stopUpdatingLocation()
    }
}
