import Foundation

/**
 The task is to implement the Shop protocol (you can do that in this file directly).
 - No database or any other storage is required, just store data in memory
 - No any smart search, use String method contains (case sensitive/insensitive - does not matter)
 – Performance optimizations for listProductsByName and listProductsByProducer are optional
 */

struct Product
{
  let id: String; // unique identifier
  let name: String;
  let producer: String;
}

protocol Shop
{
  /**
   Adds a new product object to the Shop.
   - Parameter product: product to add to the Shop
   - Returns: false if the product with same id already exists in the Shop, true – otherwise.
   */
  func addNewProduct(product: Product) -> Bool
  
  /**
   Deletes the product with the specified id from the Shop.
   - Returns: true if the product with same id existed in the Shop, false – otherwise.
   */
  func deleteProduct(id: String) -> Bool
  
  /**
   - Returns: 10 product names containing the specified string.
   If there are several products with the same name, producer's name is added to product's name in the format "<producer> - <product>",
   otherwise returns simply "<product>".
   */
  func listProductsByName(searchString: String) -> Set<String>
  
  /**
   - Returns: 10 product names whose producer contains the specified string,
   result is ordered by producers.
   */
  func listProductsByProducer(searchString: String) -> [String]
}

// TODO: your implementation goes here
class ShopImpl: Shop {
  
  var things = [String: Product]()
  
  
  func addNewProduct(product: Product) -> Bool
  {
    let thingID = product.id
    guard things[thingID] == nil else {return false}
    things[thingID] = product
    return true
  }
  
  
  func deleteProduct(id: String) -> Bool
  {
    let removeThings = things.removeValue(forKey: id)
    return removeThings == nil ? false : true
  }
  
  
  func listProductsByName(searchString: String) -> Set<String>
  {
    var product = Set<String>()
    let findeProduct = things.filter({$0.value.name.contains(searchString)})
    
    findeProduct.values.forEach { searchProducts in
      let prod = findeProduct.filter { thing in
        thing.value.name == searchProducts.name
      }
      
      if prod.count > 1
      {
        prod.forEach{
          product.insert("\($0.value.producer) - \($0.value.name)")
        }
      }else {
        product.insert(searchProducts.name)
      }
    }
    
    if product.count > 10
    {
      let slice = Array(product)[..<10]
      return Set(slice)
    }
    return product
  }
  
  
  
  func listProductsByProducer(searchString: String) -> [String]
  {
    let searchResult = things.filter({$0.value.producer.contains(searchString)})
    let sortedThingsArray = searchResult.sorted(by: {$0.value.producer < $1.value.producer })
    let thingsName = sortedThingsArray.map({$0.value.name})
    
    if thingsName.count > 10
    {
      let slice = thingsName[..<10]
      return Array(slice)
    }
    return thingsName
  }
  //-----------\\
}

func test(lib: Shop) {
  assert(!lib.deleteProduct(id: "1"))
  assert(lib.addNewProduct(product: Product(id: "1", name: "1", producer: "Lex")))
  assert(!lib.addNewProduct(product: Product(id: "1", name: "any name because we check id only", producer: "any producer")))
  assert(lib.deleteProduct(id: "1"))
  assert(lib.addNewProduct(product: Product(id: "3", name: "Some Product3", producer: "Some Producer2")))
  assert(lib.addNewProduct(product: Product(id: "4", name: "Some Product1", producer: "Some Producer3")))
  assert(lib.addNewProduct(product: Product(id: "2", name: "Some Product2", producer: "Some Producer2")))
  assert(lib.addNewProduct(product: Product(id: "1", name: "Some Product1", producer: "Some Producer1")))
  assert(lib.addNewProduct(product: Product(id: "5", name: "Other Product5", producer: "Other Producer4")))
  assert(lib.addNewProduct(product: Product(id: "6", name: "Other Product6", producer: "Other Producer4")))
  assert(lib.addNewProduct(product: Product(id: "7", name: "Other Product7", producer: "Other Producer4")))
  assert(lib.addNewProduct(product: Product(id: "8", name: "Other Product8", producer: "Other Producer4")))
  assert(lib.addNewProduct(product: Product(id: "9", name: "Other Product9", producer: "Other Producer4")))
  assert(lib.addNewProduct(product: Product(id: "10", name: "Other Product10", producer: "Other Producer4")))
  assert(lib.addNewProduct(product: Product(id: "11", name: "Other Product11", producer: "Other Producer4")))
  
  var byNames: Set<String> = lib.listProductsByName(searchString: "Product")
  assert(byNames.count == 10)
  
  byNames = lib.listProductsByName(searchString: "Some Product")
  assert(byNames.count == 4)
  assert(byNames.contains("Some Producer3 - Some Product1"))
  assert(byNames.contains("Some Product2"))
  assert(byNames.contains("Some Product3"))
  assert(!byNames.contains("Some Product1"))
  assert(byNames.contains("Some Producer1 - Some Product1"))
  
  var byProducer: [String] = lib.listProductsByProducer(searchString: "Producer")
  assert(byProducer.count == 10)
  
  byProducer = lib.listProductsByProducer(searchString: "Some Producer")
  assert(byProducer.count == 4)
  assert(byProducer[0] == "Some Product1")
  assert(byProducer[1] == "Some Product2" || byProducer[1] == "Some Product3")
  assert(byProducer[2] == "Some Product2" || byProducer[2] == "Some Product3")
  assert(byProducer[3] == "Some Product1")
}

