#include <iostream>

extern "C" int AsmFunction();

int main() {
	std::cout << "Output: " << AsmFunction() << std::endl;
	return 0;
}
