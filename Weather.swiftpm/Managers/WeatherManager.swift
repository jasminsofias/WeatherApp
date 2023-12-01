import SwiftUI
import CoreLocation

class WeatherManager{
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> [ResponseBody] {
        guard let url = URL(string: "https://maceo.sth.kth.se/weather/forecast?lonLat=lon/\(longitude)/lat/\(latitude)") else{ fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{ fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode([ResponseBody].self, from: data)
        
        return decodedData
    }
}

// MARK: - ResponseBody
struct ResponseBody: Decodable {
    let approvedTime, referenceTime: Date
    var geometry: Geometry
    var timeSeries: [TimeSery]
}

// MARK: - Geometry
struct Geometry: Decodable {
    var type: String
    var coordinates: [[Double]]
}

// MARK: - TimeSery
struct TimeSery: Decodable {
    let validTime: String
    var parameters: [Parameter]
}

// MARK: - Parameter
struct Parameter: Decodable {
    var name: String
    var levelType: String
    var level: Int
    var unit: String
    let values: [Double]
}
