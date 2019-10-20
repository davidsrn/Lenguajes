public class Doors implements Runnable {

    private Thread[] persons;
    private int total_persons;
    private PersonCounter counter;
    private Doors[] allDoors;
    private Boolean first = true;

//    Se inicializa con el numero de personas y hace un arreglo para el numero de personas dado
    public Doors(PersonCounter counter, int total_persons) {
        this.counter = counter;
        this.total_persons = total_persons;
        persons = new Thread[total_persons];
    }
//    En el arreglo de personas se inicializa la persona y se le mandan las puerats para que ella decida a donde ir
//    Al iniciarse la persona esta comienza a trabajar
    public void makePeople(){
//        try {
            for (int i = 0; i < total_persons; i++) {
                persons[i] = new Thread(new Person(allDoors));
                persons[i].start();
//                persons[i].join();
            }
//        } catch (InterruptedException e){

//        }
    }


    @Override
    public void run() {
        if(first){
//            Si apenas corrió el thread crea las personas
            makePeople();
            first = false;
        }
//        System.out.println("There's " + counter.getCount() + " persons inside");
//        System.out.println("There's a total of " + persons + " in currently");
    }
//     Cuando una persona entra se cambia el contador y se imprime como va
    public void getIn(Person p){
        counter.addPerson();
        System.out.println("Person entered for " + p.getTts() + " via door " + p.getNum() + " and there's now " +
                counter.getCount() + " persons inside");
//        System.out.println("Person entered for " + p.getTts() + " via door " + p.getNum());
//        System.out.println("There's " + counter.getCount() + " persons inside");
    }

//     Cuando una persona sale se cambia el contador y se imprime como va
    public void getOut(Person p){
        counter.removePerson();
        System.out.println("Person that stayed " + p.getTts() + " just exited via the door " + p.getNum() + " " +
                "and there's now " + counter.getCount() + " persons inside");

//        System.out.println("There's " + counter.getCount() + " persons inside");
    }
    public synchronized int getPersons(){
        return total_persons;
    }


    public synchronized void setPersons(int persons){
        this.total_persons = persons;
    }

    public void setAllDoors(Doors[] allDoors) {
        this.allDoors = allDoors;
    }
}
