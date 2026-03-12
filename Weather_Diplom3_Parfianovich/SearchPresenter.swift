import UIKit
import Foundation

final class SearchPresenter {

     var view: SearchViewProtocol?
    
    private let networkService: INetworkService

    var weatherSelectionHandler: ((WeatherClass) -> Void)?

    private(set) var cities: [String] = [] {
        didSet {
            UserDefaults.standard.set(cities, forKey: "savedCities")
        }
    }

    init(view: SearchViewProtocol, networkService: INetworkService) {
        self.view = view
        self.networkService = networkService
        loadCities()
    }

    func loadCities() {
        if let saved = UserDefaults.standard.array(forKey: "savedCities") as? [String] {
            cities = saved
        }
        view?.reloadCities()
    }

    func addCity(_ city: String) {
        guard !city.isEmpty else { return }
        cities.append(city)
        view?.reloadCities()
        fetchWeather(for: city)
    }

    func fetchWeather(for city: String) {
        networkService.getWeather(for: city) { [weak self] weather in
            DispatchQueue.main.async {
                guard let weather = weather else {
                    self?.view?.showError(message: "Не удалось получить данные о погоде")
                    return
                }
                self?.weatherSelectionHandler?(weather)
            }
        }
    }
}
