#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int* coordinates(int rows,int cols){
        int* coord = (int*) calloc(2,sizeof(int));
        coord[0] = rand() % cols;
        coord[1] = rand() % rows;
        return coord;
}

void positionMines(int rows,int cols,int** mat){
        int n = (rows * cols) / 10;
        while(n){
                int* coord = coordinates(rows,cols);
                if(mat[coord[0]][coord[1]] == 0){
                        mat[coord[0]][coord[1]] = -1;
                        n--;
                }
        }
}


int* displayMenu(){
        printf("=== Campo Minado ===\n");
        printf("Digite as dimensões do mapa: \n");
        int *dimensions = (int*) calloc(2,sizeof(int));
        scanf("%d %d",&dimensions[0],&dimensions[1]);
        return dimensions;
}

int** buildMat(int rows,int cols){
	int** mat = (int**) calloc(rows,sizeof(int*));
	for(int i = 0 ; i < rows;i++){
		mat[i] = (int*) calloc(cols,sizeof(int));
	}
	positionMines(rows,cols,mat);
	return mat;
}

void showRealMat(int rows,int cols,int **mat){
	for(int i = 0 ; i < rows;i++){
		for(int j = 0 ; j < cols;j++){
			printf("%d " ,mat[i][j]);
		}
		printf("\n");
	}
}

void showPlayerMap(int rows,int cols,int **mat,char** p_mat){
	for(int i = 0; i < rows;i++){
		for(int j = 0 ; j < cols;j++){
			if(mat[i][j] != -1 && mat[i][j] != 0){
				printf("%d ",mat[i][j]);
			}else{
				printf("%c ",p_mat[i][j]);
			}
		}
		printf("\n");
	}
}

int verifyNeighbors(int rows,int cols,int x,int y,int** mat){
	int bombs = 0;
	if((x+1) != cols && (y +1) != rows && x != 0 && y != 0){
		bombs = (mat[y -1 ][x] + mat[y- 1][x + 1] + mat[y - 1][x - 1] 
			+  mat[y][x + 1] +mat[y + 1][x + 1] + mat[y+ 1][x] 
			+  mat[y + 1][x - 1] +  mat[y][x - 1]) * -1;
	}else if(x == 0){
		if(y == 0){
			bombs = (mat[y][x + 1] + mat[y+ 1][x]) * -1;
		}else if((y + 1) == rows){
			bombs = (mat[y -1][x] +  mat[y][x + 1]) * -1;
		}else{
			bombs = (mat[y - 1][x] + mat[y + 1][x]  + mat[y][x + 1] + mat[y+ 1][x+ 1] + mat[y - 1][x + 1]) * -1;
		}
	}else if((x  + 1 ) == cols){
               if(y == 0){
                        bombs = (mat[y][x - 1] + mat[y+ 1][x]) * -1;
                }else if((y + 1) == rows){
                        bombs = (mat[y -1][x] +  mat[y][x - 1]) * -1;
                }else{
                        bombs = (mat[y - 1][x] + mat[y + 1][x]  + mat[y][x - 1] + mat[y + 1][x - 1] + mat[y - 1][x - 1]) * -1;
                }	
	}else if(y == 0){
		bombs = (mat[y][x -1] + mat[y + 1][x + 1 ] + mat[y + 1][x - 1] +  mat[y][x + 1] + mat[y + 1][x]) * -1;
	}else{
		bombs = (mat[y][x - 1] + mat[y - 1][x + 1] + mat[y - 1][x - 1] + mat[y][x + 1] + mat[y - 1][x]) * -1;	
	}
	return bombs;
}

int tryCoordinate(int rows,int cols,int x,int y,int** mat,char** p_mat){
	if(mat[y][x] == -1){
		p_mat[y][x] = 'X';
		return 1;		
	}else{
		int bombs = verifyNeighbors(rows,cols,x,y,mat);
		if(bombs == 0){
			p_mat[y][x] = 'x';
		}else{
			sprintf(&p_mat[y][x],"%d",bombs);
		}
		return 0;
	}
}
char** buildPlayerMat(int rows,int cols){
	char** mat = (char**) malloc(rows * sizeof(char*));
	for(int i = 0 ; i < rows;i++){
	   mat[i] = (char*) malloc(cols * sizeof(char));
	}
	
	for(int i = 0 ; i < rows;i++){
		for(int j = 0; j < cols;j++){
			mat[i][j] = 'O';
		}
	}
	return mat;
}

int main(int argc,char** argv){
	srand(time(NULL));
	int* dimensions = displayMenu();
	int** mat = buildMat(dimensions[0],dimensions[1]);
	char** p_mat = buildPlayerMat(dimensions[0],dimensions[1]);
	int flag = 0;
	while(!flag){
		printf("Coordenadas: \n");
		int x;
		int y;
		scanf("%d %d",&x,&y);
		flag = tryCoordinate(dimensions[0],dimensions[1],x,y,mat,p_mat);
		showPlayerMap(dimensions[0],dimensions[1],mat,p_mat);
	}
	return 0;
}
