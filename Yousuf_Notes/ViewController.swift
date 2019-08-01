//
//  ViewController.swift
//  Yousuf_Notes
//
//  Created by khawar on 7/21/19.
//  Copyright © 2019 khawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.reloadData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addNoteSegue"){
            let popup = segue.destination as! AddNoteViewController
            popup.doneSaving = {[weak self] in
                guard let self = self else {return}
                getData()
                self.tableView.reloadData()
            }
        }
    }
    
}

func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do{
        Data.noteModels = try context.fetch(NoteModel.fetchRequest())
    }catch{
        print("fetching data from core data")
    }
}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Data.noteModels.count)
        return Data.noteModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = Data.noteModels[indexPath.row].title
        cell.detailTextLabel?.text = Data.noteModels[indexPath.row].text
        return cell
    }
    
    
}

