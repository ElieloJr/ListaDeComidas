//
//  RefeicoesTableViewController.swift
//  Satisfacao
//
//  Created by Usr_Prime on 17/02/22.
//

import UIKit

class RefeicoesTableViewController: UITableViewController {
    var refeicoes: [Refeicao] = []
    
    override func viewDidLoad() {
        refeicoes = RefeicaoDAO().recupera()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails(_:)))
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    @objc func showDetails(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexpath = tableView.indexPath(for: celula) else { return }
            let refeicao = refeicoes[indexpath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao,
                handler: { alerta in
                    self.refeicoes.remove(at: indexpath.row)
                    self.tableView.reloadData()
                })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}

extension RefeicoesTableViewController: AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao){
        refeicoes.append(refeicao)
        tableView.reloadData()
        
        RefeicaoDAO().save(refeicoes)
    }
}
