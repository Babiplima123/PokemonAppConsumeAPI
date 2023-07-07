//
//  PokemonViewModel.swift
//  pokemonApp09
//
//  Created by Barbara Lima on 04/07/23.
//

import Foundation
import SwiftUI

class PokemonViewModel: ObservableObject{
    @Published var pokemon =  [Pokemon]()
    
    let baseURL = "https://pokedex-bb36f.firebaseio.com//pokemon.json"
    
    init(){
        fetchData()
        print(pokemon)
    }
    
    func fetchData() {
        guard let url = URL(string: baseURL) else {return}
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            guard let data = data?.parseData(removeString: "null,") else {return}
            
            guard let pokemon = try? JSONDecoder().decode([Pokemon].self, from: data) else {return}
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
            
        }.resume()
        print(pokemon.count)
    }
    
    func backgroundColor(forType type: String) -> UIColor {
        switch type{
        case "fire": return .orange
        case "poison": return .purple
        case "water": return .blue
        case "electric": return .yellow
        case "psychic": return .brown
        case "normal": return .magenta
        case "ground": return .green
        case "flying": return .cyan
        case "fairy": return .systemTeal
        default: return .systemPink
        }
    }
}

extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        
        guard let data = parsedDataString?.data(using: .utf8) else { return nil}
        print("Here is the data")
        print(data)
        return data
    }
}



