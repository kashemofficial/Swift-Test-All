//
//  ViewController.swift
//  namata textfield,view,button
//
//  Created by Abul Kashem on 12/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        //multiplicationTableCalculation1()
        multiplicationTableCalculation2()
    }
    
    func multiplicationTableCalculation1(){
        let n = Int(textField.text!)!
        textView.text = "Multiplication Table Calculation \(n) in textview\n"
        for i in 1...10 {
            textView.text += " \(n) * \(i) = \(n*i)\n"
        }
    }
    
    func multiplicationTableCalculation2(){
        let n = Int(textField.text!)!
        var c = 0
        textView.text = "Multiplication Table Calculation \(n) in textview\n"
        for i in 1...10{
            c+=n
            textView.text += " \(n) * \(i) = \(c)\n"
        }
    }
}

