//
//  AddNoteViewController.swift
//  Yousuf_Notes
//
//  Created by khawar on 7/21/19.
//  Copyright © 2019 khawar. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var doneSaving: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 4
        
        titleField.layer.borderColor = UIColor.lightGray.cgColor
        titleField.layer.borderWidth = 1
        titleField.layer.cornerRadius = 4
        
        textView.textColor = UIColor.lightGray
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 4
        
        textView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        let title = titleField.text
        let description = textView.text
        if title == "" {
            let alert = UIAlertController(title: "Title is required", message: "You need to write title for your note", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let note = NoteModel(context: context)
        note.id = UUID()
        note.title = title
        note.text = description
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//        let noteModel = NoteModel(title: title, description: description)
//        NoteFunctions.createNote(nodeModel: noteModel)
        if let doneSaving = doneSaving{
            doneSaving()
        }
        dismiss(animated: true)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}

extension AddNoteViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}
