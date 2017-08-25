
public class Buffer {
 private int conteudo;
 private boolean disponivel;

 public synchronized void set(int idProdutor, int valor) {
	while (disponivel == true) {
       		try {
       		System.out.println("Produtor #" + idProdutor + " esperando...");
      		wait();
      		} catch (Exception e) {
      			e.printStackTrace();
    		}
    	}
    	conteudo = valor;
    	System.out.println("Produtor #" + idProdutor + " colocou " + conteudo);
    	disponivel = true;
    	notifyAll();
 }

  public synchronized int get(int id) {
    while (disponivel == false) {
        try {
            System.out.println("Consumidor #" + id
                    + " esperado...");
            wait();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    System.out.println("Consumidor #" + id + " consumiu: " + conteudo);
    disponivel = false;
    notifyAll();
    return conteudo;
 }

}