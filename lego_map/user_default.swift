//
//  user_default.swift
//  lego_map
//
//  Created by Motoki on 2023/04/25.
//

import Foundation

func write_userdefault(map_x: Int, map_y: Int, text: String, keyword: String){
    let savedata = [String(map_x),String(map_y),text]
    UserDefaults.standard.set(savedata, forKey: keyword)
}

func read_userdefault(keyword: String) -> (map_x: Int, map_y: Int,text: String){
    let readdata = UserDefaults.standard.stringArray(forKey: keyword) ?? ["","","errer"]
    let arg1:Int = Int(readdata[0]) ?? -1
    let arg2:Int = Int(readdata[1]) ?? -1
    let arg3:String = String(readdata[2])
        
    return (arg1,arg2,arg3)
}
func delete_userdefault(keyword: String){
    UserDefaults.standard.removeObject(forKey: keyword)
}
