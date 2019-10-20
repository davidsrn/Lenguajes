import java.util.Arrays;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class IncArrayRecursiveAction extends RecursiveAction {
    private int[] a;
    private int start, end;
    private static final int THRESHOLD = 10;
    private IncArrayRecursiveAction(int[] a, int start, int end) {
        this.a = a;
        this.start = start;
        this.end = end;
    }
    @Override
    protected void compute(){
        if(end-start < THRESHOLD){
            for(int i = start; i< end; i++){
                a[i]++;
            }
        }else{
            int mid = (end+start)>>>1;
            invokeAll(new IncArrayRecursiveAction(a, start, mid),
                    new IncArrayRecursiveAction(a, mid, end));
        }
    }

    public static void main(String[] args){
        int[] a = new int[1000];
        IncArrayRecursiveAction t = new IncArrayRecursiveAction(a, 0, a.length);
        ForkJoinPool pool = new ForkJoinPool();
        System.out.println(Arrays.toString(a));
        pool.invoke(t);
        pool.shutdown();

        System.out.println(Arrays.toString(a));
    }
}
