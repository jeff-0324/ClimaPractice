//
//  Country.swift
//  ClimaPractice
//
//  Created by jae hoon lee on 2023/09/09.
//

import UIKit

class CountryList {
    var countryCoordinates: [String : (Int, Int)] = ["korea" : (37, 127),
                                                     "japan" : (35, 139),
                                                     "china" : (39, 116),
                                                     "russia" : (55, 37),
                                                     "singapore" : (1, 103),
                                                     "india" : (20, 77),
                                                     "kenya" : (-1, 37),
                                                     "ghana" : (7, -2),
                                                     "egypt" : (30, 31),
                                                     "spain" : (40, -3),
                                                     "uk" : (51, -0),
                                                     "germany" : (51, 10),
                                                     "usa" : (37, -95),
                                                     "canada" : (56, -106),
                                                     "brazil" : (-15, -47),
                                                     "australia" : (-27, 133)
    ]
    
    func getCoordinates(for country: String) -> (Int, Int)? {
        return countryCoordinates[country]
    }
   
}
