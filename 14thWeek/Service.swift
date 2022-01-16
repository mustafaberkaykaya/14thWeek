//
//  Service.swift
//  14thWeek
//
//  Created by Mustafa Berkay Kaya on 16.01.2022.
//

import Foundation
import Alamofire

class Service {
    
    fileprivate var baseUrl = ""
    
    typealias CatPhotosCallBack = (_ photos:CatPhoto?,_ status:Bool, _ message: String) -> Void
    var callBackCat: CatPhotosCallBack?
    
    typealias DogPhotosCallBack = (_ photos:DogPhoto?,_ status:Bool, _ message: String) -> Void
    var callBackDog: DogPhotosCallBack?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getCatPhoto() {
        AF.request(self.baseUrl, method: .get).response { responseData in
            guard let data = responseData.data else { return }
            do {
                let photo = try JSONDecoder().decode(CatPhoto.self, from: data)
                self.callBackCat?(photo, true, "")
              //  print(photo.file)
            } catch {
                self.callBackCat?(nil, false, error.localizedDescription)
            }
        }
}
    
    func getDogPhoto() {
        AF.request(self.baseUrl, method: .get).response { responseData in
            guard let data = responseData.data else { return }
            do {
                let photo = try JSONDecoder().decode(DogPhoto.self, from: data)
                self.callBackDog?(photo, true ,"")
              //  print(photo.file)
            } catch {
                self.callBackDog?(nil,false,error.localizedDescription)
            }
        }
}
    
    
    
    func completionHandlerCat(callBack: @escaping CatPhotosCallBack) {
        self.callBackCat = callBack
    }
    
    func completionHandlerDog(callBack: @escaping DogPhotosCallBack) {
        self.callBackDog = callBack
    }
    
}
