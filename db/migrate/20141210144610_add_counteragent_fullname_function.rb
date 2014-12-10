class AddCounteragentFullnameFunction < ActiveRecord::Migration
  def change
	reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
			CREATE FUNCTION [dbo].[GetCounteragentFullName](@ID uniqueidentifier) RETURNS nvarchar(max) AS 
			BEGIN
				
				DECLARE @name nvarchar(max)

				SELECT @name = Name, @ID = ParentTreeRowID
				FROM [dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}]
				WHERE RowID = @ID

				WHILE @@ROWCOUNT > 0
					
					SELECT @name = Name + '/' + @name, @ID = ParentTreeRowID
					FROM [dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}]
					WHERE RowID = @ID

				RETURN @name
			END
        SQL
      end
      dir.down do
        execute <<-SQL
          DROP FUNCTION [dbo].[GetCounteragentFullName]
        SQL
      end
	end
  end
 end
