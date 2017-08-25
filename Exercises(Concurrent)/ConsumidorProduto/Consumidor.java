public class Consumidor extends Thread {
    private int id;
    private Buffer buff;
    private int total;
 
    public Consumidor(int id, Buffer buff, int total) {
        this.id = id;
        this.buff = buff;
        this.total = total;
    }
 
    public void run() {
        for (int i = 0; i < total; i++) {
            buff.get(id);
        }
        System.out.println("Consumidor #" + this.id + " concluido!");
    }
}