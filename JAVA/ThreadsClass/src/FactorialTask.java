import java.math.BigInteger;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveTask;

public class FactorialTask extends RecursiveTask<BigInteger> {

    private static final int THRESHOLD = 100;
    private int start, end;

    public FactorialTask(int a, int b){
        start = a;
        end = b;
    }
    @Override
    protected BigInteger compute() {
        if(end - start < THRESHOLD){
            BigInteger result = new BigInteger("1");
            for(int i = start; i < end; i++){
                result = result.multiply(BigInteger.valueOf(i));
            }
            return result;
        }else{
            int mid = (start + end) >>> 1;
            FactorialTask t1 = new FactorialTask(start, mid);
            FactorialTask t2 = new FactorialTask(mid, end);
            t1.fork();
            return t2.compute().multiply(t1.join());
        }
    }

    public static void main(String[] args){
        int n = 1000000;
        BigInteger resultado;

        System.out.println("Parallel start");
        FactorialTask t = new FactorialTask(1, n+1);
        ForkJoinPool pool = new ForkJoinPool();
        resultado = pool.invoke(t);
        pool.shutdown();
        System.out.println("parallel done" + resultado);
    }
}
