
import Foundation
import UIKit

enum Keys: String {
  
    case weatherArray
    case weather
    
}
class SaveLoadManager {
    
    private let defaults = UserDefaults.standard
    
    func saveWeather(_ weather: WeatherClass) {
        
        UserDefaults.standard.set(encodable: weather, forKey: Keys.weather.rawValue)
    }
    
    func saveWeatherArray (_ weather: [WeatherClass])  {
        UserDefaults.standard.set(encodable: weather, forKey: Keys.weatherArray.rawValue)
    }
    
    func loadWeatherArray() -> [WeatherClass] {
        UserDefaults.standard.get(decodableType: [WeatherClass].self, forKey: Keys.weatherArray.rawValue) ?? []
    }

}
