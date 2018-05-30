//
//  History.swift
//  Life Explorer
//
//  Created by Matheus Kerber Venturelli on 04/04/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation
import UIKit

/**********************************************
 *    Classe do histórico de descobertas
 ***********************************************/

class StoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var discoveryTable: UITableView!
    
    let identifier: String = "tableCell"
    var itemArray: [StoreItem] = [
        StoreItem(name: "Regular Table", shortDescription: "Price: 0", detailedDescription: "A regular citizen of the Table Kingdom that volunteered to fight in the war against feet.", imageName: "regularTable", price: 0, spriteImageName: "regularTable"),
        StoreItem(name: "Little Toe Distroyer", shortDescription: "Price: 15", detailedDescription: "A brave warrior of the Table Kingdom, capable of smashing little toes like no other.", imageName: "LittleToeDistroyerStore", price: 15, spriteImageName: "littleToeDistroyer"),
        StoreItem(name: "Dovahtable", shortDescription: "Price: 40", detailedDescription: "The highest order of warriors of the Table Kingdom. These tables were blessed with the power of dragons. The legends say they are so powerful that even walking is possible for them.", imageName: "movingTableStore", price: 40, spriteImageName: "movingTable")
    ]
    
    func setCustomTitle(){
        let texto = UILabel()
        texto.text = "Store"
        texto.font = UIFont(name: "Vision-Heavy", size: 20)
        texto.textColor = .black //UIColor(red:1.00, green:0.95, blue:0.92, alpha:1.0)
        texto.sizeToFit()
        let stackView = UIStackView(arrangedSubviews: [texto])
        stackView.axis = .horizontal
        stackView.frame.size.width = texto.frame.width
        stackView.frame.size.height = texto.frame.height
        
        navigationItem.titleView = stackView
    }
    
    func setCustomBackImage(){
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain , target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discoveryTable.delegate = self
        discoveryTable.dataSource = self
        let nav = self.navigationController?.navigationBar
        
        // 2
        //nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.black

        setCustomTitle()
        discoveryTable.reloadData()
    }
    
    
    /**********************************************
    *  ALTERAR ESSA FUNÇÃO PARA CUSTOMIZAR A CELULA
    ***********************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Para customizar a celula é necessário utilizar uma classe customizada de celula que herde de UITableViewCell (como a TableCell que tem nesse módulo
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! TableCell
        // adicionar as? TableCell aqui para utilizar a classe customizada
        
        // Inicializa as variáveis da célula, para utilizar a celula customizada, alterar essas linhas para as variaveis customizadas
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 6

        let image = UIImage(named: itemArray[indexPath.row].imageName)

        
        cell.viewImage?.image = image

        cell.viewText?.textColor = UIColor(red:1.00, green:0.95, blue:0.92, alpha:1.0)
        cell.viewText?.text = itemArray[indexPath.row].name
//        cell.viewSubText
        cell.viewText.font = UIFont(name: "Vision-Heavy", size: 25)
        cell.viewImage.layer.cornerRadius = cell.viewImage.frame.height / 6
        cell.viewSubText?.text = itemArray[indexPath.row].shortDescription
        cell.viewSubText?.textColor = UIColor(red:1.00, green:0.89, blue:0.79, alpha:1.0)
        cell.viewSubText.font = UIFont(name: "Vision", size: 15)
        // Retorna a celula pronta para a TableView apresentar ao usuário
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetail" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = .black

            let indexPath = discoveryTable!.indexPathForSelectedRow
            let destinationViewController: ItemDetailViewController = segue.destination as! ItemDetailViewController
            destinationViewController.descriptionText = itemArray[indexPath!.row].detailedDescription
            destinationViewController.enemyImageName = itemArray[indexPath!.row].imageName
            destinationViewController.itemIndex = indexPath!.row
            destinationViewController.price = itemArray[indexPath!.row].price
            destinationViewController.name = itemArray[indexPath!.row].name
            destinationViewController.spriteImageName = itemArray[indexPath!.row].spriteImageName
        }
    }
}
