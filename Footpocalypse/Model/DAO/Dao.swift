//
//  Dao.swift
//  QuantoCusta
//
//  Created by Matheus on 1/22/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

class Dao {
    static let instance = Dao()
    private var tableType: String = "regularTable"
    private var money: Int = 0
    private var tableBought = [false, false, false]
    private var tableInUse = [true, false, false]
    private init() {}
    
    func setHighScore(score: Int) {
        UserDefaults.standard.set(score, forKey: "highScoreTableClicker")
    }
    
    func setmoney(money: Int) {
        self.money = money
    }
    
    func setTableType(tableType: String) {
        self.tableType = tableType
    }
    
    func tableBought(index: Int) {
        self.tableBought[index] = true
    }
    
    func setTableInUse(index: Int) {
        for i in 0...(self.tableInUse.count - 1) {
            self.tableInUse[i] = false
        }
        self.tableInUse[index] = true
    }
    
    func isTableInUse(index: Int) -> Bool {
        return self.tableInUse[index]
    }
    
    func isTableBought(index: Int) -> Bool {
        return self.tableBought[index]
    }
    
    func getTableType() -> String {
        return self.tableType
    }
    
    func getmoney() -> Int {
        return self.money
    }
    
    func getHighScore() -> Int {
        return UserDefaults.standard.integer(forKey: "highScoreTableClicker")
    }
}












