//
//  MapViewController.swift
//  MapsGB
//
//  Created by Alexander Novikov on 24.08.2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBAction func addMarkerAction(_ sender: Any) {
        let marker = GMSMarker(position: mapView.camera.target)
        marker.icon = GMSMarker.markerImage(with: .green)
        marker.map = mapView
    }
    
    
    private let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    private let locationManager = CLLocationManager()
    
    
    private func checkLocationStatus() {
        let locationStatus = locationManager.authorizationStatus
        switch locationStatus {
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location access denied")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupLocationManager()
    }
    
    private func setupMapView() {
        let cameraPosition = GMSCameraPosition(target: coordinate, zoom: 17)
        mapView.camera = cameraPosition
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        if let style = Bundle.main.url(forResource: "style", withExtension: "json"){
            mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: style)
        }
    }
    
    private func addMarker(at coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
    }
    
    private func removeMarker(_ marker: GMSMarker) {
        marker.map = nil
    }
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        removeMarker(marker)
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        addMarker(at: coordinate)
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        checkLocationStatus()
        return true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let position = GMSCameraPosition(target: location.coordinate, zoom: 17)
            mapView.animate(to: position)
            addMarker(at: location.coordinate)
            locationManager.startUpdatingLocation()
        }
    }
}
