//
//  Beer.swift
//  BrewDog
//
//  Created by Tom Seymour on 11/17/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import Foundation

class Beer {
    let name: String
    let tagline: String
    let abv: Double
    let beerDescription: String
    let imageUrlString: String
    
    var sectionName: String {
        let wholePercent = Int(abv)
        return "\(wholePercent).0% - \(wholePercent).9%"
    }
    
    init(name: String, tagline: String, abv: Double, beerDescription: String, imageUrlString: String) {
        self.name = name
        self.tagline = tagline
        self.abv = abv
        self.beerDescription = beerDescription
        self.imageUrlString = imageUrlString
    }
    
    convenience init?(from dict: [String: Any]) {
        guard
            let name = dict["name"] as? String,
            let tagline = dict["tagline"] as? String,
            let abv = dict["abv"] as? Double,
            let beerDescription = dict["description"] as? String,
            let imageUrlString = dict["image_url"] as? String
            else {
                return nil
        }
        
        self.init(name: name, tagline: tagline, abv: abv, beerDescription: beerDescription, imageUrlString: imageUrlString)
    }
    
    static func createArrayOfBeer(from data: Data) -> [Beer]? {
        var beerList: [Beer] = []
        
        do {
            guard let beerJSONArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                else { return nil }
            for beerDict in beerJSONArray {
                if let thisBeer = Beer(from: beerDict) {
                    beerList.append(thisBeer)
                }
            }
            
        } catch let error {
            print(error)
        }
        
        return beerList
    }
    
}
