//
//  ViewModel.swift
//  Template
//
//  Created by Hung Nguyen on 8/26/19.
//  Copyright © 2019 Hung Nguyen. All rights reserved.
//

import RxSwift

final class InfoViewModel {
    
    let disposeBag = DisposeBag()
    
    var sectionControllers = [SectionControllerModel]()
    
    lazy var infoSectionController: InfoListSectionController = {
        return InfoListSectionController()
    }()
    
    var infoData = [InfoModel]()
    
    var obRefresh = PublishSubject<Bool>()
    
    var requestData = PublishSubject<InfoModel>()
    
    init() {
        sectionControllers.append(SectionControllerModel(sectionName: "Info", sectionIndex: 0))
    }
    
    func addNewData(infoModel: InfoModel) {
        infoData.append(infoModel)
        infoSectionController.setDataSource(dataSet: infoData)
        obRefresh.onNext(true)
    }
    
    
}
