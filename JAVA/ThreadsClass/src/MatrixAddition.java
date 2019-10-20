import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class MatrixAddition extends RecursiveAction {
    private static final int THRESHOLD = 2;
    int mat1[][], mat2[][], mat3[][], start, end;

    public MatrixAddition(int a, int b, int m1[][], int m2[][], int m3[][]){
        start = a;
        end = b;
        mat1 = m1;
        mat2 = m2;
        mat3 = m3;
    }

    protected void compute(){
        if(end - start < THRESHOLD){
            for(int i = start; i < end; i++){
                for(int j = 0; j < mat1.length; j++){
                    mat3[i][j] = mat1[i][j] + mat2[i][j];            }
            }
        }else{
            int mid = (start + end) >>> 1;
            MatrixAddition t1, t2;
            invokeAll(new MatrixAddition(start, mid, mat1, mat2, mat3), new MatrixAddition(mid, end, mat1, mat2, mat3));
        }
    }

    public static void main(String[] args) {
        int n = 10;
        int mat1[][] = new int[n][n];
        int mat2[][] = new int[n][n];
        int mat3[][] = new int[n][n];
        for(int i = 0; i<n; i++){
            for(int j = 0; j<n; j++) {
                mat1[i][j] = 1;
                mat2[i][j] = 2;
                mat3[i][j] = 0;
            }
        }
        System.out.println("Start Matrix Parallel");
        MatrixAddition m = new MatrixAddition(0, n, mat1, mat2, mat3);
        ForkJoinPool pool = new ForkJoinPool();
        pool.invoke(m);
        pool.shutdown();
        for(int i = 0; i<n; i++){
            for(int j = 0; j<n; j++) {
                System.out.print("  " + mat3[i][j]);
            }
            System.out.println("");
        }
    }
}
