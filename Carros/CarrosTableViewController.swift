//
//  CarrosTableViewController.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 03/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//

import UIKit
import CoreData
class CarrosTableViewController: UITableViewController {
    var marcas: [Marcas] = []
    var modelos: [Modelos] = []
    var usuario: Usuarios?
    @IBOutlet weak var userLogged: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        userLogged.text = UserDefaults.standard.string(forKey: "nome")
        let rightBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleLogoff) )
              self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadDataOfTableView()
    }
    
    @objc private func handleLogoff() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        UserDefaults.standard.set(false, forKey: "signed")
        guard let logoffNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "LogoffNavigationController") as? LogoffNavigationController else
        {
            return
        }
        logoffNavigationVC.modalPresentationStyle = .fullScreen
        logoffNavigationVC.modalTransitionStyle = .flipHorizontal
        present(logoffNavigationVC,animated: true,completion: nil)
    }
    
    
    func reloadDataOfTableView() {
          do {
              if let marcas = try DatabaseController.persistentContainer.viewContext.fetch(Marcas.fetchRequest()) as? [Marcas] {
                let marcasFiltradas = marcas.filter {
                    $0.usuarios == DatabaseController.findUserByEmail(email: UserDefaults.standard.string(forKey: "email") ?? "")
                }
                  self.marcas = marcasFiltradas
              }
              if let modelos = try DatabaseController.persistentContainer.viewContext.fetch(Modelos.fetchRequest()) as? [Modelos] {
                          self.modelos = modelos
                      }
            
          } catch {
              print("Erro no banco, não conseguiu realizar a busca")
          }
          self.tableView.reloadData()
      }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return marcas.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
     let modelo = modelos.filter {
           $0.marcas == marcas[section]
       }
        return modelo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfTableView", for: indexPath)
        let modelo = modelos.filter {
            $0.marcas == marcas[indexPath.section]
        }
        cell.textLabel?.text = modelo[indexPath.row].nome


        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return marcas[section].nome! + " - " + marcas[section].tipo!
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
