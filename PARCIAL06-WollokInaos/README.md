Kingdom Objects

Sora, un valiente muchacho proveniente de las Islas del Destino, vio su hogar ser consumido por la oscuridad. Confundido, deberá usar el poder de la llave espada para defender los mundos de la amenaza de las fuerzas malvadas. Nos contactó para que lo ayudemos en esta difícil tarea modelando a los héroes y sus temibles enemigos utilizando el paradigma de objetos.


Parte 1: criaturas peligrosas

Para empezar, queremos conocer en profundidad a las criaturas que acechan los mundos y cómo reaccionarán ante los ataques. Sabemos que existen ataques físicos (con cierta potencia, que todavía no sabemos cómo se calcula) y hechizos (compuestos por una potencia y un elemento).

Los enemigos tienen puntos de vida (PV), que se reducen al recibir ataques. Esos puntos nunca pueden bajar de 0.

Cuando un enemigo recibe un ataque físico, sus PV se reducen en el daño recibido. El daño que reciben por un ataque físico depende de su raza:
los incorpóreos reciben tanto daño como la diferencia entre la potencia de ataque y su valor de defensa;
los sincorazón siempre reciben como daño el 90% de la potencia del ataque.
Tener en cuenta que un ataque físico va a hacer como mínimo 1 punto de daño.

Si un enemigo recibe un ataque mágico, el daño recibido dependerá de los elementos. Tanto los ataques mágicos como los enemigos presentan elementos, y además, los ataques poseen una potencia. si el enemigo recibe un ataque mágico de su mismo elemento, recibe 0 daño:
los enemigos de fuego reciben doble daño de ataques de hielo;
los enemigos de hielo reciben doble daño de ataques de fuego;
los enemigos de oscuridad reciben doble daño de ataques de luz;
los enemigos de luz reciben doble daño de ataques de oscuridad.
        En el resto de los casos, es decir, cuando el elemento del hechizo no es ni el mismo ni la debilidad del elemento de la criatura, el daño recibido es igual a la potencia del ataque mágico.


Como se puede notar, a diferencia de los ataques físicos, los ataques mágicos sí pueden hacer 0 puntos de daño.

Algunos casos de prueba:

El umbrío es un incorpóreo oscuro, con 10 de defensa, y comienza con 50 PV. Queda con 40 de vida luego de recibir un ataque físico de potencia 20.
El nocturno rojo es un sincorazón de fuego que comienza con 80 PV. Queda con 80 de vida luego de recibir un ataque mágico de fuego de potencia 100.
El nocturno rojo queda con 60 PV luego de recibir un ataque mágico de hielo de potencia 10.
El nocturno rojo queda con 70 PV luego de recibir un ataque mágico de luz de potencia 10.
El nocturno rojo queda con 44 PV luego de recibir un ataque físico de potencia 40.

Parte 2: ¡a la carga!

En este universo existen varios héroes que acompañan a Sora en su aventura. Cada héroe cuenta con una fuerza y puntos de maná (PM) y está equipado con una llave espada.

Como no podía ser de otra manera, nuestros héroes pueden atacar a los enemigos con los que se cruzan. Al hacerlo, el enemigo recibe un ataque físico cuyo poder será la suma de su fuerza y el poder físico de su llave espada.
Nuestros héroes también pueden atacar mágicamente lanzando hechizos. La potencia del ataque mágico se calcula como el producto entre el poder base del hechizo y el poder mágico de la llave espada equipada. Al lanzar un hechizo, el héroe gasta PM iguales al poder base del mismo (por ejemplo, al lanzar Piro, gasta 5 PM). No debe poder lanzar el hechizo si no tiene PM suficientes para hacerlo.
Cuando un héroe descansa, aumenta sus PM hasta 30.
Cuando un héroe equipa cierta llave espada, cambia la que tenía hasta entonces por la nueva.
Modelar a los siguientes héroes, llaves espada y hechizos:
        Héroes:

Sora: tiene 10 de fuerza, 8 PM y porta la Llave del Reino;
Mickey: tiene 5 de fuerza, 13 PM y porta la Explorador Estelar;
Riku: tiene 15 de fuerza, 4 PM y porta la Camino al Alba;
Llaves espada:

