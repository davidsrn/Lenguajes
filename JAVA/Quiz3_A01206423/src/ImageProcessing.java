// David Ramirez A01206423
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class ImageProcessing extends RecursiveAction {
    // We use a Matrix to represent a Black and White Image
    private int[][] image;
    // The variables we use to know where we are located inside of the matrix and what are our limits
    private int start, end;
    // This is the flag to know when to stop the recursive action
    private static final int THRESHOLD = 10;
    // This variable store how much we will add or subtract from our image
    private int factor;

    // Our constructor to assign the values of the variables
    private ImageProcessing(int[][] image, int start, int end, int factor) {
        this.image = image;
        this.start = start;
        this.end = end;
        this.factor = factor;
    }

    // The override function that is called for the pool of Threads that are assigned
    @Override
    protected void compute(){
        // If we reached our Threshold we start doing the operation
        if(end-start < THRESHOLD){
            // from our start to our end we start to iterate
            System.out.println("Reached threshold with start =  " + start + " end = " + end);
            for(int i = start; i< end; i++){
                // Since we are working with a matrix we have to start in the beginning of its first element
                // and end when we reach its size or we will achieve something like =
//                1 1 1 1 1 1 0 0 0 0 0 0
//                1 1 1 1 1 1 0 0 0 0 0 0
//                1 1 1 1 1 1 0 0 0 0 0 0
//                1 1 1 1 1 1 0 0 0 0 0 0
//                1 1 1 1 1 1 0 0 0 0 0 0
//                1 1 1 1 1 1 0 0 0 0 0 0
//                0 0 0 0 0 0 1 1 1 1 1 1
//                0 0 0 0 0 0 1 1 1 1 1 1
//                0 0 0 0 0 0 1 1 1 1 1 1
//                0 0 0 0 0 0 1 1 1 1 1 1
//                0 0 0 0 0 0 1 1 1 1 1 1
//                0 0 0 0 0 0 1 1 1 1 1 1
//              And we don't want that it happened to me until i remembered what you said during class about matrices.
                for(int j = 0; j< image.length; j++) {
                    image[i][j] = image[i][j] + factor;
                }
            }
        }else{
            // If the threshold wasn't reached yed we invoke two new ImageProcessing classes so we divide the work
            // separating the matrix and sending it to the created classes.
            System.out.println("Computing with start = " + start + " and end = " + end);
            int mid = (end+start)>>>1; // as we saw during class this is the binary operator that does "/2"
            invokeAll(new ImageProcessing(image, start, mid, factor),
                    new ImageProcessing(image, mid, end, factor));
        }
    }

    public static void main(String[] args){
        // The size of the image we want to create
        int size = 100;
        // The factor we desire
        int desired_factor = 10;
        // We start a 0 filled matrix to simulate a black image
        int[][] image = new int[size][size];
        // We create the object with the information that we need and the desired factor
        // The factor being a positive number simulates that the image is getting brighter and viceversa
        ImageProcessing ip = new ImageProcessing(image, 0, image.length, desired_factor);
        // We create our thread pool that will handle the compute function
        ForkJoinPool pool = new ForkJoinPool();
        // We print our values before and after the changes had been made to see the result
        for(int i = 0; i < image.length; i++) {
            for(int j = 0; j < image[0].length; j++) {
                System.out.print(image[i][j] + " ");
            }
            System.out.println("");
        }
        // We invoke our pool with our object so it starts running
        pool.invoke(ip);
        // When it's finished we shut it down
        pool.shutdown();

        //We print our new matrix to see the results
        for(int i = 0; i < image.length; i++) {
            for(int j = 0; j < image[0].length; j++) {
                System.out.print(image[i][j] + " ");
            }
            System.out.println("");
        }

        System.out.println("Done");
    }
}