//
//  Usuarios+CoreDataProperties.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 11/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension Usuarios {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuarios> {
        return NSFetchRequest<Usuarios>(entityName: "Usuarios")
    }

    @NSManaged public var cpf: String?
    @NSManaged public var email: String?
    @NSManaged public var genero: String?
    @NSManaged public var idade: Int16
    @NSManaged public var nome: String?
    @NSManaged public var senha: String?
    @NSManaged public var marcas: NSSet?

}

// MARK: Generated accessors for marcas
extension Usuarios {

    @objc(addMarcasObject:)
    @NSManaged public func addToMarcas(_ value: Marcas)

    @objc(removeMarcasObject:)
    @NSManaged public func removeFromMarcas(_ value: Marcas)

    @objc(addMarcas:)
    @NSManaged public func addToMarcas(_ values: NSSet)

    @objc(removeMarcas:)
    @NSManaged public func removeFromMarcas(_ values: NSSet)

}