Llave del Reino: 3 de poder físico, 5 de poder mágico;
Explorador Estelar: 2 de poder físico, 10 de poder mágico;
Camino al Alba: 5 de poder físico, 3 de poder mágico;
Brisa Descarada: 5 de poder físico, 2 de poder mágico;
Hechizos:

Piro: elemento fuego, poder base 5;
Chispa: elemento luz, poder base 1;
Ragnarok: elemento luz, poder base 30.
Algunos casos de prueba:

Si Sora ataca físicamente a un umbrío con PV iniciales, éste queda con 47 PV.
Si Riku ataca físicamente a un nocturno rojo con PV iniciales, éste queda con 62 PV.
Si Sora lanza Piro a un rapsodia azul (igual al nocturno rojo, pero de elemento hielo) con PV iniciales, éste queda con 30 PV y Sora queda con 3 PM.
Si Sora equipa la “Examinadora” (llave espada con 1 de poder físico y 10 de poder mágico) y lanza Piro a un rapsodia azul con PV iniciales, éste queda con 0 PV.
Si Mickey intenta lanzar Ragnarok a un umbrío con PV iniciales, no puede, dado que no cuenta con suficientes PM.

Parte 3: Equipos

Un equipo está compuesto por varios héroes que se embarcan juntos en una aventura. Queremos obtener información sobre ellos y que puedan hacer ciertas tareas:

Saber si necesitan frenar, que se cumple si algún héroe del equipo está agotado. Un héroe está agotado si tiene 0 PM.
Emboscar a un monstruo. Al hacerlo, cada héroe del equipo realiza un ataque físico contra el monstruo.
Saber a quiénes del equipo les sería útil cambiar a cierta llave espada. A alguien le es útil cambiar a una llave espada si, si la equipara, aumentaría la potencia de sus ataques físicos.
Legar una llave espada al equipo. Esto hace que el miembro del equipo para el que más aumente el potencial ofensivo físico la equipe. Si a nadie le sirve cambiar a ella, no pasa nada.

Parte 4: más compañeros

Se unen a la aventura nuevos guerreros que tienen una manera más particular de atacar:

Ventus, que agarra su llave espada de forma un tanto extraña, al revés (ver imagen). Esto hace que, los efectos de la llave espada que porta se inviertan: usa el poder mágico para atacar y el poder físico para lanzar hechizos. Fuera de esto, es un héroe como el resto: tiene 8 de fuerza, 7 PM y porta la “Brisa Descarada”.
Roxas, que cambia su forma de atacar según la situación. Normalmente se encuentra en modo tranquilo, en el cual ataca como cualquier otro héroe. Al atacar físicamente cinco veces consecutivas (es decir, sin lanzar ningún hechizo entre ataques), pasa a modo valiente, que aumenta la potencia de sus ataques físicos en un 50% pero reduce en un 20% la de sus hechizos. En contrapartida, si lanza cinco hechizos consecutivos pasa a modo sabio, que aumenta en 200% la potencia de sus hechizos lanzados pero reduce en 70% la de sus ataques físicos. Roxas tiene 5 de fuerza, 20 PM y porta la “Llave del Reino”.
Algunos casos de prueba:

Si Ventus ataca físicamente a un nocturno rojo con PV iniciales, éste queda con 71 PV.
Si Ventus lanza Chispa a un nocturno rojo con PV iniciales, éste queda con 75 PV, y Ventus queda con 6 PM.
Si Roxas ataca físicamente a un umbrío con PV iniciales cinco veces, éste queda con 45 PV, dado que c/u restó el mínimo de 1 punto. Si lo ataca una sexta vez, ahora el umbrío queda con 43 PV, dado que este ataque ahora tiene 12 de potencia.
Si Roxas lanza Chispa a un nocturno rojo con PV iniciales cinco veces, éste queda con 55 PV. Si lo lanza una sexta vez, ahora tiene 40 PV, dado que este ataque ahora tiene potencia 15.