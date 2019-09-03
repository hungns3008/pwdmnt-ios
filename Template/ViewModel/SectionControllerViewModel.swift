//
//  SectionControllerViewModel.swift
//  Template
//
//  Created by Hung Nguyen on 8/26/19.
//  Copyright © 2019 Hung Nguyen. All rights reserved.
//

import IGListKit

final class SectionControllerModel {
    
    var sectionName: String
    var sectionIndex: Int
    
    init(sectionName: String, sectionIndex: Int = 0) {
        self.sectionName = sectionName
        self.sectionIndex = sectionIndex
    }
}

extension SectionControllerModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self as! NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : false
    }
    
}
