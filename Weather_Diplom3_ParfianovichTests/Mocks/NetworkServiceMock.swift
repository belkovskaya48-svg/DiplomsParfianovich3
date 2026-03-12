@testable import Weather_Diplom3_Parfianovich
import CoreLocation


final class NetworkServiceMock: INetworkService {
    var weatherToReturn: WeatherClass?

       func getWeather(for city: String, completion: @escaping (WeatherClass?) -> Void) {
           completion(weatherToReturn)
       }

       func getWeather(for coordinates: CLLocationCoordinate2D, completion: @escaping (WeatherClass?) -> Void) {
           completion(weatherToReturn)
       }

       func directionForWind(degrees: Double) -> String {
           return "MockDirection"
       }

}
