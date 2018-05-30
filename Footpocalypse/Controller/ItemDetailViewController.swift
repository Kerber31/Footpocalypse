//
//  ItemDetailViewController.swift
//  Footpocalypse
//
//  Created by Matheus Kerber Venturelli on 16/05/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var useButton: UIButton!
    var price: Int?
    var itemIndex: Int?
    var enemyImageName: String?
    var spriteImageName: String?
    var descriptionText: String?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = UIImage(named: enemyImageName!)
        detailText.text = descriptionText
        detailText.textColor = UIColor(red:1.00, green:0.89, blue:0.79, alpha:1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buyButtonAction(_ sender: Any) {
        Dao.instance.setmoney(money: Dao.instance.getmoney() - self.price!)
        Dao.instance.tableBought(index: self.itemIndex!)
        useButton.isEnabled = true
        buyButton.isEnabled = false
        ButtonClick.instance.playButtonSound()
    }
    
    @IBAction func usebuttonAction(_ sender: Any) {
        Dao.instance.setTableType(tableType: self.spriteImageName!)
        Dao.instance.setTableInUse(index: self.itemIndex!)
        useButton.isEnabled = false
        ButtonClick.instance.playButtonSound()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setCustomTitle()
        if Dao.instance.isTableBought(index: self.itemIndex!) {
            buyButton.isEnabled = false
            if Dao.instance.isTableInUse(index: self.itemIndex!) {
                useButton.isEnabled = false
            }
            else {
                useButton.isEnabled = true
            }
        }
        else {
            if Dao.instance.getmoney() < self.price! {
                buyButton.isEnabled = false
            }
        }
    }
    
    func setCustomTitle(){
        let texto = UILabel()
        texto.text = self.name!
        texto.font = UIFont(name: "Vision-Heavy", size: 20)
        texto.textColor = .black //UIColor(red:1.00, green:0.95, blue:0.92, alpha:1.0)
        texto.sizeToFit()
        let stackView = UIStackView(arrangedSubviews: [texto])
        stackView.axis = .horizontal
        stackView.frame.size.width = texto.frame.width
        stackView.frame.size.height = texto.frame.height
        
        navigationItem.titleView = stackView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
