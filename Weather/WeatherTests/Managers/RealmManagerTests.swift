//
//  RealmManagerTests.swift
//  WeatherTests
//
//  Created by Ted on 2021/08/16.
//

import RealmSwift
import XCTest
@testable import Weather

class RealmManagerTests: XCTestCase {
    
    private var mockRealmManager: MockRealmManager?
    private var mockWeatherService: MockWeatherService?
    var weatherService = WeatherService()
    var data: WeatherResponse?
    
    private let locationData = Location(name: "Paris", latitude: 21.2859, longitude: 14.7832)
    
    override func setUp() {
        self.mockWeatherService = MockWeatherService()
        self.mockRealmManager = MockRealmManager()
    }
    
    override func tearDown() {
        self.mockRealmManager?.deleteLocalWeatherData()
        self.mockWeatherService = nil
    }
    
    func testSaveData_WhenLocationDataProvided_ShouldReturnTrue() throws {
        
        mockRealmManager?.saveLocationData(locationData)
        let realmData = mockRealmManager?.retrieveLocationData()
        
        XCTAssert(locationData.name == realmData?.name, "Expect created location name is Paris")
        XCTAssert(locationData.latitude == realmData?.latitude, "Expect created latitude is 21.2859")
        XCTAssert(locationData.longitude == realmData?.longitude, "Expect created longitude name is 14.7832")
        XCTAssert(mockRealmManager?.saveOnlyLocationDataCalled == 1, "Expect saveOnlyLocationDataCalled is 1")
        XCTAssert(mockRealmManager?.retrieveLocationDataCalled == 1, "Expect retrieveLocationDataCalled is 1")
    }
}
