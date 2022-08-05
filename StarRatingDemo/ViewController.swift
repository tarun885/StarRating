//
//  ViewController.swift
//  StarRatingDemo
//
//  Created by Tarun Jain on 29/07/22.
//

import UIKit
import StarRating

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Programmatic
        let frame = CGRect(x: 0, y: 250, width: 300, height: 50)
        let starView = StarRating(frame: frame, totalStars: 5, selectedStars: 1)
        starView.addTarget(self, action: #selector(starRatingValueChanged(_:)), for: .valueChanged)
        starView.center = view.center
        view.addSubview(starView)
        
    }
    
    @objc @IBAction func starRatingValueChanged(_ sender: StarRating) {
        print("Selected \(sender.selectedStars), out of \(sender.totalStars)")
    }

}
