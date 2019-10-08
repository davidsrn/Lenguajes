package Race;

import java.util.Random;

public class Rabbit implements Runnable{

    private int time;
    private int goal;
    private Random r = new Random();
    private volatile boolean isRunning = true;
    private Turtle tortu;
    private int sleeping_time_bound;
    private int running_distance_bound;
    private int distance;


    public Rabbit(){
//        time = 0;
        distance = 0;
        running_distance_bound = 500;
        sleeping_time_bound=100;
        this.goal=1000;
    }

    public Rabbit(int running_distance_bound, int sleeping_time_bound){
//        this.time = time;
        this.distance = 0;
        this.running_distance_bound = running_distance_bound;
        this.sleeping_time_bound = sleeping_time_bound;
    }

    @Override
    public void run() {
        while(!this.has_won() && this.isRunning){
//            System.out.println(isRunning);
            int running_distance = r.nextInt((running_distance_bound)) + 501;
            this.distance += running_distance;
            int sleeping_time = r.nextInt(sleeping_time_bound);
            System.out.println("The rabbit ran " + running_distance + " and has run a total of "+ this.distance +
                    "\n and will now sleep "+ sleeping_time);
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

    public boolean has_won(){
        if(this.distance>=this.goal) {
//            System.out.println("The Bunny won!");
            tortu.kill();
            return true;
        }
        return false;
    }

    public void setGoal(int goal){
        this.goal = goal;
    }

    public void kill(){
        this.isRunning = false;
    }
    public void setTortu(Turtle tortu){
        this.tortu=tortu;
    }

}
