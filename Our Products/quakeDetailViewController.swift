//
//  quakeDetailViewController.swift
//  Our Products
//
//  Created by Tichafa Gava on 24/11/2016.
//  Copyright © 2016 Tichafa Gava - Ketts. All rights reserved.
//

import UIKit

class quakeDetailViewController: UIViewController {

    @IBOutlet weak var magnitudeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    @IBOutlet weak var doneDetail: UIButton!
    
    @IBAction func doneWithDetails(_ sender: Any) {
       
        self .dismiss(animated: true, completion: nil)
    }
   var  titleString  = ""
    var magnitudeString = ""
    var locationString = ""
    var linkString = ""
    var depthString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Rename labels from values received when this view was launched
        
        titleLabel.text = titleString
        magnitudeLabel.text = magnitudeString
        locationLabel.text = locationString
        linkLabel.text = linkString
        depthLabel.text = depthString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
