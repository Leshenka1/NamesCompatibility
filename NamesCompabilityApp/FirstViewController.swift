//
//  ViewController.swift
//  NamesCompabilityApp
//
//  Created by Алексей Зубель on 29.04.24.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var partnerNameTF: UITextField!
    @IBOutlet weak var yourNameTF: UITextField!
    @IBOutlet weak var historyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
        
    }
    
    @IBAction func resultButtonTapped() {
        guard let firstName = yourNameTF.text, let secondName = partnerNameTF.text else {return}
        if firstName.isEmpty || secondName.isEmpty{
            showAlert(title: "Names are missing", message: "Please enter both names 🫤")
        } else {
            performSegue(withIdentifier: "goToResult", sender: nil)
        }
        
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToFirstVC(segue: UIStoryboardSegue){
//        guard segue.identifier == "unwindSegue" else {return}
        
        yourNameTF.text = ""
        partnerNameTF.text = ""
        
        guard let sourceVC = segue.source as? ResultViewController else {return}

        historyLabel.text = "Here you can see your history:\n\(sourceVC.namesLabel.text ?? "no history(")"
    }
    
}

extension FirstViewController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
         
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF{
            partnerNameTF.becomeFirstResponder()
        }
        else{
            resultButtonTapped()
        }
        return true
    }
}

extension FirstViewController{
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
