import UIKit
import MapKit

public class PPGeofenceViewController: PPBaseViewController {
    
    public var updateMode: Bool = false
    private lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    private lazy var customView: GeofenceView =  {
        debugPrint("init GeofenceView...")
        return GeofenceView()
    }()
    
    public func getMap() -> MKMapView {
        customView.map
    }
    
    public func getAddressField() -> UITextField {
        customView.addressTextField
    }
    
    private var fenceCoordinates: [PPLocationCoordinate2D] = []
    
    public func getFenceCoordinates() -> [PPLocationCoordinate2D] {
        fenceCoordinates
    }
    
    public func addToFenceCoordinates(_ coordinate: PPLocationCoordinate2D) {
        fenceCoordinates.append(coordinate)
    }
    
    public func clearCoordinates() {
        fenceCoordinates = []
    }
    
    private lazy var viewModel: CreateGeofenceViewModel = {
       PPCreateGeofenceViewModel()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initMap()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if updateMode {
            addTitle("Geofencing")
            loadGeofenceCoordinates()
        } else {
            addNavBarTitle()
        }
    }
    
    private func initView() {
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        if updateMode {
            customView.primaryButton.setTitle("Update", for: .normal)
            customView.progressLabel.isHidden = true
        }
        
        customView.primaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onProceed)))
        customView.centerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCenterCurLocOnMap)))
        customView.addPinButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAddPin)))
//        customView.clearPinsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClearPins)))
        customView.segmentedControl.addTarget(self, action: #selector(onSelectMapType), for: .valueChanged)
        navigationController?.navigationBar.backgroundColor = .black
    }
    
    private func initMap() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    public func loadGeofenceCoordinates() {
        let tenantId = DataProvider.newInMemoryRealm().getTenantId()
        viewModel.loadGeolocation(tenantId: tenantId) { [weak self] geofenceModel, error in
            guard let strongSelf = self else { return }
            for c in geofenceModel?.geofence ?? [] {
                strongSelf.renderAnnotation(latitude: c.latitude, longitude: c.longitude)
            }
        }
    }
    
    public func showHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func showSubscriptionPlans() {
        let vc = PPChoosePlanViewController()
        push(vc: vc)
    }
    
    public func onConfirm() {
        saveGeofence()
    }
    
    public func saveGeofence() {
        viewModel.createGeofence(payload: getGeofenceParameters(), completion: {
            [weak self] error in
            guard let strongSelf = self else { return }
            
            if let _ = error {
                strongSelf.showFailedToCreateGeofenceMessage()
            } else {
                if strongSelf.updateMode {
                    strongSelf.showHome()
                } else {
                    strongSelf.showSubscriptionPlans()
                }
            }
        })
    }
    
    public func updateGeofence() {
        showHome()
    }
        
    @objc func onProceed() {
        confirmGeofence()
    }
    
    @objc func onCenterCurLocOnMap() {
        moveMapToLocation(location: locationManager.location, nil)
    }
    
    @objc func onAddPin() {
        if let curLoc = locationManager.location {
            addPinOnMap(curLoc)
        }
    }
    
    @objc func onClearPins() {
        clearPins()
    }
    
    @objc func onSelectMapType() {
        switch customView.segmentedControl.selectedSegmentIndex {
        case 1:
            customView.map.mapType = .satellite
        default:
            customView.map.mapType = .standard
        }
    }
    
    @objc func removePinAt(_ sender: Any?) {
        if let btn = sender as? PPButton {
            if let identifier = btn.identifier {
                fenceCoordinates = fenceCoordinates.filter { $0.identifier != identifier }
                drawPolyline(customView.map)
                customView.map.annotations.forEach { annotation in
                    if let ppAnnotation = annotation as? PPPointAnnotation {
                        if ppAnnotation.identifier == identifier {
                            customView.map.removeAnnotation(ppAnnotation)
                        }
                    }
                }
            }
        }
    }
}











