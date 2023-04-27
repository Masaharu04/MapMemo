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
}

func delete_key(keyword: String){
    var key_data = UserDefaults.standard.stringArray(forKey: "key_keyword") ?? []
    key_data.removeAll(where: {$0 == keyword})
    UserDefaults.standard.set(key_data, forKey: "key_keyword")
}

func hash_to_keyword(hash_num: Int, dict_hash_key: [Int: String]) -> String{
    let buf: String = dict_hash_key[hash_num] ?? ""
    return buf
}

func save_data(dict_hash_key: [Int: String], hash_num: Int,map_x: Double, map_y: Double, title: String!, text: String!, date: String) -> [Int: String]{
    var i: Int = 0
    var dict_hash_key: [Int: String] = dict_hash_key
    while (dict_hash_key.values.contains(String(i))){
        i += 1
    }
    dict_hash_key[hash_num] = String(i)
    append_key(keyword: String(i))
    write_userdefault(map_x: map_x, map_y: map_y, title: title, text: text, date: date, keyword: String(i))
    return dict_hash_key
}

func load_data(dict_hash_key: [Int: String],hash_num: Int) -> (map_x: Double, map_y: Double, title: String, text: String, date: String){
    let keyword = hash_to_keyword(hash_num: hash_num, dict_hash_key: dict_hash_key)
    let (map_x, map_y, title, text, date) = read_userdefault(keyword: keyword)
    return (map_x, map_y, title, text, date)
}

func delete_data(dict_hash_key: [Int: String],hash_num: Int) -> [Int: String]{
    var dict_hash_key: [Int: String] = dict_hash_key
    let keyword = hash_to_keyword(hash_num: hash_num, dict_hash_key: dict_hash_key)
    dict_hash_key.removeValue(forKey: hash_num)
    delete_key(keyword: keyword)
    delete_userdefault(keyword: keyword)
    return dict_hash_key
}




extension UserDefaults{
    func removeAll(){
        dictionaryRepresentation().forEach {removeObject(forKey: $0.key)}
    }
}
