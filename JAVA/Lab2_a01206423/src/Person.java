// David Ramirez A01206423
import java.util.Random;

public class Person implements Runnable {
    private Doors[] d;
    private Random rand;
    private int tts;
    private int num;

//    Al correr la persona se da un tiempo para empezar, después entra por la puerto y espera otro tiempo y
//    finalmente sale por otra puerta
    @Override
    public void run() {
        wake();
//        Las puertas por las que sale y entra son escogidas aleatoriamente
        num = rand.nextInt(d.length);
        enter(d[num]);
        num = rand.nextInt(d.length);
        exit(d[num]);
    }

    public Person(Doors[] d) {
        this.d = d;
        rand = new Random();
    }


    private void wake() {
        try {
//            Espera un tiempo para ver cuando entra
            tts = rand.nextInt(10000) + 5;
            Thread.sleep(tts);
        } catch (InterruptedException e){

        }
    }

    private void enter(Doors d) {
        try {
//            Espera un tiempo para saber cuando sale
            tts = rand.nextInt(10000)+500;
            d.getIn(this);
            Thread.sleep(tts);
        } catch (InterruptedException e) {

        }

    }

    private void exit(Doors d){
//        Solo sale
        d.getOut(this);
    }


    public int getTts() {
        return tts;
    }

    public int getNum(){
        return num;
    }
}
