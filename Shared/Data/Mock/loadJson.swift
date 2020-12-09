
import Foundation

let drinksData : [Drink] = load("drinks.json")
let ordersData : [Order] = load("order.json") 

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("不能找到 \(filename) .")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("无法加载 \(filename) 来自\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("无法解析 \(filename) 在 \(T.self):\n\(error)")
    }
}



