//
//  FillInfoVC.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit
import CoreLocation
import GoogleMaps

class FillInfoVC: BaseVC {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    
    private let locationManager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lng: CLLocationDegrees?
    let marker = GMSMarker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        self.navigationController?.pushViewController(CheckoutVC(), animated: true)
    }
}

extension FillInfoVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {return}
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.map = mapView
        marker.appearAnimation = .pop
        locationManager.stopUpdatingLocation()
    }
}

extension FillInfoVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
    }
}

