//
//  user_default.swift
//  lego_map
//
//  Created by Motoki on 2023/04/25.
//

/*-------------------------------------------------------------------------------------
 --------userdefaultにデータを保存する---------
 write_userdefault(マップのX座標(Double),マップのY座標(Double),メモの内容(String),日付(String),forkey(String))
 --------userdefaultからデータを読み出す---------
 read_userdefault(keyword(String)) -> 戻り値(マップのX座標(Double),マップのY座標(Double),メモの内容(String),日付(String))
 --------userdefaultからデータを消す---------
 delete_userdefault(keyword(String))
 --------------------------------------------------------------------------------------*/


import Foundation

func write_userdefault(map_x: Double, map_y: Double, text: String, date: String, keyword: String){
    let savedata = [String(map_x), String(map_y), text, date]
    UserDefaults.standard.set(savedata, forKey: keyword)
}

func read_userdefault(keyword: String) -> (map_x: Double, map_y: Double,text: String, date: String){
    let readdata = UserDefaults.standard.stringArray(forKey: keyword) ?? ["","","errer","errer"]
    let arg1:Double = Double(readdata[0]) ?? 0
    let arg2:Double = Double(readdata[1]) ?? 0
    let arg3:String = String(readdata[2])
    let arg4:String = String(readdata[3])
        
    return (arg1,arg2,arg3,arg4)
}
func delete_userdefault(keyword: String){
    UserDefaults.standard.removeObject(forKey: keyword)
}
