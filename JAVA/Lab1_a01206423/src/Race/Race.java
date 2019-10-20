// David Ramirez A01206423
package Race;

public class Race {

    Rabbit rob;
    Turtle tortu;
    int i;
// Para iniciar la carrea se necesitan los ontricntes y el tamaño de la pista
    public Race(Rabbit rob, Turtle tortu, int i) {
        this.rob = rob;
        this.rob.setGoal(i);
        this.rob.setTortu(tortu);
        this.tortu = tortu;
        this.tortu.setGoal(i);
        this.tortu.setCompetitor(rob);
        this.i = i;
    }

//    La carrera inicia creando los threads para los contricantes
//    Después se checa si alguno de ellos os han terminado para interrumpir al siguiente

    public void run(){
        Thread r = new Thread(rob);
        Thread t = new Thread(tortu);
        r.start();
        t.start();
        while(!rob.has_won() || !tortu.has_won()){
            try {
                t.join(100);
                r.join(100);
            } catch(InterruptedException ex){

            }
//            System.out.println("Has the bunny won? " + rob.has_won());
//            System.out.println("Has the turtle won? " + tortu.has_won());
            if(rob.has_won()){
//                System.out.println("The bunny won! Killing tortu");
                r.interrupt();
                t.interrupt();
//                tortu.kill();
                break;
            }
            if(tortu.has_won()){
//                System.out.println("The turtle won! Killing bunny");
                t.interrupt();
                r.interrupt();
//                rob.kill();
                break;
            }
        }
//        Sólo parar alclarar que se terminó la carrera
        System.out.println("C'est finit");
    }
}
