//
//  weatherData.swift
//  ClimaPractice
//
//  Created by jae hoon lee on 2023/09/11.
//

import Foundation

struct WeatherData : Codable {
    let sys : Sys
    let main : Main
    let weather : [Weather]
}
struct Sys : Codable {
    let country : String
}
struct Main : Codable {
    let temp : Double
}
struct Weather : Codable {
    let description : String
    let id : Int
}

