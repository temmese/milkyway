//
//  NetworkManager.swift
//  MilkyWayApp
//
//  Created by David Tverdota on 04/11/2018.
//  Copyright © 2018 Emese Toth. All rights reserved.
//

import Foundation
import Alamofire

struct MilkyWayData {
    let title : String
    let center : String
    let date : String
    let description : String
    let imageUrl : String
}

class NetworkManager {
    
    let urlString = "https://images-api.nasa.gov/search?q=milky%20way&media_type=image&year_start=2017&year_end=2017"
    
    func getResponse(completion: @escaping ([MilkyWayData]) -> Void){
        Alamofire.request(urlString).responseJSON { response in
            
            if let data = response.data {
                do {
                    let Ndata = try JSONDecoder().decode(NASAJson.self, from: data)
                    let milkyWayArray = self.parseResponse(Ndata)
                    completion(milkyWayArray)
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
            }
        }
    }
    
    func parseResponse(_ nasa_data: NASAJson) -> [MilkyWayData] {
        var milkyWayArray = [MilkyWayData]()
        for item in nasa_data.collection!.items {
            for link in item!.links {
                let title = item!.data[0]!.title!
                let center = item!.data[0]!.center!
                let created = item!.data[0]!.date_created!
                let desc = item!.data[0]!.description!
                let url = link?.href
                milkyWayArray.append(MilkyWayData(title: title, center: center, date: created, description: desc, imageUrl: url!))
            }
        }
        return milkyWayArray
    }
}
