// David Ramirez A01206423
public class PersonCounter {

    private int count = 0;

    public int getCount() {
        return count;
    }

    public synchronized void addPerson() {
        ++count;
    }

    public synchronized void removePerson() {
        --count;
    }


}