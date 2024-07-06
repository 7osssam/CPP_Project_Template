
#include "Bank.hpp"
#include <gtest/gtest.h>

// Google Test (Test creating an account)
TEST(BankAccountSystem, CreateAccount)
{
	double acc1_amount = 1000.0;

	// Test creating an account
	BankAccount account1{123, "Hossam", "SILVER", acc1_amount};

	ASSERT_EQ(account1.getAccountBalance(), acc1_amount);
}

// Google Test (Test depositing and withdrawing funds)
TEST(BankAccountSystem, DepositAndWithdraw)
{
	double initial_amount = 1000.0;
	double deposit_amount = 500.0;
	double withdraw_amount = 300.0;

	BankAccount account{123, "Hossam", "SILVER", initial_amount};

	// Test depositing funds
	account.deposit(deposit_amount);
	ASSERT_EQ(account.getAccountBalance(), initial_amount + deposit_amount);

	// Test withdrawing funds
	account.withdraw(withdraw_amount);
	ASSERT_EQ(account.getAccountBalance(), initial_amount + deposit_amount - withdraw_amount);
}

// Google Test (Test adding accounts to the bank and getting total balance)
TEST(BankAccountSystem, BankTotalBalance)
{
	Bank bank_account{};

	double acc1_amount = 1000.0;
	double acc2_amount = 2000.0;

	BankAccount account1{123, "Hossam", "SILVER", acc1_amount};
	BankAccount account2{456, "Kareem", "GOLD", acc2_amount};

	bank_account.addAccount(account1);
	bank_account.addAccount(account2);

	ASSERT_EQ(bank_account.getTotalBalance(), acc1_amount + acc2_amount);
}

// Google Test (Test sorting accounts)
TEST(BankAccountSystem, SortAccounts)
{
	Bank bank_account{};

	BankAccount account1{123, "Hossam", "SILVER", 1000.0};
	BankAccount account2{456, "Kareem", "GOLD", 2000.0};
	BankAccount account3{100, "Ahmed", "SILVER", 500.0};

	bank_account.addAccount(account1);
	bank_account.addAccount(account2);
	bank_account.addAccount(account3);

	bank_account.SortAccounts();
	const auto& accounts = bank_account.getAccounts();

	ASSERT_EQ(accounts[0].getAccountNumber(), 100);
	ASSERT_EQ(accounts[1].getAccountNumber(), 123);
	ASSERT_EQ(accounts[2].getAccountNumber(), 456);
}
