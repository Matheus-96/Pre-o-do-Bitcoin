//
//  ViewController.swift
//  Preco do Bitcoin
//
//  Created by Matheus Rodrigues Araujo on 24/10/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configura o endereco a API q será consumida
        if let url = URL(string: "https://blockchain.info/ticker") {
            
        
        //cria uma tarefa que ia consultar um servico da web por tempo indeterminado ate q tenha um retorno, sucesso ou erro
            /* dados =  retorno da api
                requisicao =  se deu certo ou nao
                erro =  erro que aconteceu */
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                if erro == nil {
                    print("Sucesso ao fazer a consulta de preço.")
                } else {
                    print("Erro ao fazer a consulta de preco.")
                }
            
            }
            tarefa.resume()
        } // fim do if
        
        
    }


}
