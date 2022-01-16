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
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getPhoto() {
        DispatchQueue.global(qos: .background).async {
            AF.request(self.baseUrl, method: .get).response { responseData in
                guard let data = responseData.data else { return }
                do {
                    let photo = try JSONDecoder().decode(CatPhoto.self, from: data)
                    print(photo.file)
                } catch {
                    print(error)
                }
            }
        }
}
}
