public class HelloRunable{

  int id;

  public HelloRunnable(int nid){
    id  = nid;
  }

  public void run(){
    System.out.println("Hello from a thread " +id);
    System.out.println(Thread.currentThread().getId());
  }

  public static void main(String args[]){
    for(int i = 1; i < 5; i++){
      (new Thread(new HelloRunable())).start();
    }
  }
}
