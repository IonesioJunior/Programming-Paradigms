public class Produtor extends Thread {
    private int id;
    private Buffer buff;
    private int total;
 
    public Produtor(int id, Buffer buff, int total) {
        this.id = id;
        this.buff = buff;
        this.total = total;
    }
 
    public void run() {
        for (int i = 0; i < total; i++) {
            buff.set(id, i);
        }
        System.out.println("Produtor #" + id + " concluido!");
    }
}