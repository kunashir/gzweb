class ActiveRecord::Schema

  def create_dv_table(card_xml_file, section)
    p "Creating table for section #{section} from file #{card_xml_file}"
    card = Nokogiri::XML.parse(File.read("#{Rails.root}/db/#{card_xml_file}"))
    section = card.xpath("//Section[@Alias='#{section}']").first
    create_table "dvtable_{#{section["ID"]}}", id: false, force: true do |t|
      t.column 'RowID', 'uniqueidentifier', null: false
      t.column 'SysRowTimestamp', 'timestamp'
      t.column 'InstanceID', 'uniqueidentifier', null: false
      t.column 'ParentRowID', 'uniqueidentifier', null: false
      t.column 'ParentTreeRowID', 'uniqueidentifier', null: false
      unless card.root["SimpleSecurity"]
        t.column 'SDID', 'uniqueidentifier'
      end
      section.xpath("Field").select { |x| !x["Type"].nil? && !x["Alias"].nil? }.each do |field|
        t.column field["Alias"], field_type(field)    
      end
    end 
    execute "ALTER TABLE [dvtable_{#{section["ID"]}}] ADD PRIMARY KEY (RowID);"
    execute "ALTER TABLE [dvtable_{#{section["ID"]}}] ADD CONSTRAINT [dvtable_#{section["ID"]}_def_instanceid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [InstanceID];"
    execute "ALTER TABLE [dvtable_{#{section["ID"]}}] ADD CONSTRAINT [dvtable_#{section["ID"]}_def_parentrowid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ParentRowID];"
    execute "ALTER TABLE [dvtable_{#{section["ID"]}}] ADD CONSTRAINT [dvtable_#{section["ID"]}_def_parenttreerowid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ParentTreeRowID];"
    unless card.root["SimpleSecurity"]
      execute "ALTER TABLE [dbo].[dvtable_{#{section["ID"]}}] WITH NOCHECK ADD CONSTRAINT [dvtable_#{section["ID"]}_fk_sdid] FOREIGN KEY([SDID]) REFERENCES [dbo].[dvsys_security] ([ID]);"
      execute "ALTER TABLE [dbo].[dvtable_{#{section["ID"]}}] CHECK CONSTRAINT [dvtable_#{section["ID"]}_fk_sdid];"
    end
  end

  def field_type(field)
    case field["Type"]
      when "int", "enum"
        return "int"
      when "uniqueid", "refid", "refcardid", "sdid"
        return "uniqueidentifier"
      when "bool"
        return "bit"
      when "unitext"
        return "ntext"
      when "string"
        if field["Max"].nil?
          return "varchar(max)"
        else
          return "varchar(#{field["Max"]})"
        end
      when "unistring"
        if field["Max"].nil?
          return "nvarchar(max)"
        else
          return "nvarchar(#{field["Max"]})"
        end
      when "image"
        return "varbinary(max)"
      when "datetime"
        return "datetime"
      when "variant"
        return "sql_variant"
    end
  end

  def install_dv_reports(cardlib_xml_file)
    p "Installing reports for card library #{cardlib_xml_file}"
    dir = File.dirname("#{Rails.root}/db/#{cardlib_xml_file}")
    cardlib = Nokogiri::XML.parse(File.read("#{Rails.root}/db/#{cardlib_xml_file}"))
    cardlib.xpath("//Report").each do |report|
      begin
        sql = "CREATE PROCEDURE [dbo].[dvreport_get_data_{#{report["ID"]}}] "
        parameters = report.xpath("Parameter")
        if parameters.length > 0
          sql += "("
          first = true
          parameters.each do |parameter|
            sql += ", " unless first
            sql += "@" + parameter["Name"] + " " + report_parameter_type(parameter["Type"])
            first = false
          end
          sql += ") "
        end
        sql += "AS "
        body = File.read("#{dir}/#{report["SQLFile"]}")
        if body.getbyte(0) == 255 && body.getbyte(1) == 254
          body = File.read("#{dir}/#{report["SQLFile"]}", encoding: 'UTF-16')
        end
        unless body =~ /^(\s*)BEGIN/i
          sql += "BEGIN "
        end
        sql += body
        unless body =~ /END(\s*)$/i
          sql += " END"
        end
        execute sql
        p "Installed report #{report["Alias"]}"
      rescue
        p "Failed to install report #{report["Alias"]}"
      end
    end
  end

  def report_parameter_type(type)
    case type
      when "string"
        return "nvarchar(max)"
      when "integer"
        return "int"
      when "datetime"
        return "datetime"
      when "bool"
        return "bit"
      when "uniqueidentifier"
        return "uniqueidentifier"
      else
        raise "Unknown report parameter type: '#{type}'"
    end
  end
end