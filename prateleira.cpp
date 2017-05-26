#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>
#include <string.h>
#include <algorithm>

int main(int argc,char** argv){
	int loop = 0;
	std::cin >> loop;
	std::vector<std::string> titles;
	while((loop+ 1) > 0){
		std::string word;
		std::getline(std::cin ,word);
		titles.push_back(word);
		loop--;
	}
	
	std::sort(titles.begin(),titles.end());
	for(int i = 0 ; i < titles.size();i++){
		std::cout << titles[i] << std::endl;	
	}


}
