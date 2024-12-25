object juego {

    //posibles posiciones en "x"
    const property posicionesX=[1,2,3,4,5,6,7]
    //

    //posicion en "y" inicial
    var property posicionY = 9
    //

    var property entidades = []
    var property auto = new Auto(position=game.origin(),tipo=1)
    var property moneda = new Moneda(position=game.origin())

    var property numeros=[]

    var property posicionesAleatorias=[]
    var property posiblesNumeros = []

    var property nAleatorios = []
    var property nAleatoriosSinRepetirLista = []

    var property contador = 0
    var property indice = 0
    var property total = 0

    var property numeroSeleccionado=0
    var property indiceDeInicio = 0
    
    //Parametros especificos para cada nivel

    var property level1 = new Level(dificultad=1,puntuacionNecesaria=0,position=game.at(-1,3),tiempoBorrar=1900,tiempoEntidad=1200,tiempoMover=700)
    var property level2 = new Level(dificultad=2,puntuacionNecesaria=100,position=game.at(-1,3),tiempoBorrar=1400,tiempoEntidad=1000,tiempoMover=400)
    var property prorider = new Level(dificultad=3,puntuacionNecesaria=200,position=game.at(0,3),tiempoBorrar=1000,tiempoEntidad=1000,tiempoMover=300)

    var property niveles = [level1,level2,prorider]
    var property nivelActual = level1
    var property nivelAnterior = level1

    method limpiar(){
        posicionesAleatorias.clear()
        posiblesNumeros.clear()
        nAleatorios.clear()
        nAleatoriosSinRepetirLista.clear()
        entidades.clear()
        numeros.clear()
    }

    method iniciar(){
        game.title("Pro Rider")
        game.width(9)
        game.height(9)
        game.cellSize(65)
        game.boardGround("camino1.png")
        self.configurarTeclas()
        game.addVisual(f1)
        game.addVisual(tabla)
        self.activar(level1)

        //Agrego entidades (cada nivel sabe el tiempo que tarda en bajar las entidades)
        game.onTick(self.nivelActual().tiempoEntidad(),"entidades",{
        //Bloque de codigo
            //Vector de posiciones aleatorias
            posicionesAleatorias=self.nAleatoriosSinRepetir(self.nivelActual().autosPorCelda()+1)

            //Aprovechamos el tercer parámetro "tipo" al agregar un auto
            self.agregarAuto(posicionesAleatorias.get(0),1)
            self.agregarAuto(posicionesAleatorias.get(1),2)
            self.agregarAuto(posicionesAleatorias.get(2),3)

            self.agregarMoneda(posicionesAleatorias.get(3))
             
        })


        //Hacer mover entidades
        game.onTick(self.nivelActual().tiempoMover(),"mover",{
            self.entidades().forEach({entidad=>entidad.mover()})
        })

        game.whenCollideDo(f1,{algo=>algo.esChocadoPor(f1)})

        game.start()
    }

    //Movimiento del auto (envío de mensajes)
    method configurarTeclas(){
        //Delego tarea de calcular el rango de movimiento de la f1 a "irA(nuevaPosicion)"
        keyboard.right().onPressDo{f1.irA(f1.position().right(1))}
        keyboard.left().onPressDo{f1.irA(f1.position().left(1))}
    }



    method actualizarNivelDe(formula1){
        nivelAnterior=nivelActual
        nivelActual=self.niveles().filter({nivel=>nivel.puntuacionNecesaria()==formula1.puntuacion()}).last()
        if(nivelActual!=nivelAnterior)self.activar(nivelActual)
        
    }

    method activar(nivel){
        game.addVisual(nivel)
        self.entidades().forEach({entidad=>game.removeVisual(entidad)})
        self.limpiar()
        game.schedule(self.nivelActual().tiempoBorrar(),{game.removeVisual(nivel)})
    }

    //Solamente se agregan autos con este metodo aprovechando el parametro "tipo"
    method agregarAuto(posicion,tipo){
        auto = new Auto(position=posicion,tipo=tipo)
        game.addVisual(auto)
        self.agregar(auto)
    }

    method agregarMoneda(posicion){
        moneda=new Moneda(position=posicion)
        game.addVisual(moneda)
        self.agregar(moneda)
    }
    
    method nAleatoriosSinRepetir(n){
        //Posibles numeros
        posiblesNumeros = [1,2,3,4,5,6,7,8]
        //
        nAleatorios.clear()
        n.times({ _ =>
        indice = 0.randomUpTo(posiblesNumeros.size().coerceToInteger() - 1).coerceToInteger()
        numeroSeleccionado = posiblesNumeros.get(indice)
        nAleatoriosSinRepetirLista.add(numeroSeleccionado)
        posiblesNumeros = posiblesNumeros.filter({ n => n != numeroSeleccionado })
    })
    
    return self.obtenerUltimosNDe(nAleatoriosSinRepetirLista,n)
    }
    method obtenerUltimosNDe(lista,n){
        total = lista.size().coerceToInteger()
        
        indiceDeInicio = total - n

        //Retorno una lista de posiciones en lugar de una lista de numeros
        return lista.drop(indiceDeInicio).take(n).map({numero=>game.at(numero,posicionY)})
    }


    method agregar(entidad){
        self.entidades().add(entidad)
    }

    //Hago un solo metodo para controlar ambos eventos (ganar y perder)
    method terminarCon(evento){
        game.addVisual(evento)
        game.removeVisual(f1)
        self.entidades().forEach({entidad=>game.removeVisual(entidad)})
        game.removeTickEvent("entidades")
        game.removeTickEvent("mover")
    }

}
//Agrego forma de ganar el juego para el usuario
object tabla{
    var property position = game.at(1,6)
    method image()="tabla12.png"
}
object victoria{
    var property position = game.at(0,3)
    method image()="gana.png"
}
object derrota{
    var property position = game.at(0,3)
    method image()="derrota10.png"
}
//Agrego clase Level utilizando el concepto de polimorfismo
class Level{
    var property puntuacionDeF1=0
    method image()="levelll".concat(dificultad)+"1.png"
    var property dificultad
    var property position
    var property puntuacionNecesaria
    var property tiempoBorrar
    var property tiempoEntidad
    var property tiempoMover
    //Autos por celda
    method autosPorCelda()= 2+dificultad
    method cumpleCondiciones(formula1){
        self.puntuacionDeF1(formula1.puntuacion())
        return formula1.puntuacion()==self.puntuacionNecesaria()
    }
}

