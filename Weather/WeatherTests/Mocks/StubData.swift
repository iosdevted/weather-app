//
//  StubData.swift
//  WeatherTests
//
//  Created by Ted on 2021/08/12.
//

import XCTest

class StubData {
    static let shared = StubData()

    func stubWeatherData() -> Data {
        guard let data = self.readJson(forResource: "testWeatherData") else {
            XCTAssert(false, "Can't get data from testWeatherData.json")
            return Data()
        }
        return data
    }
}

extension StubData {
    func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTAssert(false, "Missing file: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch (_) {
            XCTAssert(false, "unable to read json")
            return nil
        }
    }
}
