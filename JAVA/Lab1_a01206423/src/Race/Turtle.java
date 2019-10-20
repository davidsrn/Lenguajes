// David Ramirez A01206423
package Race;

import java.util.Random;

public class Turtle implements Runnable {
    // Se inician las variables
//    private int time;
//    Total de distancia recorrida por el conejo
    private int distance;
//    Tamaño de la carrera
    private int goal;
//    Variable para crear los saltos
    private Random r = new Random();
//    Saber si el thread debe de correr
    private volatile boolean isRunning = true;
//    El otro bunny
    private Rabbit rob;
//      Variable pa saber cuanto avanzar

    private int running_distance_bound;
//Default
    public Turtle(){
        distance = 0;
        running_distance_bound = 8;
        this.goal = 1000;
    }
// Para cambiar su limite
    public Turtle(int running_distance_bound){
        distance = 0;
        this.running_distance_bound = running_distance_bound;
    }

    @Override
    public void run() {
//        Esta tortuga corre si no ha ganado y su variable de correr sigue en true
        while(!this.has_won()&&isRunning){
//            Igual que el bunny pero sin dormir
            int running_distance = r.nextInt(running_distance_bound) + 3;
            this.distance += running_distance;
            System.out.println("The turtle just ran " + running_distance + " and has run a total of " + this.distance);
            if(this.has_won())
                System.out.println("The Turtle won");
            if(this.has_won() || !this.isRunning){
//                rob.kill();
//                System.out.println("ILL KILL THE BUNNY CAUSE IM EVIL");
                break;
            }
        }
        if(!this.isRunning){

        }
//            System.out.println("Turtle is Dead");
//        System.out.println("Bunny Won");

    }

    public int getDistance() {
        return distance;
    }

// Igual que el bunny
    public boolean has_won(){
        if(distance>=goal) {
//            System.out.println("The Turtle won!");
            rob.kill();
            return true;
        }
        return false;
    }

    public void kill(){
        this.isRunning = false;
//        System.out.println("The bunny won");
    }

    public void setGoal(int goal){
        this.goal = goal;
    }

    public void setCompetitor(Rabbit rob){
        this.rob = rob;
    }

}
