//
//  ViewController.swift
//  14thWeek
//
//  Created by Mustafa Berkay Kaya on 11.01.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    private let tableView = UITableViewBuilder().build()
    private var photoCat: CatPhoto?
    private var photoDog: DogPhoto?
    private var photoUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            for _ in 1...5 {
                let service = Service(baseUrl: "https://aws.random.cat/meow")
                service.getCatPhoto()
                service.completionHandlerCat { [weak self] (photo, status, _) in
                    if status {
                       guard let self = self else { return }
                        guard let gelenphoto = photo else { return }
                        self.photoCat = gelenphoto
                        
                        if let data = photo?.file as String? {
                            self.photoUrls.append(data)
                            DispatchQueue.main.async {
                            self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        
        DispatchQueue.global().async {
            for _ in 1...5 {
                let service = Service(baseUrl: "https://random.dog/woof.json")
                service.getDogPhoto()
                service.completionHandlerDog { [weak self] (photo, status, _) in
                    if status {
                       guard let self = self else { return }
                        guard let gelenphoto = photo else { return }
                        self.photoDog = gelenphoto
                        
                        if let data = photo?.url as String? {
                            self.photoUrls.append(data)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        

        addSubViews()
    }
    
}

extension ViewController {
    
    private func addSubViews() {
        addTableView()
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.edgesToSuperview(usingSafeArea: true)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
       
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(photoUrls.count)
        return photoUrls.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell {
            DispatchQueue.main.async {
                cell.myImageView.kf.setImage(with: URL(string: self.photoUrls[indexPath.row]))
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
