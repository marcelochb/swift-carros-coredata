//
//  MarcasTableViewController.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 03/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//

import UIKit
import CoreData

class MarcasTableViewController: UITableViewController,UIPickerViewDelegate, UIPickerViewDataSource
{
    let utils = Utils()
    @IBOutlet weak var typesOfCar: UIPickerView!
    @IBOutlet weak var marcaTextField: UITextField! {
        didSet {
            marcaTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "marca")
        }
    }
    @IBOutlet weak var siglaTextField: UITextField! {
        didSet {
            siglaTextField.attributedPlaceholder = utils.placeHolderTextWithColor(placeHolderTextLabel: "sigla")
        }
    }
    
   
    var typesOfCarData: [String] = [String]()
    var selectedTypeOfCar = String()
    var marcasOfTableView: [Marcas] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.typesOfCar.delegate = self
        self.typesOfCar.dataSource = self
        typesOfCarData = ["Selecione o tipo:","Carro","Moto","Caminhão"]
        
        let titleFont = UIFont.systemFont(ofSize: 17.0)
        let title = UserDefaults.standard.string(forKey: "nome")

        let titleSize = title!.size(withAttributes: [.font: titleFont])

        let frame = CGRect(x: 0, y: 0, width: titleSize.width, height: 20.0)
        let titleLabel = UILabel(frame: frame)
        titleLabel.font = titleFont
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = title
        navigationItem.titleView = titleLabel

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadMarcaOfTableView()
    }
    

    @IBAction func saveMarca(_ sender: UIButton) {
        if let marca = NSEntityDescription.insertNewObject(forEntityName: "Marcas", into: DatabaseController.persistentContainer.viewContext) as? Marcas {
            marca.nome = marcaTextField.text
            marca.sigla = siglaTextField.text
            marca.tipo = selectedTypeOfCar
            marca.usuarios = DatabaseController.findUserByEmail(email: UserDefaults.standard.string(forKey: "email") ?? "")
            DatabaseController.saveContext()
            
            self.reloadMarcaOfTableView()
            
            let alert = UIAlertController(title: "Notificação", message: "Marca cadastrada com sucesso.", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                  NSLog("The \"OK\" alert occured.")
                  }))
                  self.present(alert, animated: true, completion: nil)

            
        }
        
        
        
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typesOfCarData.count
      }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typesOfCarData[row]
    }
      public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
      {
        let titleData = typesOfCarData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
          return myTitle
      }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTypeOfCar = typesOfCarData[row]
    }
    // MARK: - Table view data source
    
    func reloadMarcaOfTableView() {
          do {
              if let marcas = try DatabaseController.persistentContainer.viewContext.fetch(Marcas.fetchRequest()) as? [Marcas] {
                  self.marcasOfTableView = marcas
              }
          } catch {
              print("Erro no banco, não conseguiu realizar a busca")
          }
          self.tableView.reloadData()
      }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return marcasOfTableView.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfMarcaTableView", for: indexPath)

        let marca = marcasOfTableView[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.textLabel?.text = marca.sigla
        cell.detailTextLabel?.text = marca.nome

        return cell
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
