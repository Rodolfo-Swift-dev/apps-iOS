
class Dragon : Enemy{
    var firePower = 30
    
    func fly(){
       print("El dragon esta volando")
    }
    override func move() {
        super.move()
        print("el dragon se arrastra por el suelo")
    }
}
