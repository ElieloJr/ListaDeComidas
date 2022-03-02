//
//  Refeicao.swift
//  Satisfacao
//
//  Created by Usr_Prime on 17/02/22.
//

import UIKit

class Refeicao: NSObject, NSCoding {
    var nome: String;
    var felicidade: String;
    var itens: Array<Item> = []
    
    init(nome:String, felicidade: String, itens: [Item] = []){
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    func totalDeCalorias() -> Double {
        var total = 0.0
        for item in itens {
            total += item.calorias
        }
        return total
    }
    func detalhes() -> String {
        var mensagem = "Felicidade: \(felicidade)"
        for item in itens {
            mensagem += ", \(item.nome) - calorias: \(item.calorias)"
        }
        return mensagem
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(felicidade, forKey: "felicidade")
        coder.encode(itens, forKey: "itens")
    }
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        felicidade = coder.decodeObject(forKey: "felicidade") as! String
        itens = coder.decodeObject(forKey: "itens") as! Array<Item>
    }
}