object f1 {
    var property nivelActual = juego.level1()
    var property puntuacion = 0
    method image() = "f1man.png"

    var property position = game.at(1,0)

    //Delego tarea de calcular el rango de movimiento de la f1 a "irA(nuevaPosicion)"
    method irA(nuevaPosicion){
        self.position(game.at(nuevaPosicion.x().min(7).max(1),0))
    }

    method puntuarCon(moneda){
        self.puntuacion(self.puntuacion()+moneda.puntuacion())
        self.actualizarNivel()
        if(self.puntuacion()==300)juego.terminarCon(victoria)
        game.say(self,"".concat(self.puntuacion())+" puntos")
    }
    //Este metodo es para que el juego funcione un poco más rapido
    method puntajeDeNivel(){
        return self.puntuacion()==0 || self.puntuacion()==100 || self.puntuacion()==200
    }
    // 
    method actualizarNivel(){
        if(self.puntajeDeNivel())juego.actualizarNivelDe(self)else return
    }

}


class Auto{
    //Agrego el parametro "tipo" para evitar el error de crear muchas clases con el unico fin de cambiar la imagen del auto
    var property tipo
    var property position = game.origin()
    method image()="tipo"+tipo+".png"
    method esChocadoPor(formula1){
        juego.terminarCon(derrota)
    }
    //Utilizo el metodo down de forma simple.
    method mover(){
        self.position(self.position().down(1))
        self.actualizar()
    }
    method actualizar(){
        if (self.position().y()<0){
            game.removeVisual(self)
        }
    }
}

class Moneda{
    const property puntuacion=10
    var property position = game.origin()
    method image()="coin22.png"
    method esChocadoPor(formula1){
        formula1.puntuarCon(self)
        game.removeVisual(self)
    }
    //Utilizo metodo down de forma simple.
    method mover(){
        self.position(self.position().down(1))
        self.actualizar()
    }
    method actualizar(){
        if (self.position().y()<0){
            game.removeVisual(self)
        }
    }
}
