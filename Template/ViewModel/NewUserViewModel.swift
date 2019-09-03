//
//  NewUserViewModel.swift
//  Template
//
//  Created by Hung Nguyen on 8/26/19.
//  Copyright © 2019 Hung Nguyen. All rights reserved.
//

import RxSwift

final class NewUserViewModel {
    
    let disposeBag = DisposeBag()
    
    var errOb = PublishSubject<String?>()
    
    func processData(title: String?, username: String?, password: String?) -> InfoModel? {
        
        let validatedTitleData = validateData(dataType: "Title", s: title);
        let validatedUserData = validateData(dataType: "Username", s: username);
        let validatedPassData = validateData(dataType: "Password", s: password);
        
        if !validatedUserData.valid {
            errOb.onNext(validatedUserData.msg)
            return nil
        }
        
        if !validatedPassData.valid {
            errOb.onNext(validatedPassData.msg)
            return nil
        }
        
        if !validatedTitleData.valid {
            errOb.onNext(validatedTitleData.msg)
        }
        
        let infoModel = InfoModel()
        infoModel.title = title!
        infoModel.name = username!
        infoModel.password = password!
        
        return infoModel
    }
    
    func validateData(dataType: String, s: String?) -> (valid: Bool, msg: String) {
        
        if let s = s, s != "" {
            //validate 1
            //validate 1
            
            return (true, "")
        }
        
        return (false, "\(dataType) must has value")
    }
    
}
