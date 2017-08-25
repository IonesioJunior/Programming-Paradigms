

public class Main{
	public static void main(String[] args) {
		Buffer	bufferCompartilhado	=	new	Buffer();
		int	idP1	=	1;
		int	idP2	=	2;
		int	idC1	=	1;
		int	idC2	=	2;
		int	producaoTotalP1	=	2;
		int	producaoTotalP2	=	3;
		int	totalConsumirC1	=	2;
		int	totalConsumirC2	=	2;
		Produtor	produtor1	=	new	Produtor(idP1,	bufferCompartilhado,	producaoTotalP1);
		Produtor	produtor2	=	new	Produtor(idP2,	bufferCompartilhado,	producaoTotalP2);
		Consumidor	consumidor1	=	new	Consumidor(idC1,	bufferCompartilhado,	totalConsumirC1);
		Consumidor	consumidor2	=	new	Consumidor(idC2,	bufferCompartilhado,	totalConsumirC2);
		produtor1.start();
		produtor2.start();
		consumidor1.start();
		consumidor2.start();
	}
}
