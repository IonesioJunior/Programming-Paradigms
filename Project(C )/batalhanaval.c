/*
* @author Ionésio Junior
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//Build matrix using dynamic memory allocation
int** buildMatrix(int rows,int cols){
	int** mat = (int**) calloc(rows,sizeof(int*));
	for(int i = 0 ; i < rows;i++){
		mat[i] = (int*) calloc(cols,sizeof(int));
	}
	return mat;
}

//Show Real Matrix map with boats position(debug)
void showRealMap(int** mat,int rows,int cols){
	for(int i = 0 ; i < rows;i++){
		for(int j = 0 ; j < cols;j++){
			printf("%d ",mat[i][j]);
		}
		printf("\n");
	}
}

//Get some random coordinate to position the boats
int* getCoordenates(int sizeofBoat,int n){
	int limit = n - sizeofBoat;
	int* coord = (int*) calloc(2,sizeof(int));
	coord[0] = rand() % limit;
	coord[1] = rand() % limit;
	return coord;
}

//Build Battle ship in matrix
void BattleShipPosition(int n,int** mat){
	int* coord = getCoordenates(4,n);
	int position = rand() % 2;
	if(position == 1){
		//Horizontal
		for(int i = coord[0]; i < (coord[0] + 4);i++){
			mat[coord[1]][i] = 1;
		}
	}else{
		//Vertical
		for(int i = coord[1];i < (coord[1] + 4);i++){
			mat[i][coord[1]] = 1;
		}
	}
}

//Build Cuiser ship in matrix
void CruiserPosition(int n,int** mat){
	while(1){
		int* coord = getCoordenates(2,n);
		if(mat[coord[0]][coord[1]] == 0 && mat[coord[0] + 1][coord[1]] == 0){
			mat[coord[0]][coord[1]] = 2;
			mat[coord[0] + 1][coord[1]] = 2;
			break;
		}else if(mat[coord[0]][coord[1]] == 0 && mat[coord[0]][coord[1] + 1] == 0){
			mat[coord[0]][coord[1]] = 2;
			mat[coord[0]][coord[1] + 1] = 2;
			break;
		}
	}
}

//Build Minesweeper ship in matrix
void MinesweeperPosition(int n,int** mat){
	while(1){
		int* coord = getCoordenates(2,n);
		if(mat[coord[0]][coord[1]] == 0){
			mat[coord[0]][coord[1]] = 3;
			break;
		}
	}
}

//Generate Matrix and position the ships
int** initializeGame(int rows,int cols){
	int** mat = buildMatrix(rows,cols);
	BattleShipPosition(rows,mat);
	for(int i = 0 ; i < 4;i++){
		if(i < 2){
			CruiserPosition(rows,mat);
			MinesweeperPosition(rows,mat);
		}else{
			MinesweeperPosition(rows,mat);
		}
	}
	return mat;
}

//Show legends of game and get number of shots
void displayMenu(){
	printf("======= Batalha Naval ========\n");
	printf("O - Desconhecido\n");
	printf("X - Erro\n");
	printf("1 - Battleship\n");
	printf("2 - Cruiser\n");
	printf("3 - Minesweeper\n\n");
	printf("Quantos disparos deseja ter?\n");
	
}
int getShots(){
	int shots;
	scanf("%d",&shots);
	return shots;
}


//Show map(players) without ship positions
void showMaskedMap(int **mat,int rows,int cols){
	printf("  | ");
	//Desenhar Valores das colunas como coordenadas
	for(int i = 0 ; i < rows;i++){
		printf("%d    ",i);
	}
	printf("\n");
	printf("  ");
	for(int i = 0; i < rows;i++){
		printf("-----");
	}
	printf("\n");
	for(int i = 0; i < rows;i++){
		printf("%d | ",i);
		for(int j = 0; j < cols;j++){
			if(mat[i][j] == -5){
				printf("X    ");
			}else if(mat[i][j] == -1){
				printf("1    ");
			}else if(mat[i][j] == -2){
				printf("2    ");
			}else if(mat[i][j] == -3){
				printf("3    ");
			}else{
				printf("0    ");
			}
		}
		printf("\n");
	}
}

//Try shot in specific coordinates
void tryShot(int x,int y,int** mat,int* hits){
	if(mat[y][x] != 0){
		mat[y][x] = mat[y][x] * -1;
		*hits = *hits + 1;	
	}else{
		mat[y][x] = -5;
	}
}

int main(){
	srand(time(NULL));
	displayMenu();
	int shots = getShots();
	int** mat = initializeGame(9,9);
	int hits = 0;
	showMaskedMap(mat,9,9);
	while(shots){
		printf("Onde deseja disparar?\n");
		int x;
		int y;
		scanf("%d %d",&x,&y);
		tryShot(x,y,mat,&hits);
		shots--;
		if(hits == 12){
			printf(" ============== You Win!!! ============== \n");
			printf("Your Score: %d\n",hits);
			break;
		}
		printf("     		  === M A P ===\n\n");
		showMaskedMap(mat,9,9);
	}
	if(hits < 12){
		printf(" ================= Game Over ================== \n");
		printf("Your Score: %d\n",hits);
	}
	return 0;
}
