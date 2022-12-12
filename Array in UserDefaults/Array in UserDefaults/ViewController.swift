//
//  ViewController.swift
//  Array in UserDefaults
//
//  Created by Abul Kashem on 11/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableVIew: UITableView!
    var toDoArray = [String]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpTableView()
    
        if let data = UserDefaults.standard.object(forKey: "toDoArray") as? [String] {
            toDoArray = data
        }
        tableVIew.reloadData()
    }
    
    func setUpTableView(){
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableVIew.register(nib, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        toDoArray.append(nameTextField.text!)
        UserDefaults.standard.set(toDoArray, forKey: "toDoArray")
        tableVIew.reloadData()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = toDoArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let userDefaults = UserDefaults.standard
            userDefaults.set(toDoArray, forKey: "toDoArray")
        }
    }
    
}
