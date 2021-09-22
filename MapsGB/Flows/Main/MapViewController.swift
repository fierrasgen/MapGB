//
//  MapViewController.swift
//  MapsGB
//
//  Created by Alexander Novikov on 24.08.2021.
//

import UIKit
import GoogleMaps
import RxSwift

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var trackPositionButton: UIBarButtonItem!
    @IBOutlet weak var lastTrackingButton: UIBarButtonItem!
    
    
    @IBAction func addMarkerAction(_ sender: Any) {
        let marker = GMSMarker(position: mapView.camera.target)
        marker.icon = GMSMarker.markerImage(with: .green)
        marker.map = mapView
    }
    
    @IBAction func trackButtonAction(_ sender: Any) {
        isTrackingPosition.toggle()
        trackPositionButton.title = isTrackingPosition ? "Stop tracking" : "Start tracking"
        
        if isTrackingPosition {
            locationManager.startUpdateLocation()
            setupRoute()
            resetRouteLine()
        } else {
            locationManager.stopUpdateLocation()
            saveRoute()
        }
    }
    
    
    @IBAction func lastTrackingButtonAction(_ sender: Any) {
        showLastRoute()
    }
    
    
    private func setupRoute() {
        route?.strokeWidth = 5
        route?.map = mapView
    }
    
    
    private var isTrackingPosition = false
    
    private let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    private let locationManager = LocationManager()
    
    private let disposeBag = DisposeBag()
    
  
    
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    
    
    private func setupLocationManager() {
        locationManager.autorizationStatus.subscribe(onNext: { status in
            print("Location status \(status)")
        })
        .disposed(by: disposeBag)
        
        locationManager.userLocation.subscribe(onNext: { [weak self] location in
            self?.updateUserLocation(location)
        })
        .disposed(by: disposeBag)
    }
    
    func updateUserLocation(_ location: CLLocation) {
        let position = GMSCameraPosition(target: location.coordinate, zoom: 17)
        mapView.animate(to: position)
        routePath?.add(location.coordinate)
        route?.path = routePath
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
    
    private func resetRouteLine() {
        route?.map = nil
        routePath = GMSMutablePath()
        route = GMSPolyline(path: routePath)
        setupRoute()
    }
    
    private func saveRoute() {
        guard let path = route?.path else { return }
        
        var coordinates = [Location]()
        for index in 0..<path.count() {
            let coordinate = path.coordinate(at: index)
            let location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude)
            coordinates.append(location)
        }
        
        RouteStorage.shared.saveLastRoute(route: coordinates)
    }
    
    @objc private func showLastRoute() {
        if isTrackingPosition {
            let yesAction = UIAlertAction(title: "Start tracking", style: .default) { [weak self] _ in
                self?.handleTracking()
                self?.loadLastRoute()
            }
            let noAction = UIAlertAction(title: "Stop tracking", style: .cancel)
            showAlert(with: "No",
                      message: "Do you want to stop tracking?",
                      actions: [noAction, yesAction]
            )
        } else {
            loadLastRoute()
        }
    }
    
    func loadLastRoute() {
        let locations = RouteStorage.shared.loadLastRoute()
        
        resetRouteLine()
        for location in locations {
            addMarker(at: location.coordinate)
        }
    }
    
    @objc private func handleTracking() {
      
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
        locationManager.requestAutorizationAccess()
        return true
    }
}


