#include <cstdlib>
#include <iostream>
#include <vector>

void transpose(std::vector<std::vector<int> > matrix){
	for(int i = 0 ; i < matrix.size();i++){
		for(int j = 0; j < matrix.size();j++){
			if(j < matrix.size() - 1){
				std::cout  << matrix[j][i] << " ";
			}else{
				std::cout << matrix[j][i] << std::endl;
			}
		}
	}	
}

int main(int argc,char** argv){
	int n;
	std::cin >> n;
	std::vector<std::vector<int> > matrix;
	for(int i = 0 ; i < n;i++){
		std::vector<int> row;
		for(int j = 0 ; j < n;j++){
			int value;
			std::cin >> value;
			row.push_back(value);
		}
		matrix.push_back(row);
	}
	
	transpose(matrix);
	return 0;
}
