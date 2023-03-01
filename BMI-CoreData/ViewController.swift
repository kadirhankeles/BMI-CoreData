//
//  ViewController.swift
//  BMI-CoreData
//
//  Created by Kadirhan Keles on 28.02.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    
    var height: Float?
    var weight: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        heightLabel.text = "\(height)cm"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weight = String(format: "%.0f", sender.value)
        weightLabel.text = "\(weight)Kg"
    }
    
    
    
    
    @IBAction func calculateClicked(_ sender: UIButton) {
         height = heightSlider.value
         weight = weightSlider.value
        performSegue(withIdentifier: "toResultVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.newHeight = height
            destinationVC.newWeight = weight
        }
    }
    
}

