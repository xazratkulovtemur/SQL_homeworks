declare @tr varchar(max);
with cte as 
	(select 
	t.name as TableName,
	i.name as IndexName,
	i.type_desc as IndexType,
	c.name as ColumnName,
	ty.name ColumnType
	from sys.indexes i
	join sys.index_columns ic on i.object_id=ic.object_id and i.index_id=ic.index_id
	join sys.columns c on ic.column_id=c.column_id and ic.object_id=c.object_id
	join sys.tables t on i.object_id=t.object_id
	join sys.types ty on ty.user_type_id=c.user_type_id
	where i.is_hypothetical=0
)
SELECT @tr = 
    CAST((
        SELECT 
            '<tr>' +
            '<td>' + TableName + '</td>' +
            '<td>' + IndexName + '</td>' +
            '<td>' + IndexType + '</td>' +
            '<td>' + ColumnName + '</td>' +
            '<td>' + ColumnType + '</td>' +
            '</tr>'
        FROM cte
        FOR XML PATH(''), TYPE
    ).value('.', 'VARCHAR(MAX)') AS VARCHAR(MAX));


declare @htmlbody varchar(max)='
	<html>
	<body>
	<h1>SQL Server Index Metadata Report</h1>
	<table>
            <tr>
                <th>Table Name</th>
                <th>Index Name</th>
                <th>Index Type</th>
                <th>Column Name</th>
                <th>Column Type</th>
            </tr>'
    + @tr +
    '</table>
    </body>
    </html>';
print @htmlbody

exec msdb.dbo.sp_send_dbmail
	@profile_name='GmailProfile',
	@recipients='khazratkulovtemur@gmail.com',
	@subject='Report',
	@body=@htmlbody,
	@body_format='HTML'

SELECT * FROM MSDB.DBO.sysmail_allitems