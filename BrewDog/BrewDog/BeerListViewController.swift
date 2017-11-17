//
//  BeerListViewController.swift
//  BrewDog
//
//  Created by Tom Seymour on 11/17/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let beerEndpoint = "https://api.punkapi.com/v2/beers?page=1&per_page=80"
    
    var beerList: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getData()
    }
    
    func getData() {
        let apiManager = APIManager()
        apiManager.getData(endpoint: beerEndpoint) { (data: Data?) in
            if let myData = data {
                if let thisBeerList = Beer.createArrayOfBeer(from: myData) {
                    self.beerList = thisBeerList
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
//    func getData() {
//        guard let url = URL(string: beerEndpoint) else { return }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//            if let myError = error {
//                print(myError)
//                return
//            }
//            if let myData = data {
//                do {
//                    guard let beerJSONArray = try JSONSerialization.jsonObject(with: myData, options: []) as? [[String: Any]] else { return }
//                    for beerDict in beerJSONArray {
//                        if let thisBeer = Beer(from: beerDict) {
//                            self.beerList.append(thisBeer)
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                } catch let error {
//                    print(error)
//                }
//            }
//        }
//        task.resume()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let beerDVC = segue.destination as? BeerDetailViewController,
            let beerCell = sender as? UITableViewCell,
            let thisIndexPath = tableView.indexPath(for: beerCell)
            else {
                return
        }
        let thisBeer = beerList[thisIndexPath.row]
        beerDVC.beer = thisBeer
    }
}

extension BeerListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        let thisBeer = beerList[indexPath.row]
        cell.textLabel?.text = thisBeer.name
        cell.detailTextLabel?.text = "\(thisBeer.abv)%"
        return cell
    }
}




