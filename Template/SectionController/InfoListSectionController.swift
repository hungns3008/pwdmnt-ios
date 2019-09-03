//
//  ListSectionViewController.swift
//  Template
//
//  Created by Hung Nguyen on 8/26/19.
//  Copyright © 2019 Hung Nguyen. All rights reserved.
//

import Foundation
import IGListKit

final class InfoListSectionController: ListSectionController {
    
    var sectionControllerModel: SectionControllerModel!
    var dataSet = [InfoModel]()
    
    override init() {
        super.init()
    }
    
    func setDataSource(dataSet: [InfoModel]) {
        self.dataSet = dataSet
    }
    
    override func numberOfItems() -> Int {
        return dataSet.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        
        let content = "\(dataSet[index].title) - \(dataSet[index].name)"
        
        let size = TextSize.size(content, font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), width: width, insets: UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16))
        return CGSize(width: width, height: size.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell = collectionContext?.dequeueReusableCell(of: InfoCell.self, for: self, at: index) as! InfoCell
        let model = dataSet[index]
        cell.configure(viewModel: model)
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        self.sectionControllerModel = object as? SectionControllerModel
    }
    
    override func didSelectItem(at index: Int) {
        let model = dataSet[index]
        let controller = DetailController()
        controller.viewModel.detailModel = model
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
}
