public class Main {

    public static void main(String[] args) throws InterruptedException {
//        Iniciamos el numero de puertas y personas que va atener cada puerta
        int total_doors = 2;
        int total_persons = 100; // per door
//        Hacemos un thread para cada puerta
        Thread[] threads = new Thread[total_doors];
//        Esta clase es mi variable syncronizada para compartir entre threads
        PersonCounter counter = new PersonCounter();
        Doors[] doors = new Doors[total_doors];
//        Inicializamos cada puerta con sus valores
        for (int i = 0; i < total_doors; i++) {
            doors[i] = new Doors(counter, total_persons);
        }
//        Cada puerta conoce todas las demás puertas creadas para que las personas asignadas a cada una puedan salirse por la que gusten
        for (int i = 0; i < total_doors; i++) {
            doors[i].setAllDoors(doors);
        }
//        Corremos cada Thread para que comience
        for (int i = 0; i < total_doors; i++) {
            threads[i] = new Thread(doors[i]);
            System.out.println("Starting door thread " + i);
            threads[i].start();
        }

        for (int i = 0; i < total_doors; i++) {
            threads[i].join();
        }

//        System.out.println("All people left!!");

//        while(threads[0].isAlive()){
//            System.out.println("There's " + counter.getCount() + " persons inside");
//        }

    }
}
