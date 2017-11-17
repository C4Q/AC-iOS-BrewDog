//
//  BeerDetailViewController.swift
//  BrewDog
//
//  Created by Tom Seymour on 11/17/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var taglineLabel: UILabel!
    
    var beer: Beer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        navigationItem.title = beer.name
        taglineLabel.text = beer.tagline
        descriptionTextView.text = beer.beerDescription
        getImage()
    }
    
    
    func getImage() {
        let apiManager = APIManager()
        apiManager.getData(endpoint: beer.imageUrlString) { (data: Data?) in
            if let data = data {
                DispatchQueue.main.async {
                    self.beerImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    
//    func getImage() {
//        guard let url = URL(string: beer.imageUrlString) else { return }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//            if let myError = error {
//                print(myError)
//                return
//            }
//            if let myData = data {
//                let thisImage = UIImage(data: myData)
//                DispatchQueue.main.async {
//                    self.beerImageView.image = thisImage
//                }
//            }
//        }
//        task.resume()
//    }

}
