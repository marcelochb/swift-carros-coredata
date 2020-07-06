//
//  Modelos+CoreDataProperties.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 05/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension Modelos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Modelos> {
        return NSFetchRequest<Modelos>(entityName: "Modelos")
    }

    @NSManaged public var ano: Int16
    @NSManaged public var nome: String?
    @NSManaged public var marcas: Marcas?

}
