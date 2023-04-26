//
//  user_default.swift
//  lego_map
//
//  Created by Motoki on 2023/04/25.
//

/*-------------------------------------------------------------------------------------
 --------userdefaultにデータを保存する---------
 write_userdefault(マップのX座標(Double),マップのY座標(Double),タイトル(String),メモの内容(String),日付(String),keyword(String))
 --------userdefaultからデータを読み出す---------
 read_userdefault(keyword(String)) -> 戻り値(マップのX座標(Double),マップのY座標(Double),タイトル(String),メモの内容(String),日付(String))
 --------userdefaultからデータを消す---------
 delete_userdefault(keyword(String))
 --------------------------------------------------------------------------------------*/


import Foundation

func write_userdefault(map_x: Double, map_y: Double, title: String!, text: String!, date: String, keyword: String){
    let savedata = [String(map_x), String(map_y), title, text, date]
    UserDefaults.standard.set(savedata, forKey: keyword)
    append_key(keyword: keyword)
}

func read_userdefault(keyword: String) -> (map_x: Double, map_y: Double, title: String, text: String, date: String){
    let readdata = UserDefaults.standard.stringArray(forKey: keyword) ?? ["","","E","E","E"]
    let arg1:Double = Double(readdata[0]) ?? 0
    let arg2:Double = Double(readdata[1]) ?? 0
    let arg3:String = String(readdata[2])
    let arg4:String = String(readdata[3])
    let arg5:String = String(readdata[4])
        
    return (arg1,arg2,arg3,arg4,arg5)
}
func delete_userdefault(keyword: String){
    UserDefaults.standard.removeObject(forKey: keyword)
    delete_key(keyword: keyword)
}

func append_key(keyword: String){
    var key_data = UserDefaults.standard.stringArray(forKey: "key_keyword") ?? []
    if key_data.contains(keyword){
        return
    }
    key_data.append(keyword)
    UserDefaults.standard.set(key_data, forKey: "key_keyword")
    print(key_data)
}

func delete_key(keyword: String){
    var key_data = UserDefaults.standard.stringArray(forKey: "key_keyword") ?? []
    key_data.removeAll(where: {$0 == keyword})
    UserDefaults.standard.set(key_data, forKey: "key_keyword")
    print(key_data)
}

func init_load() -> [Int: String]{
    var dict_hash_key: [Int: String] = [:]
    let key_data = UserDefaults.standard.stringArray(forKey: "key_keyword") ?? []
    for key_buf in key_data {
        let (map_x,map_y,title,text,date) = read_userdefault(keyword: key_buf)
        
        dict_hash_key[0/*hash*/] = key_buf
    }
    return dict_hash_key
}

func hash_to_keyword(hash: Int, dict_hash_key: [Int: String]) -> String{
    let buf: String = dict_hash_key[hash] ?? ""
    return buf
}

extension UserDefaults{
    func removeAll(){
        dictionaryRepresentation().forEach {removeObject(forKey: $0.key)}
    }
}
