//
//  TableViewController.swift
//  Our Products
//
//  Created by Tichafa Gava on 23/11/2016.
//  Copyright © 2016 Tichafa Gava - Ketts. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    // Define Array for Table data here. For now as a string
    var tableData: Array<String> = Array<String> ()
    
    // Define core data objects to store Products/Quakes
    var productCoreList = [NSManagedObject]()
    var quakeCoreList = [NSManagedObject]()

    // create a variable to to store Product/ Earthquake items
    
    // var productArray: [Product] = [Product]()
    var quakeArray: [Quake] = [Quake]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                // Get JSON data here by calling a function we can define somewhere below
        //let jsonLink: String = "https://files.secureserver.net/0smQrrKhvugllr"
        let jsonLink: String = "http://earthquake-report.com/feeds/recent-eq?json"
        // let jsonLink: String = "https://s3-eu-west-1.amazonaws.com/interview-tests/product.json"
        
        getJsonData(jsonLink)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) 
        cell.textLabel?.text = tableData[indexPath.row]

        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //if let cell = tableView.cellForRow(at: indexPath) {
            let item = quakeArray[indexPath.row]
            let detailVC = quakeDetailViewController()
            detailVC.titleString = item.title
            detailVC.magnitudeString = item.magnitude
            detailVC.locationString = item.location
            detailVC.linkString = item.link
            detailVC.depthString = item.depth
        
            self.present(detailVC, animated: true, completion: nil)
        
    }

    
    
    // We require a funtion to refresh our table data so here is the definition:
    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
    }
    
    //Define function to get JSON data here
    func getJsonData(_ link:String)
    {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
            return
            }
            
            //Make a call to extract the JSON data, the function is also defined here
            self.extractJsonData(data!)
            
        })
        
        task.resume()
        
    }
    
    // Define function to extract JSON data
    
    func extractJsonData(_ data: Data)
    {
        let json: Any?
        
        do
        {
            json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        }
       
        catch let error as NSError {
            print("Details of JSON parsing error:\n \(error)")
    
            return
        }
        
        guard let data_list = json as? NSArray else { return }
        
       /*
         // Replace code for product list with Earthquake list here since connection to server keeps dropping.
         
        if let productList = json as? NSArray
        {
            for i in 0 ..< data_list.count
            {
                if let product_obj = productList[i] as? NSDictionary
                {
                    if let productTitle = product_obj["title"] as? String
                    {
         
                    guard let productImage = product_obj["image"] else { return }
                    guard let productPrice = product_obj["Price"]  else { return }
                    guard let productDescription = product_obj["Description"] else { return }
         
                    //Populate Product Arrays
         
                        let rowItem = Product()
                        rowItem.title = productTitle
                        rowItem.image = productImage
                        rowItem.price = productPrice
                        rowItem.desc = productDescription
         
         
                        productArray.append(rowItem)
         
                        tableData.append(productTitle)
         
                    }
                }
            }
        }
        
 */
        
        if let quakeList = json as? NSArray
        {
            for i in 0 ..< data_list.count
            {
                if let quake_obj = quakeList[i] as? NSDictionary
                {
                    if let quakeTitle = quake_obj["title"] as? String
                    
                        {
                            guard let quakeMagnitude = quake_obj["magnitude"] else { return }
                            guard let quakeDepth = quake_obj["depth"]  else { return }
                            guard let quakeLocation = quake_obj["location"] else { return }
                            guard let quakeLink = quake_obj["link"]  else { return }
                            
                            //Populate Quake Arrays
                            
                            let rowItem = Quake()
                            rowItem.title = quakeTitle
                            rowItem.magnitude = quakeMagnitude as! String
                            rowItem.depth = quakeDepth as! String
                            rowItem.location = quakeLocation as! String
                            rowItem.link = quakeLink as! String
                            
                            quakeArray.append(rowItem)
                            
                           
                            tableData.append(quakeTitle)
                            
                        }
                    
                }
            }
        }
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
        
    }


}
