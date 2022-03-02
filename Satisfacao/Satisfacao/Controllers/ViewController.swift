//
//  ViewController.swift
//  Satisfacao
//
//  Created by Usr_Prime on 17/02/22.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController {
    
    var delegate: AdicionaRefeicaoDelegate?
    var pode = true
    var itens: [Item] = []
    var itensSelecionados: [Item] = []
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var felicidadeTextField: UITextField!
    @IBOutlet weak var msgErroLabel: UILabel!
    @IBOutlet weak var itensTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let botaoAdicionaItem = UIBarButtonItem(title: "Novo Item", style: .plain, target: self, action: #selector(adicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        itens = ItemDAO().recupera()
    }
    @objc func adicionarItem() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }

    @IBAction func Add(_ sender: Any) {
        
        if let nome = nomeTextField.text, let felicidade = felicidadeTextField.text {
            if nome == "" || felicidade == "" {
                Alerta(controller: self).exibe(message: "Preencha o todos os campos")
            } else {
                let refeicao = Refeicao(nome:nome, felicidade: felicidade, itens: itensSelecionados)
                    delegate?.add(refeicao)
                    navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        celula.textLabel?.text = item.nome
        return celula
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        } else {
            celula.accessoryType = .none
            if let position = itensSelecionados.firstIndex(of: itens[indexPath.row]) {
                itensSelecionados.remove(at: position)
            }
        }
    }
}

extension ViewController: AdicionarItensDelegate {
    func add(_ item: Item) {
        itens.append(item)
        ItemDAO().save(itens)
        if let tableView = itensTableView {
            tableView.reloadData()
        } else {
            Alerta(controller: self)
                .exibe(title: "Desculpe", message: "não foi criar o novo item")
        }
    }
}
