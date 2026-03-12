final class WeatherClass: Codable {
    
    let city : String
    let degree : Double
    let windDirection : Double
    let windSpeed: Double
    var windDirectionText: String
 
    init(degree: Double, windDirection: Double, windSpeed: Double, city : String, windDirectionText : String) {
        self.degree = degree
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.city = city
//        self.windDirectionText = NetworkService().directionForWind(degrees: windDirection)
        self.windDirectionText = windDirectionText
    }
}
