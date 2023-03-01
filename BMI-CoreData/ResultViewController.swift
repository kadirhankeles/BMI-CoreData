//
//  ResultViewController.swift
//  BMI-CoreData
//
//  Created by Kadirhan Keles on 28.02.2023.
//

import UIKit
import CoreData
class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var newHeight: Float?
    var newWeight: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calculateBMI()
    }
    
    func calculateBMI() {
        let bmi = String(format: "%.1f", newWeight! / pow(newHeight!, 2))
        resultLabel.text = bmi
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        //Mevcut tarihi alma işlemleri
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateTime = formatter.string(from: currentDateTime)
        //Core Data işlemleri
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Value", into: context)
        
        newValue.setValue(resultLabel.text!, forKey: "bmi")
        newValue.setValue(dateTime, forKey: "date")
        newValue.setValue(UUID(), forKey: "id")
       
        do {
            try context.save()
            print("success")
        }catch {
            print("error")
        }
        
        performSegue(withIdentifier: "toSaveVC", sender: nil)
        
    }
    
    @IBAction func calculateClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
