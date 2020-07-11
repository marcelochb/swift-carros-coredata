//
//  Marcas+CoreDataProperties.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 11/07/20.
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
    @NSManaged public var modelos: NSSet?

}

// MARK: Generated accessors for modelos
extension Marcas {

    @objc(addModelosObject:)
    @NSManaged public func addToModelos(_ value: Modelos)

    @objc(removeModelosObject:)
    @NSManaged public func removeFromModelos(_ value: Modelos)

    @objc(addModelos:)
    @NSManaged public func addToModelos(_ values: NSSet)

    @objc(removeModelos:)
    @NSManaged public func removeFromModelos(_ values: NSSet)

}
