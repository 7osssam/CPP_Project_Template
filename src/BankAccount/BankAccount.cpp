#include <iostream>
#include "BankAccount.hpp"

BankAccount::BankAccount(int accountNumber, const std::string& accountHolder, const std::string& accountType,
						 double accountBalance) :
	accountNumber(accountNumber), accountHolder(accountHolder), accountType(accountType), accountBalance(accountBalance)
{
}

/**
 * @brief Get the account number.
 *
 * This function returns the account number associated with the bank account.
 *
 * @return The account number.
 */
int BankAccount::getAccountNumber() const
{
	return accountNumber;
}

/**
 * @brief The std::string type represents a sequence of characters.
 * 
 * It is a standard library class that provides a convenient way to manipulate strings in C++.
 * 
 * @see https://en.cppreference.com/w/cpp/string/basic_string
 */
const std::string& BankAccount::getAccountHolder() const
{
	return accountHolder;
}

/**
 * @brief Returns the account type.
 *
 * This function returns the account type as a constant reference to a string.
 *
 * @return A constant reference to the account type string.
 */
const std::string& BankAccount::getAccountType() const
{
	return accountType;
}

/**
 * @brief Get the current balance of the bank account.
 *
 * This function returns the current balance of the bank account.
 *
 * @return The current balance of the bank account.
 */
double BankAccount::getAccountBalance() const
{
	return accountBalance;
}

/**
 * @brief Deposits the specified amount into the bank account.
 *
 * This function adds the specified amount to the current account balance.
 * If the amount is greater than zero, the deposit is considered successful.
 * Otherwise, an error message is displayed.
 *
 * @param amount The amount to be deposited.
 */
void BankAccount::deposit(double amount)
{
	if (amount > 0)
	{
		accountBalance += amount;
		std::cout << "Deposit of $" << amount << " successful\n";
	}
	else
	{
		std::cerr << "Error: Deposit amount must be greater than zero\n";
	}
}

/**
 * @brief Withdraws the specified amount from the bank account.
 *
 * This function allows the user to withdraw a specified amount from the bank account.
 * If the withdrawal amount is greater than the account balance, an error message is displayed.
 *
 * @param amount The amount to be withdrawn from the account.
 * @return True if the withdrawal is successful, false otherwise.
 */
bool BankAccount::withdraw(double amount)
{
	if (amount > 0)
	{
		if (accountBalance >= amount)
		{
			accountBalance -= amount;
			std::cout << "Withdrawal of $" << amount << " successful\n";
			return true;
		}
		else
		{
			std::cerr << "Error: Insufficient funds\n";
		}
	}
	else
	{
		std::cerr << "Error: Withdrawal amount must be greater than zero\n";
	}
	return false;
}

/**
 * @brief Displays the account information.
 *
 * This function prints the account number, account holder, account type, and account balance
 * to the standard output.
 */
void BankAccount::displayAccountInfo() const
{
	std::cout << "Account Number: " << accountNumber << std::endl;
	std::cout << "Account Holder: " << accountHolder << std::endl;
	std::cout << "Account Type: " << accountType << std::endl;
	std::cout << "Account Balance: $" << accountBalance << std::endl;
}
