-- Backup Database
BACKUP DATABASE [database]
TO DISK = N'X:\database.bak' WITH NOFORMAT, INIT,
NAME = N'database backup', SKIP, REWIND, NOUNLOAD,  STATS = 10
GO

-- Zip database backup file with overwrite mode
DECLARE @logname varchar(50), @zipbak varchar(200)
SET @logname = 'X:\zipbak-' + CONVERT(CHAR(8), GETDATE(), 112) + '.log'
SET @zipbak = 'X:\7ZipCmd\7z a -aoa -tzip X:\database.bak.zip X:\database.bak -sdel >> ' + @logname
EXEC XP_CMDSHELL @zipbak
