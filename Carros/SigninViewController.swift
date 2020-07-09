//
//  SigninViewController.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 04/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//

import UIKit
import CoreData

class SigninViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let utils = Utils()
    var usuarios: [Usuarios] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //defaults.set(false, forKey: "signed") //logoff
        if defaults.bool(forKey: "signed"), defaults.string(forKey: "email") != nil, defaults.string(forKey: "nome") != nil {
                        navigateToMainScreen()
        }
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
        
        if verifyUserAndPassoword() {
            navigateToMainScreen()
        } else {
            let alert = UIAlertController(title: "Notificação", message: "Usuário ou senha não encontrada, verifica seus dados!", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                   NSLog("The \"OK\" alert occured.")
                   }))
                   self.present(alert, animated: true, completion: nil)
        }
        
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
    
    private func verifyUserAndPassoword() -> Bool {
        var retorno = false
        if let usuario = DatabaseController.verifySignin(email: emailTextFiled.text ?? "", senha: passwordTextField.text ?? "")
        {
            defaults.set(usuario.email, forKey: "email")
            defaults.set(usuario.nome, forKey: "nome")
            defaults.set(true, forKey: "signed")
            retorno = true

        }
        return retorno
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
