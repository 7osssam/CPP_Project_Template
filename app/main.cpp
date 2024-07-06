#include "Bank.hpp"
#include <iostream>
#include <nlohmann/json.hpp>

int main()
{
	// Test library linked correctly
	std::cout << "JSON Lib Version:" << NLOHMANN_JSON_VERSION_MAJOR << "." << NLOHMANN_JSON_VERSION_MINOR << "."
			  << NLOHMANN_JSON_VERSION_PATCH << "\n";

	std::cout << "Welcome to the Dummy Bank ;)\n";

	Bank bank;
	//BankAccount(int accountNumber, const std::string& accountHolder, const std::string& accountType,double accountBalance);
	BankAccount account1(101, "John Doe", "Savings", 1000);
	BankAccount account2(102, "Jane Doe", "Savings", 2000);
	BankAccount account3(103, "Jim Doe", "Savings", 3000);

	bank.addAccount(account1);
	bank.addAccount(account2);
	bank.addAccount(account3);

	std::cout << "Total Balance: " << bank.getTotalBalance() << std::endl;
	bank.displayAllAccounts();

	return 0;
}
