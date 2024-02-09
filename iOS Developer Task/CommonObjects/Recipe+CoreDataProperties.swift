//
//  Recipe+CoreDataProperties.swift
//  iOS Developer Task
//
//  Created by Владимир Костин on 08.02.2024.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var calories: Double
    @NSManaged public var imageId: UUID?
    @NSManaged public var instructions: String?
    @NSManaged public var name: String?

}

extension Recipe : Identifiable {
    func id() -> UUID {
        return imageId ?? UUID()
    }
}
