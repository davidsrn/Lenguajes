package Race;

import java.util.Random;

public class Turtle implements Runnable {

    private int distance;
    private int goal;
    private Random r = new Random();
    private volatile boolean isRunning = true;
    private Rabbit rob;
    private int running_distance_bound;

    public Turtle(){
        distance = 0;
        running_distance_bound = 8;
        this.goal = 1000;
    }

    public Turtle(int running_distance_bound){
        distance = 0;
        this.running_distance_bound = running_distance_bound;
    }

    @Override
    public void run() {
        while(!this.has_won()&&isRunning){
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
