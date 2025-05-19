--task1

--select * from sys.databases
--select * from sys.schemas
--select * from sys.tables
--select * from sys.columns
--select * from sys.types

DECLARE @INFOTABLE TABLE (databasename nvarchar(255), schemaname nvarchar(255), tablename nvarchar(255), columnname nvarchar(255), datatype nvarchar(50))
declare @sql_query nvarchar(max);
declare @databasename nvarchar(255);
declare @i int=1;
declare @counter int
select @counter =  count(1) from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')


while @i<=@counter
begin 
	;with cte1 as (
		select name, row_number() over(order by name) as rn from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
	)
	select @databasename=name from cte1
	where rn=@i;

	set @sql_query='
		use ' +quotename(@databasename)+ ';

		select 
		'''+@databasename+''' as databasename,
		s.name as schemaname,
		t.name as tablename,
		c.name as columnname,
		ty.name as datatype

		from sys.schemas s 
		join sys.tables t on s.schema_id=t.schema_id
		join sys.columns c on t.object_id=c.object_id
		join sys.types ty on c.user_type_id=ty.user_type_id
	';
	insert into @INFOTABLE
	exec(@sql_query)


	set @i=@i+1
end

	select * from @infotable


--==================

--tasks2

select * from sys.procedures
select * from sys.objects
select * from sys.sql_modules
select * from sys.schemas
select * from sys.parameters
select * from sys.types
select * from INFORMATION_SCHEMA.ROUTINES
select * from INFORMATION_SCHEMA.PARAMETERS 

go

alter proc info @databasename varchar(255)
as
begin 
	declare @sql_cm nvarchar(max)
	set @sql_cm= '
    USE ' + QUOTENAME(@databasename) + ';
    SELECT
        ''' + @databasename + ''' AS DatabaseName,
        o.name AS ProcedureName,
        SCHEMA_NAME(o.schema_id) AS SchemaName,
        p.name AS Variable,
        p.parameter_id AS ParameterOrder,
        t.name AS DataTypeName,
        p.max_length AS ParMaxLength,
        p.is_output AS IsOutput,
        t.max_length AS TypeMaxLength
    FROM
        sys.objects o
    LEFT JOIN
        sys.parameters p ON o.object_id = p.object_id
    LEFT JOIN
        sys.types t ON p.user_type_id = t.user_type_id
    WHERE
        o.type IN (''P'', ''FN'', ''IF'', ''TF''); -- Stored procedures and functions
    ';
	exec(@sql_cm);

end

exec info @databasename='Lesson_12'

