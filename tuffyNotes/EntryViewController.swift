import UIKit
import Firebase

class EntryViewController: UIViewController {
    let database = Firestore.firestore()

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!

    public var completion: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        let docRef = database.document("tuffyNotes/noteTitle")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            print(data)
        }
    }

    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
            saveData(text: text)
            
        }
    }
    func saveData(text: String) {
        let docRef = database.document("tuffyNotes/noteTitle")
        docRef.setData(["text": text])
    }
}

