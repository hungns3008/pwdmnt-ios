//
//  ViewController.swift
//  Template
//
//  Created by Hung Nguyen on 8/26/19.
//  Copyright © 2019 Hung Nguyen. All rights reserved.
//

import UIKit
import IGListKit
import PinLayout

class ViewController: UIViewController {
    
    var viewModel = InfoViewModel();
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    lazy var createUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Store new account", for: UIControl.State.normal)
        button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(createNewUser), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createUserButton)
        view.addSubview(collectionView)
        adapter.dataSource = self
        adapter.collectionView = collectionView
        
        viewModel.obRefresh.asObserver().subscribe(onNext: {[weak self] refresh in
            if let wSelf = self {
                wSelf.adapter.reloadData(completion: nil)
            }
        }).disposed(by: viewModel.disposeBag)
        
        viewModel.requestData.asObserver().subscribe(onNext: {[weak self] infoModel in
            if let wSelf = self {
                wSelf.viewModel.addNewData(infoModel: infoModel)
            }
        }).disposed(by: viewModel.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createUserButton.pin.bottomLeft().right().height(50)
        collectionView.pin.topLeft().right().above(of: createUserButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func createNewUser() {
        let controller = NewUserController()
        self.navigationController?.pushViewController(controller, animated: true)
    }


}

extension ViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.sectionControllers as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return viewModel.infoSectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        view.textColor = UIColor.lightGray
        view.textAlignment = .center
        view.text = "You don't have any data"
        return view
    }
    
}

