class Enemy{
    var health = 100
    var attackDamage = 10
    
    init(health: Int = 100, attackDamage: Int = 10) {
        self.health = health
        self.attackDamage = attackDamage
    }
    
    func move(){
        print("camina alrededor")
        
    }
    
    func daño(cantidad : Int){
       health = health - cantidad
        
    }
    func attack(){
        print("lanza golpe y quita \(attackDamage) damage.")
    }
}
