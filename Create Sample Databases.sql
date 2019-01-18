/*
Run these two scripts against your source and destination servers (which could be the same server).  
These scripts will create some dummy tables we can play with.  We will not be moving any real data 
in this demo.  My goal is to simply illustrate the principles I am discussing with the simplest example possible.
*/

--1)Source Server
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE Name = 'MySourceDB')
BEGIN
	CREATE DATABASE MySourceDB;

	EXEC('CREATE TABLE MySourceDB.dbo.tbl_Customers (CustomerID INT IDENTITY, DummyData varchar(100))');
	
	EXEC('CREATE TABLE MySourceDB.dbo.tbl_Vendors (VendorID INT IDENTITY, DummyData varchar(100))');
	
END

--2)Staging Server (could be the same server!)
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE Name = 'MyStagingDB')
CREATE DATABASE MyStagingDB
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE Name = 'MyStagingDB' )AND NOT EXISTS (SELECT 1 FROM MyStagingDB.sys.tables WHERE Name = 'Customers')
BEGIN
	USE MyStagingDB
	
	EXEC('CREATE SCHEMA stg');
	
	EXEC('CREATE TABLE MyStagingDB.stg.Customers (CustomerID INT, DummyData varchar(100))');

	EXEC('CREATE TABLE MyStagingDB.stg.Vendors (VendorID INT, DummyData varchar(100))');
END 



