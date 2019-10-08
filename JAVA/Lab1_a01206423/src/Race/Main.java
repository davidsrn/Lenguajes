package Race;

public class Main {

    public static void main(String[] args) {
        System.out.println("RACE 1!!!!!!!! \n -------------------------------------------------");
        Rabbit rob = new Rabbit();
        Turtle tortu = new Turtle();
        Race race = new Race(rob, tortu, 1000);
        race.run();
        System.out.println("RACE 2!!!!!!!! \n -------------------------------------------------");
        Rabbit bunny = new Rabbit(500, 7);
        Turtle torta = new Turtle(7);
        Race race2 = new Race(bunny, torta, 5000);
        race2.run();
//        Race race3 = new Race(rob, tortu, 50000);
//        race3.run();
//        Race race4 = new Race(rob, tortu, 100000);
//        race4.run();
    }



}
