//
//  Marcas+CoreDataProperties.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 05/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension Marcas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Marcas> {
        return NSFetchRequest<Marcas>(entityName: "Marcas")
    }

    @NSManaged public var nome: String?
    @NSManaged public var sigla: String?
    @NSManaged public var tipo: String?
    @NSManaged public var usuarios: Usuarios?

}
