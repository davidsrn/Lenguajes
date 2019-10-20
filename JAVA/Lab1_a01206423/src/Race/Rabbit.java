// David Ramirez A01206423
package Race;

import java.util.Random;

public class Rabbit implements Runnable{
// Se inician las variables
//    private int time;
//    Tamaño de la carrera
    private int goal;
//    Variable para crear lso saltos y el tiempo pa dormir
    private Random r = new Random();
//    Saber si el thread debe de correr
    private volatile boolean isRunning = true;
//    Nuestra tortuga para poder saber como va
    private Turtle tortu;
//    Variable donde se guarda el tiempo para dormir
    private int sleeping_time_bound;
//    Variable pa saber cuanto avanzar
    private int running_distance_bound;
//    Total de distancia recorrida por el conejo
    private int distance;

//Se crae la calse default
    public Rabbit(){
//        time = 0;
        distance = 0;
        running_distance_bound = 500;
        sleeping_time_bound=100;
        this.goal=1000;
    }
// Se crea a clase con los parámetros
    public Rabbit(int running_distance_bound, int sleeping_time_bound){
//        this.time = time;
        this.distance = 0;
        this.running_distance_bound = running_distance_bound;
        this.sleeping_time_bound = sleeping_time_bound;
    }

//    Para correr el thread
    @Override
    public void run() {
//        So este bunny blue corro si no ha ganado y su variable de correr sigue en true
        while(!this.has_won() && this.isRunning){
//            System.out.println(isRunning);
//            Se hace el random y la logica para hacer que avance y después se duerme
//            Vienen incluidos los prints para saber como va
            int running_distance = r.nextInt((running_distance_bound)) + 501;
            this.distance += running_distance;
            int sleeping_time = r.nextInt(sleeping_time_bound);
            System.out.println("The rabbit ran " + running_distance + " and has run a total of "+ this.distance +
                    "\n and will now sleep "+ sleeping_time);
//            SI despues de caminar ganó se para el thread y manda a matar la tortuga
            if(this.has_won())
                System.out.println("The bunny won");
            if(this.has_won() || !this.isRunning)
                break;
            try{
                Thread.sleep(sleeping_time);
                System.out.println("The bunny is now awoken");
            } catch(InterruptedException ex){
                Thread.currentThread().interrupt();
            }

        }
//        if(!this.isRunning)
//            System.out.println("Bunny is kill");
    }

//    public int getTime(){
//        return  time;
//    }

    public int getDistance(){
        return this.distance;
    }
// Si gana manda a matar la tortuga cambiando su variable isRunning
    public boolean has_won(){
        if(this.distance>=this.goal) {
//            System.out.println("The Bunny won!");
            tortu.kill();
            return true;
        }
        return false;
    }
// Setter para poner cuanto va a durar la carrera
    public void setGoal(int goal){
        this.goal = goal;
    }

//    Cabiais Running a False
    public void kill(){
        this.isRunning = false;
    }
//    Poner a la tortuga junto con este bunny
    public void setTortu(Turtle tortu){
        this.tortu=tortu;
    }

}
