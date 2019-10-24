//
//  ViewController.swift
//  Preco do Bitcoin
//
//  Created by Matheus Rodrigues Araujo on 24/10/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var precoBitcoins: UILabel!
    @IBOutlet weak var botaoAtualizar: UIButton!
    
    @IBAction func atualizarPreco(_ sender: Any) {
        
        self.recuperarPrecoBitcoin()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recuperarPrecoBitcoin()
    }
    //formata o preco que será exibido na tela
    func formatarPreco (preco: NSNumber) -> String{
        
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco) {
            return precoFinal
        }
        return "0.00"
        
    }
    
    func recuperarPrecoBitcoin() {
        
        //muda o titulo do botao ao iniciar o carregamento dos dados
        self.botaoAtualizar.setTitle("Atualizando...", for: .normal)
        
        //configura o endereco a API q será consumida
        if let url = URL(string: "https://blockchain.info/ticker") {
            
        
        //cria uma tarefa que ia consultar um servico da web por tempo indeterminado ate q tenha um retorno, sucesso ou erro
            /* dados =  retorno da api
                requisicao =  se deu certo ou nao
                erro =  erro que aconteceu */
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                if erro == nil {
                    if let dadosRetorno = dados {
                        
                        do {
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: [] ) as? [String:Any] {
                                if let brl = objetoJson["BRL"] as? [String:Any] {
                                    if let preco = brl["buy"] as? Double {
                                        let precoFormatado = self.formatarPreco(preco: NSNumber(value: preco) )
                                        
                                        //queremos q nada mais seja executado até o fim do processo
                                        // esse codigo é necessario para atualizar a interface durante o precesso de uma closure
                                        DispatchQueue.main.async (execute: {
                                            self.precoBitcoins.text = "R$ " + precoFormatado
                                            self.botaoAtualizar.setTitle("Atualizar", for: .normal)
                                        })
                                    }
                                }
                            }
                        } catch  {
                            print("Erro ao formatar o retorno")
                        }
                    }
                } else {
                    print("Erro ao fazer a consulta de preco.")
                }
            
            }
            tarefa.resume()
        }
    }


}
