//
//  SaveViewController.swift
//  BMI-CoreData
//
//  Created by Kadirhan Keles on 1.03.2023.
//

import UIKit
import CoreData
class SaveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var bmiArray = [String]()
    var idArray = [UUID]()
    var dateArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Value")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            //Tek bir sonuca odaklanmak için NSManagedObject kullandık.
            for result in results as! [NSManagedObject] {
                if let bmi = result.value(forKey: "bmi") as? String {
                    self.bmiArray.append(bmi)
                }
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                if let date = result.value(forKey: "date") as? String {
                    self.dateArray.append(date)
                }
                
                self.tableView.reloadData()
            }
        }catch {
            print("error")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = bmiArray[indexPath.row]
        content.secondaryText = dateArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Value")
          let idString = idArray[indexPath.row].uuidString
          fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
          fetchRequest.returnsObjectsAsFaults = false
          
          
          do{
              let results = try context.fetch(fetchRequest)
              if results.count > 0 {
                  for result in results as! [NSManagedObject] {
                      if let id = result.value(forKey: "id") as? UUID {
                          if id == idArray[indexPath.row]{
                              context.delete(result)
                              bmiArray.remove(at: indexPath.row)
                              idArray.remove(at: indexPath.row)
                              dateArray.remove(at: indexPath.row)
                              self.tableView.reloadData()
                              
                              do {
                                  try context.save()
                              }catch {
                                  print("error")
                              }
                              
                          }
                      }
                  }
              }
          }catch{
              
          }
      }
    }

}
