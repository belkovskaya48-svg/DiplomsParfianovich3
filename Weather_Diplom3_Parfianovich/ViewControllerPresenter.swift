

import UIKit
import CoreLocation

final class ViewControllerPresenter: NSObject {

    var view: ViewControllerProtocol?
    private let networkService: INetworkService
    private let locationManager = CLLocationManager()

    init(view: ViewControllerProtocol, networkService: INetworkService) {
        self.view = view
        self.networkService = networkService
        super.init()
        locationManager.delegate = self
    }

    func getLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func didTapBurger() {
        let controller = SearchAssembler().build { [weak self] weather in
            self?.view?.updateWeatherDisplay(with: weather)
        }
        view?.openSearchModule(controller)
    }
    
    
    private func fetchWeather(for coordinates: CLLocationCoordinate2D) {
        networkService.getWeather(for: coordinates) { [weak self] weather in
            DispatchQueue.main.async {
                guard let weather = weather else {
                    self?.view?.showError(message: "Не удалось получить данные о погоде.")
                    return
                }
                self?.view?.updateWeatherDisplay(with: weather)
            }
        }
    }
}

extension ViewControllerPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchWeather(for: location.coordinate)
        locationManager.stopUpdatingLocation()
    }
}

