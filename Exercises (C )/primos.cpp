#include <iostream>
#include <cstdlib>
#include <math.h>

bool isPrime(int x){
	int loop = 2;
	while(loop < x){
		if(x % loop == 0){
			return false;
		}
		loop++;
	}
	return true;
}
int main(int argc,char** argv){
	int limit;
	std::cin >> limit;
	for(int i = 1 ; i < limit - 1;i++){
		int couple = i + 2;
		if(isPrime(i) && isPrime(couple)){
			std::cout << i <<" "  << couple << std::endl;
		}
	}

	return 0;
}
