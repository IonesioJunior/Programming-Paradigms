#include <iostream>
#include <cstdlib>
#include <vector>

int main(int argc,char** argv){
	int limit = 3;
	std::vector<std::string> array;
	while(limit > 0){
		std::string word;
		std::cin >> word;
		int flag = 1;
		for(int i = 0 ; i < word.size();i++){
			if(word[i] == 'a' || word[i] == 'b' || word[i] == 'c' || word[i] == 'o' || word[i] == 'u'){
				flag = 0;
				break;
			}
		}
		if(flag){
		   limit--;
		   array.push_back(word);
		}
	}
	for(int i = 0 ; i < array.size();i++){
		std::cout << array[i]	<< std::endl;
	}

}
