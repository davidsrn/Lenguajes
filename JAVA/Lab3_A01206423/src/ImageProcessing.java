// David Ramirez A01206423
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class ImageProcessing extends RecursiveAction {
    // Se quizo jugar y se perdio. Crei que podria cambiar mi examen para que diera un resultado como lo esperabael lab
    // y no se pudo. Sgun yo esto cambia a una imagen en blanco y negro pero no usa threads
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
//            for (int i = 0; i < result.getHeight(); i++) {
//                for (int j = 0; j < result.getWidth(); j++) {
//                    Color c = new Color(result.getRGB(j, i));
//                    int red = (int) (c.getRed() * 0.299);
//                    int green = (int) (c.getGreen() * 0.587);
//                    int blue = (int) (c.getBlue() * 0.114);
//                    Color newColor = new Color(
//                            red + green + blue,
//                            red + green + blue,
//                            red + green + blue);
//                    result.setRGB(j, i, newColor.getRGB());
//                }
//            }

        }else{
            // If the threshold wasn't reached yed we invoke two new ImageProcessing classes so we divide the work
            // separating the matrix and sending it to the created classes.
            System.out.println("Computing with start = " + start + " and end = " + end);
            int mid = (end+start)>>>1; // as we saw during class this is the binary operator that does "/2"
            invokeAll(new ImageProcessing(image, start, mid, factor),
                    new ImageProcessing(image, mid, end, factor));
        }
    }

    public static void ctbaw(BufferedImage result) throws IOException {
        for (int i = 0; i < result.getHeight(); i++) {
            for (int j = 0; j < result.getWidth(); j++) {
                Color c = new Color(result.getRGB(j, i));
                int red = (int) (c.getRed() * 0.299);
                int green = (int) (c.getGreen() * 0.587);
                int blue = (int) (c.getBlue() * 0.114);
                Color newColor = new Color(
                        red + green + blue,
                        red + green + blue,
                        red + green + blue);
                result.setRGB(j, i, newColor.getRGB());
            }
        }
        File output = new File("img-g.png");
        ImageIO.write(result, "png", output);
    }

    public static void main(String[] args) throws IOException {
        // The size of the image we want to create
        BufferedImage img= null;
        try {
            img = ImageIO.read(new File("594827.jpg"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        BufferedImage result = new BufferedImage(
                img.getWidth(),
                img.getHeight(),
                BufferedImage.TYPE_INT_RGB);
//        int image[][]= new int[img.getWidth()][img.getHeight()];
        Graphics2D image = result.createGraphics();
        ctbaw(result);
        image.drawImage(img, 0, 0, Color.WHITE, null);
        // The factor we desire
        // We start a 0 filled matrix to simulate a black image
        // We create the object with the information that we need and the desired factor
        // The factor being a positive number simulates that the image is getting brighter and viceversa
//        ImageProcessing ip = new ImageProcessing(image, 0, img.getWidth(), 0);
        // We create our thread pool that will handle the compute function
        ForkJoinPool pool = new ForkJoinPool();
        // We print our values before and after the changes had been made to see the result
        // We invoke our pool with our object so it starts running
//        pool.invoke(ip);
        // When it's finished we shut it down
//        pool.shutdown();

        //We print our new matrix to see the results


        System.out.println("Done");
    }
}