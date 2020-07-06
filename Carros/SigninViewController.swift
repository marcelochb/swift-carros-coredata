//
//  SigninViewController.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 04/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    let utils = Utils()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
                passwordTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "senha")
            }
        }
    
    @IBOutlet weak var emailTextFiled: UITextField! {
        didSet {      
            emailTextFiled.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "e-mail")
        }
    }
    @IBAction func handleLogin(_ sender: UIButton) {
       navigateToMainScreen()
    }
    
    private func navigateToMainScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else {
            return
        }
        mainNavigationVC.modalPresentationStyle = .fullScreen
        mainNavigationVC.modalTransitionStyle = .flipHorizontal
        present(mainNavigationVC,animated: true,completion: nil)
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
