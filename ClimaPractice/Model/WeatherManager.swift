//
//  WeatherManager.swift
//  ClimaPractice
//
//  Created by jae hoon lee on 2023/09/09.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManger,  weather : WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManger {
    
    let countryLists = CountryList()
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6505aed31265cb3ac10916740f23bc1f&metric"
    
    var delegate : WeatherManagerDelegate?
    
    //나라를 입력해 위도와 경도를 받아온다
    func fetchWeather(countryName : String) {
        if let coordinates = countryLists.getCoordinates(for: countryName) {
            let (lat, lon) = coordinates
            print("\(countryName)의 위도: \(lat), 경도: \(lon)")
            let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
            print(urlString)
            performRequest(with: urlString)
        } else {
            print("\(countryName)을 찾을 수 없음")
        }
    }
    
    //네트워킹을 하기
    func performRequest(with urlString : String) {
        //1. create a URL
        if let url = URL(string: urlString) {
            // 2. create URLSession
            let session = URLSession(configuration: .default)
            //3 Give the session a task
            let task = session.dataTask(with: url)  { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    //api를 통해 받아온 json을 필요한 부분을 추출
    func parseJson(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp - 273.15
            let name = decodedData.sys.country
            
            let weather = WeatherModel(conditionId: id, countryName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
        
   
}
