-- Enable xp_cmdshell
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- Connect to network drive

-- SERVER_IP: FQDN or IP address of remote share
-- SERVER_SHARE: share name
-- DOMAIN_NAME: Domain name or Server Name
-- LOGON_ID: User logon id of remote share
-- LOGON_PASSWORD: User logon password of remote share
EXEC XP_CMDSHELL 'net use R: \\SERVER_IP\SERVER_SHARE /user:DOMAIN_NAME\LOGON_ID "LOGON_PASSWORD"'
GO

-- Restore database
-- (database MUST exist)

-- DATABASE_NAME: Name of restored database
USE [master]
RESTORE DATABASE [DATABASE_NAME]
FROM  DISK = N'R:\DATABASE_NAME.bak'
WITH  FILE = 1, REPLACE
GO

-- Disconnect from network drive
EXEC XP_CMDSHELL 'net use /delete R:';

-- Disable xp_cmdshell
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE;
