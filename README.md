# Wollok Game: Pro Rider

<h2>Objetivo</h2>
El objetivo de este juego es utilizar conceptos del paradigma de programación orientado a objetos; polimorfismo, envío de mensajes, encapsulamiento, clases, objetos, atributos, métodos, herencia y abstracción. Este trata sobre esquivar obstáculos (autos) para capturar la mayor cantidad de monedas posibles y poder así pasar de nivel y ganar el juego (a medida que el nivel aumenta, los autos pasan más rápido).
<br>
<h3>Requerimientos para cada nivel:</h3>
<table>
    <thead>
      <tr>
        <th></th>
        <th>Nivel 1</th>
        <th>Nivel 2</th>
        <th>Nivel "Prorider"</th>
        <th>Ganar</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Puntos (1 Moneda = 10 Puntos)</td>
        <td>0</td>
        <td>100</td>
        <td>200</td>
        <td>300</td>
      </tr>
    </tbody>
</table>

<h2>Imagen del juego</h2>
<img src="https://github.com/user-attachments/assets/3f3d7da5-32d1-4b01-8aad-11c6343b8759" alt="img1" width="600px"/>

<h2>Movimiento</h2>
<p>Presionar las teclas
  <kbd>&larr;</kbd> y <kbd>&rarr;</kbd>
  para moverse hacia la izquierda y derecha respectivamente.
</p>

<h2>Estructura general del código</h2>
  <p><strong>Objeto principal (juego):</strong> Gestiona la lógica central, niveles, entidades, eventos y la configuración del juego.</p>
  <p><strong>Clases auxiliares (Level, Auto, Moneda):</strong> Modelan las entidades del juego.</p>
  <p><strong>Objetos visuales (f1, victoria, derrota):</strong> Representan el estado del juego (auto principal, pantalla de victoria, pantalla de derrota).</p>
  <p><strong>Eventos periódicos (onTick):</strong> Se generan entidades (autos y monedas) y se actualizan sus posiciones periódicamente.</p>
<h2>Generación Aleatoria de Entidades</h2>
Se utiliza el método <strong>nAleatoriosSinRepetir()</strong> para generar posiciones aleatorias en el eje X, evitando duplicados.<br>
Las posiciones se asignan a las entidades (autos y monedas) antes de ser añadidas al tablero.<br>

<h2>Niveles del Juego (clase Level):</h2>
  <div class="nivel1">
    <p><strong>Nivel 1:</strong></p>
    <div class="detalle">
      <p>• Tiempo de aparición de entidades: 1200 ms</p>
      <p>• Intervalos de movimiento: 700 ms</p>
    </div>
 
<div class="nivel2">
      <p><strong>Nivel 2:</strong></p>
      <p>• Tiempo de aparición de entidades: 1000 ms</p>
      <p>• Intervalos de movimiento: 400 ms</p>
    </div>

<div class="nivel3">
      <p><strong>Nivel Pro Rider:</strong></p>
      <p>• Tiempo de aparición de entidades: 1000 ms</p>
      <p>• Intervalos de movimiento: 300 ms</p>
    </div>
  </div>

<h2>Métodos Clave</h2>
<strong>iniciar()</strong>: Configura y comienza el juego.<br>
<strong>configurarTeclas()</strong>: Asigna las teclas de movimiento.<br>
<strong>agregarAuto()</strong>: Añade un auto al tablero.<br>
<strong>agregarMoneda()</strong>: Añade una moneda al tablero.<br>
<strong>limpiar()</strong>: Limpia las listas de entidades y posiciones aleatorias.<br>
<strong>terminarCon()</strong>: Finaliza el juego (victoria o derrota).<br>
<strong>actualizarNivelDe()</strong>: Actualiza el nivel en función de la puntuación del jugador.

<h2>Principios de POO Aplicados</h2>
Encapsulamiento: Cada entidad (Auto, Moneda, Level) maneja su propio comportamiento.<br>
Polimorfismo: Por ejemplo la clase Auto y Moneda comprenden el mísmo método esChocadoPor() (la consecuencia es diferente para cada una).<br>
Herencia: Aunque no hay una herencia explícita, los métodos reutilizan lógica común.<br>
Abstracción: Cada método y objeto tiene una responsabilidad clara y específica.<br>

<h2>Más imágenes del juego</h2>
<img src= "https://github.com/user-attachments/assets/642b65d7-245a-4cc3-a271-617e2c1abce8" alt="img2" width="600px"/>
<img src= "https://github.com/user-attachments/assets/e20ec097-4987-4600-b0f6-a9ecaa45ca54" alt="img3" width="600px"/>
<img src= "https://github.com/user-attachments/assets/3bb5760e-67c6-4986-b882-b2c50eb26ad8" alt="img4" width="600px"/>
<img src= "https://github.com/user-attachments/assets/486a02c8-ff33-479a-8618-bc8c5e20226b" alt="img5" width="600px"/>
