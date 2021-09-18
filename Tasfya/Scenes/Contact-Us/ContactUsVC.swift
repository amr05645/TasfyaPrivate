//
//  ContactUsVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit
import CoreLocation
import GoogleMaps

class ContactUsVC: BaseVC {
    
    private let locationManager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lng: CLLocationDegrees?
    let marker = GMSMarker()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var fulNameTF: PickerTF!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var textMessageTV: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }
    
    @IBAction func sendBtnTapped(_ sender: Any) {
    }
    
}

extension ContactUsVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {return}
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        mapView.camera = GMSCameraPosition(latitude: 29.3699504, longitude: 47.9785182, zoom: 15)
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.map = mapView
        marker.appearAnimation = .pop
        locationManager.stopUpdatingLocation()
    }
}

extension ContactUsVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
    }
}
