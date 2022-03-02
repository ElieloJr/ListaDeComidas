//
//  RemoveRefeicaoViewController.swift
//  Satisfacao
//
//  Created by Usr_Prime on 21/02/22.
//

import UIKit

class RemoveRefeicaoViewController {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        
        let botaoCancelar = UIAlertAction(title: "cancelar", style: .cancel)
        let botaoRemover = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        
        alerta.addAction(botaoRemover)
        alerta.addAction(botaoCancelar)
        
        controller.present(alerta, animated: true, completion: nil)
    }
}
