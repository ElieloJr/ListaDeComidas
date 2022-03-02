//
//  AdicionarItensViewController.swift
//  Satisfacao
//
//  Created by Usr_Prime on 18/02/22.
//

import UIKit

protocol AdicionarItensDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    var delegate: AdicionarItensDelegate?
    
    @IBOutlet weak var nomeItem: UITextField!
    @IBOutlet weak var caloriaItem: UITextField!
    
    init(delegate: AdicionarItensDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func adicionarItem(_ sender: Any) {
        guard let nome = nomeItem.text, let caloria = caloriaItem.text else { return }
        if let numeroDeCalorias = Double(caloria) {
            let item = Item(nome: nome, calorias: numeroDeCalorias)
            if let delegate = delegate {
                delegate.add(item)
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
