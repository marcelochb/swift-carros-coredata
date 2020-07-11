//
//  ModeloTableViewController.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 03/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//

import UIKit
import CoreData

class ModeloTableViewController: UITableViewController {
    let utils = Utils()
    var modelosOfTableView: [Modelos] = []
    
    @IBOutlet weak var marcaLabel: UILabel!
    
    @IBOutlet weak var modeloTextField: UITextField! {
        didSet {
            modeloTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "modelo")
        }
    }
    
    @IBOutlet weak var anoTextField: UITextField! {
        didSet {
            anoTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "ano")
        }
    }
    var modelos: [Modelos] = []
    var marca: Marcas?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //  self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        marcaLabel.text = (marca?.nome)! + " - " + (marca?.sigla)!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadModeloOfTableView()
    }

    
    @IBAction func salvarModelo(_ sender: UIButton)
    {
        if let modelo = NSEntityDescription.insertNewObject(forEntityName: "Modelos", into: DatabaseController.persistentContainer.viewContext) as? Modelos
        {
            modelo.nome = modeloTextField.text
            modelo.ano = Int16(anoTextField.text!)!
            modelo.marcas = marca
            DatabaseController.saveContext()
            modeloTextField.text = ""
            anoTextField.text = ""
            self.reloadModeloOfTableView()
            
            let alert = UIAlertController(title: "Notificação", message: "Modelo cadastrado com sucesso.", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                  NSLog("The \"OK\" alert occured.")
                  }))
                  self.present(alert, animated: true, completion: nil)

            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelosOfTableView.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfModelTableView", for: indexPath)
        let modelo = modelosOfTableView[indexPath.row]
        cell.textLabel?.text = modelo.nome
        cell.detailTextLabel?.text = String(modelo.ano)
        

        return cell
    }
    
    func reloadModeloOfTableView() {
          do {
            if let modelos = try DatabaseController.persistentContainer.viewContext.fetch(Modelos.fetchRequest()) as? [Modelos] {
                let modelosFiltrado = modelos.filter {
                    $0.marcas == self.marca
                }
                  self.modelosOfTableView = modelosFiltrado
              }
          } catch {
              print("Erro no banco, não conseguiu realizar a busca")
          }
          self.tableView.reloadData()
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