test(lib: ShopImpl())



















--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


struct Product
{
  let id: String
  let name: String
  let producer: String
}


protocol Shop
{

  func addNewProcduct(product: Product)-> Bool
  func deleteProduct(id: String) -> Bool
  func listProductByName(seacrhString: String) -> Set<String>
  func listProdictByProducer(seacrhString: String) -> [String]


}



class ShopImpl: Shop
{

  var things = [String: Product]()

  func addNewProcduct(product: Product) -> Bool {
    let thingID = product.id
    guard things[thingID] == nil else {return false}
    things[thingID] = product
    return true
  }

  func deleteProduct(id: String) -> Bool {
    let removeThings = things.removeValue(forKey: id)
    print(removeThings == nil)
    return removeThings == nil ? false : true
    // false - если товара с таким id  нет, ну и  true - если товар с таким id есть
    // типо removeValue возвращает nil, и если это так, то тогда в моем return false, а если наоборот, то тогда true
  }

  func listProductByName(seacrhString: String) -> Set<String> {
    var product = Set<String>()
    let findeProduct = things.filter({$0.value.name.contains(seacrhString)})
    //      value - значение словаря
    //Проверка того, что объект находится в коллекции - contains. проверяю есть ли seacrhString в things

    findeProduct.values.forEach { searchProducts in
      let prod = findeProduct.filter { thing in
        thing.value.name == searchProducts.name
      }

      if prod.count > 1
      {
        prod.forEach{
          product.insert("\($0.value.producer) - \($0.value.name)") // Если есть несколько продуктов с одинаковым названием
        }
      }else{
        product.insert(searchProducts.name)
      }
    }

    if product.count > 10{
      let slice = Array(product)[..<10]
      return Set(slice)
    }
    return product

  }

  func listProdictByProducer(seacrhString: String) -> [String] {
    let searchResult = things.filter({$0.value.producer.contains(seacrhString)})
    let sortedThingArray = searchResult.sorted(by: {$0.value.producer < $1.value.producer }) // список в порядке возрастания размера производителя
    let thingName = sortedThingArray.map({$0.value.name})


    if thingName.count > 10{
      let slice = thingName[..<10]
      return Array(slice)
    }
    return thingName
  }


}



func test(lib: Shop){
  assert(!lib.deleteProduct(id: "1"))
  assert(lib.addNewProcduct(product: Product(id: "1", name: "КокаКола", producer: "Nestle")))
  assert(!lib.addNewProcduct(product: Product(id: "1", name: "ПепсиКола", producer: "Nestle")))
  assert(lib.deleteProduct(id: "1"))
  assert(lib.addNewProcduct(product: Product(id: "3", name: "Some Product3", producer: "Some Producer2")))
  assert(lib.addNewProcduct(product: Product(id: "4", name: "Some Product1", producer: "Some Producer3")))
  assert(lib.addNewProcduct(product: Product(id: "2", name: "Some Product2", producer: "Some Producer2")))
  assert(lib.addNewProcduct(product: Product(id: "1", name: "Some Product1", producer: "Some Producer1")))
  assert(lib.addNewProcduct(product: Product(id: "5", name: "Other Product5", producer: "Other Producer4")))
  assert(lib.addNewProcduct(product: Product(id: "6", name: "Other Product6", producer: "Other Producer4")))
  assert(lib.addNewProcduct(product: Product(id: "7", name: "Other Product7", producer: "Other Producer4")))
  assert(lib.addNewProcduct(product: Product(id: "8", name: "Other Product8", producer: "Other Producer4")))
  assert(lib.addNewProcduct(product: Product(id: "9", name: "Other Product9", producer: "Other Producer4")))
  assert(lib.addNewProcduct(product: Product(id: "10", name: "Other Product10", producer: "Other Producer4")))
  assert(lib.addNewProcduct(product: Product(id: "11", name: "Other Product11", producer: "Other Producer4")))


  var byNames: Set<String> = lib.listProductByName(seacrhString: "Product")
  assert(byNames.count == 10)

  byNames = lib.listProductByName(seacrhString: "Some Product")
  assert(byNames.count == 4)
  assert(byNames.contains("Some Producer3 - Some Product1"))
  assert(byNames.contains("Some Product2"))
  assert(byNames.contains("Some Product3"))
  assert(!byNames.contains("Some Product1"))
  assert(byNames.contains("Some Producer1 - Some Product1"))


  var byProducer: [String] = lib.listProdictByProducer(seacrhString: "Producer")
  assert(byProducer.count == 10)

  byProducer = lib.listProdictByProducer(seacrhString: "Some Producer")
  assert(byProducer.count == 4)
  assert(byProducer[0] == "Some Product1")
  assert(byProducer[1] == "Some Product2" || byProducer[1] == "Some Product3")
  assert(byProducer[2] == "Some Product2" || byProducer[2] == "Some Product3")
  assert(byProducer[3] == "Some Product1")
}

test(lib: ShopImpl())




