//
//  SignupViewController.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 04/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//

import UIKit
import CoreData

class SignupViewController: UIViewController {
    var user: Usuarios?
    let utils = Utils()

    @IBOutlet weak var nomeTextField: UITextField! {
        didSet {
            nomeTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "nome")
        }
    }
    @IBOutlet weak var generoTextField: UITextField! {
        didSet {
            generoTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "genero")
        }
    }
    @IBOutlet weak var idadeTextField: UITextField! {
        didSet {
            idadeTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "idade")
        }
    }
    @IBOutlet weak var cpfTextField: UITextField! {
        didSet {
            cpfTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "cpf")
        }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "e-mail")
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "senha")
        }
    }
    
    
    @IBAction func saveUserButton(_ sender: UIButton) {
        
        if let emailAlreadyExists = DatabaseController.findUserByEmail(email: emailTextField.text ?? "")
        {
            let alert = UIAlertController(title: "Notificação", message: "E-mail \(emailAlreadyExists.email!) já foi cadastrado, utilize outro!.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
               NSLog("The \"OK\" alert occured.")
               }))
               self.present(alert, animated: true, completion: nil)

        } else {
               if let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuarios", into: DatabaseController.persistentContainer.viewContext) as? Usuarios {
                   usuario.nome = nomeTextField.text
                   usuario.genero = generoTextField.text
                   usuario.cpf = cpfTextField.text
                   usuario.email = emailTextField.text
                   usuario.senha = passwordTextField.text
                   user = usuario
                   DatabaseController.saveContext()
               }
               
            let alert = UIAlertController(title: "Notificação", message: "Usuário cadastrado com sucesso.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
               NSLog("The \"OK\" alert occured.")
               }))
               self.present(alert, animated: true, completion: nil)

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
