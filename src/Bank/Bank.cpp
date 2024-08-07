#include "Bank.hpp"
#include <iostream>

Bank::Bank() = default;

Bank::Bank(Bank&& obj) : accounts(std::move(obj.accounts))
{
	obj.accounts.clear();
}

void Bank::addAccount(const BankAccount& account)
{
	//accounts.push_back(account);

	//using move constructor to avoid copying the account object
	accounts.push_back(std::move(account));
}

double Bank::getTotalBalance() const
{
	double totalBalance = 0.0;

	if (!accounts.empty())
	{
		for (const auto& account: accounts)
		{
			totalBalance += account.getAccountBalance();
		}
	}
	return totalBalance;
}

void Bank::displayAllAccounts() const
{
	std::cout << "All Accounts:\n";
	if (!accounts.empty())
	{
		for (const auto& account: accounts)
		{
			std::cout << "==================================" << std::endl;
			account.displayAccountInfo();
			std::cout << "==================================" << std::endl;
		}
	}
	else
	{
		std::cout << "No accounts found\n";
	}
}

static bool compareAccountNumbers(const BankAccount& a, const BankAccount& b)
{
	return a.getAccountNumber() < b.getAccountNumber();
}

void Bank::SortAccounts()
{
	std::sort(accounts.begin(), accounts.end(), compareAccountNumbers);
}

// getter for accounts
std::vector<BankAccount> Bank::getAccounts() const
{
	return accounts;
}