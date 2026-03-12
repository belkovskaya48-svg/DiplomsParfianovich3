
@testable import Weather_Diplom3_Parfianovich
import XCTest

final class ExampleNetworkServiceTest: XCTestCase  {
    
    var sut: NetworkService!
    private var networkServiceMock: NetworkServiceMock!
    
    override func setUp() {
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        sut = NetworkService(networkService: networkServiceMock)
    }

    
    override func tearDown() {
        networkServiceMock = nil
        sut = nil
        super.tearDown()
       
    }
    
    func test_getWeather() {
        let expected = WeatherClass(degree: 10, windDirection: 90, windSpeed: 5, city: "Berlin", windDirectionText: "Западный")
        networkServiceMock.weatherToReturn = expected

        let exp = expectation(description: "Weather returned")

        sut.getWeather(for: "Berlin") { weather in
            XCTAssertEqual(weather?.city, expected.city)
            XCTAssertEqual(weather?.degree, expected.degree)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

}

