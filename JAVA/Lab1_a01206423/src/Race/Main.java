// David Ramirez A01206423
package Race;

public class Main {

    public static void main(String[] args) {
//        Generamos diferentes objetos para crear diferentes carreras y ver su output
        System.out.println("RACE 1!!!!!!!! \n -------------------------------------------------");
        Rabbit rob = new Rabbit();
        Turtle tortu = new Turtle();
        Race race = new Race(rob, tortu, 1000);
        race.run();
//        De todas las carreras la única manera de hacer que el conejo ganara es haciendo que duerma muy poco ya que
//        aunque duerma un ms es suficiente para que el thread de la tortuga gane.
        System.out.println("RACE 2!!!!!!!! \n -------------------------------------------------");
        Rabbit bunny = new Rabbit(500, 7);
        Turtle torta = new Turtle(7);
        System.out.println("RACE 3!!!!!!!! \n -------------------------------------------------");
        Race race2 = new Race(bunny, torta, 5000);
        race2.run();
        System.out.println("RACE 4!!!!!!!! \n -------------------------------------------------");
        Race race3 = new Race(rob, tortu, 50000);
        race3.run();
        System.out.println("RACE 5!!!!!!!! \n -------------------------------------------------");
        Race race4 = new Race(rob, tortu, 100000);
        race4.run();
    }



}
