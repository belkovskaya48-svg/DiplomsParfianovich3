
protocol INetworkService {
    
    func getWeather(for city: String, completion: @escaping (WeatherClass?) -> Void)
    func getWeather(for coordinates: CLLocationCoordinate2D, completion: @escaping (WeatherClass?) -> Void)
    func directionForWind(degrees: Double) -> String 
}


import SwiftyJSON
import Foundation
import CoreLocation


final class NetworkService: INetworkService {
    
    private let networkService: INetworkService?

       init(networkService: INetworkService? = nil) {
           self.networkService = networkService
       }
    
    private let baseURLString = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "22050aedf8627a8777fd37de24aaaa55"
    
    func getWeather(for city: String, completion: @escaping (WeatherClass?) -> Void) {
        
        if let mock = networkService {
                mock.getWeather(for: city, completion: completion)
                return
            }
        
        let urlString = "\(baseURLString)?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil, let data = data else {
                print("❌ Ошибка сети:", error?.localizedDescription ?? "unknown")
                completion(nil)
                return
            }
            
            if let json = try? JSON(data: data) {
                
                guard let degree = json["main"]["temp"].double,
                      let cityName = json["name"].string,
                      let windDirection = json["wind"]["deg"].double,
                      let windSpeed = json["wind"]["speed"].double else {
                    completion(nil)
                    return
                }
                
                let windDirectionText = self.directionForWind(degrees: windDirection)
                
                let weather = WeatherClass(
                    degree: degree,
                    windDirection: windDirection,
                    windSpeed: windSpeed,
                    city: cityName,
                    windDirectionText : windDirectionText
                )
                
                completion(weather)
            } else {
                completion(nil)
            }
            
        }.resume()
    }

    func getWeather(for coordinates: CLLocationCoordinate2D, completion: @escaping (WeatherClass?) -> Void) {
        
        if let mock = networkService {
                mock.getWeather(for: coordinates, completion: completion)
                return
            }
        
        let urlString = "\(baseURLString)?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil, let data = data else {
                print("❌ Ошибка сети:", error?.localizedDescription ?? "unknown")
                completion(nil)
                return
            }

            if let json = try? JSON(data: data) {
                
                guard let degree = json["main"]["temp"].double,
                      let cityName = json["name"].string,
                      let windDirection = json["wind"]["deg"].double,
                      let windSpeed = json["wind"]["speed"].double else {
                    completion(nil)
                    return
                }
                
                let windDirectionText = self.directionForWind(degrees: windDirection)
                
                let weather = WeatherClass(
                    degree: degree,
                    windDirection: windDirection,
                    windSpeed: windSpeed,
                    city: cityName,
                    windDirectionText: windDirectionText
                )
                
                completion(weather)
            } else {
                completion(nil)
            }
            
        }.resume()
    }

    func directionForWind(degrees: Double) -> String {
        switch degrees {
        case 0..<22.5, 337.5..<360:
            return "Северный"
        case 22.5..<67.5:
            return "Северо-восточный"
        case 67.5..<112.5:
            return "Восточный"
        case 112.5..<157.5:
            return "Юго-восточный"
        case 157.5..<202.5:
            return "Южный"
        case 202.5..<247.5:
            return "Юго-западный"
        case 247.5..<292.5:
            return "Западный"
        case 292.5..<337.5:
            return "Северо-западный"
        default:
            return "Неизвестное направление"
        }
    }
}
