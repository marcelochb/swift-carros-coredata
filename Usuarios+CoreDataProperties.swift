//
//  Usuarios+CoreDataProperties.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 05/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension Usuarios {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuarios> {
        return NSFetchRequest<Usuarios>(entityName: "Usuarios")
    }

    @NSManaged public var nome: String?
    @NSManaged public var genero: String?
    @NSManaged public var idade: Int16
    @NSManaged public var cpf: String?
    @NSManaged public var email: String?
    @NSManaged public var senha: String?

}
