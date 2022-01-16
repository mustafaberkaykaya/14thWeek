//
//  ViewController.swift
//  14thWeek
//
//  Created by Mustafa Berkay Kaya on 11.01.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

class ViewController: UIViewController {

    private let tableView = UITableViewBuilder().build()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        
        let service = Service(baseUrl: "https://aws.random.cat/meow")
        print(service.getPhoto())
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell {
            return cell
        }
        
        return UITableViewCell()
        
    }

}
